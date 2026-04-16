#!/bin/bash
# Shared library for PM workspace automation scripts
#
# Source this at the top of automation scripts to get standard paths,
# environment loading, and common helper functions.
#
# Usage:
#   source "${DEPLOY_DIR:-${HOME}/.local/bin/pm-workspace}/lib.sh" 2>/dev/null \
#     || source "$(dirname "$0")/lib.sh" 2>/dev/null || true
#   mw_init "script-name"

# === Standard paths ===

WORKSPACE="${PM_WORKSPACE:-${HOME}/Documents/pm-workspace}"
DEPLOY_DIR="${HOME}/.local/bin/pm-workspace"
CLAUDE="/opt/homebrew/bin/claude"
LOG_DIR="${DEPLOY_DIR}/logs"
ENV_FILE="${DEPLOY_DIR}/.env"
TODAY=$(date '+%Y-%m-%d')
# Week key = date of Monday this week (ISO day of week: 1=Mon, 7=Sun)
_mw_dow=$(date '+%u')
WEEK=$(date -v-$(( _mw_dow - 1 ))d '+%Y-%m-%d')
unset _mw_dow
MW_SKIP_EXIT=2

# === TCC / Full Disk Access ===

# Wait for macOS TCC to allow access to the workspace (Documents folder).
# launchd agents may lack Full Disk Access for /bin/bash. If direct access
# fails after retries, returns 1 with a diagnostic message on stderr.
mw_wait_for_workspace_access() {
    if ls "$WORKSPACE" >/dev/null 2>&1; then
        return 0
    fi

    local attempt=0 delay=3
    while [[ "$attempt" -lt 4 ]]; do
        sleep "$delay"
        if ls "$WORKSPACE" >/dev/null 2>&1; then
            return 0
        fi
        attempt=$(( attempt + 1 ))
        delay=$(( delay * 2 ))
    done

    echo "TCC_BLOCKED" >&2
    return 1
}

# === Initialisation ===

# Set up the environment for a script: create dirs, load env, load notification helper.
# Usage: mw_init "script-name"
mw_init() {
    local script_name="${1:-unknown}"
    MW_SCRIPT_NAME="$script_name"
    MW_LOG_FILE="${LOG_DIR}/${script_name}.log"

    mkdir -p "$LOG_DIR"

    # Load .env
    if [[ -f "$ENV_FILE" ]]; then
        set -a
        source "$ENV_FILE" 2>/dev/null || true
        set +a
    fi

    # Load notification helper
    source "${DEPLOY_DIR}/notify-telegram.sh" 2>/dev/null \
        || source "${WORKSPACE}/scripts/notify-telegram.sh" 2>/dev/null || true

    # Allow running from within a Claude Code session
    unset CLAUDECODE
}

# Timestamped log message to the script's log file.
mw_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') — $*" >> "$MW_LOG_FILE"
}

# === Dedup and gating ===

# Log a skip reason and exit with MW_SKIP_EXIT (2).
mw_exit_skip() {
    mw_log "Skipped ($1)"
    exit $MW_SKIP_EXIT
}

# Decimal-safe hour (strips leading zero to avoid octal issues).
mw_hour() {
    date '+%H' | sed 's/^0//'
}

# Skip if not a working day (weekend or bank holiday).
mw_skip_if_not_working_day() {
    [[ "${1:-}" == "--force" ]] && return 0
    if ! is_working_day; then
        mw_exit_skip "not a working day"
    fi
    return 0
}

# Skip if already run today.
mw_skip_if_already_run_today() {
    local marker="$1"
    [[ "${2:-}" == "--force" ]] && return 0
    if [[ -f "$marker" ]] && [[ "$(cat "$marker")" == "$TODAY" ]]; then
        mw_exit_skip "already run today"
    fi
    return 0
}

# Skip if already run this ISO week.
mw_skip_if_already_run_week() {
    local marker="$1"
    [[ "${2:-}" == "--force" ]] && return 0
    if [[ -f "$marker" ]] && [[ "$(cat "$marker")" == "$WEEK" ]]; then
        mw_exit_skip "already run week ${WEEK}"
    fi
    return 0
}

# Mark today's run as complete.
mw_mark_today() {
    echo "$TODAY" > "$1"
}

# Mark this week's run as complete.
mw_mark_week() {
    echo "$WEEK" > "$1"
}

# === Error trapping ===

mw_trap_errors() {
    trap 'mw_log "UNEXPECTED EXIT at line $LINENO (exit code $?)"' ERR
}

# === Claude lock (serialise automation Claude calls) ===

MW_CLAUDE_LOCK="${LOG_DIR}/.claude-automation-lock"

# Acquire an exclusive lock before calling Claude. Waits up to 5 minutes,
# checking every 10s. Cleans up stale locks from dead processes.
mw_acquire_claude_lock() {
    local max_wait=300 waited=0
    while [[ -f "$MW_CLAUDE_LOCK" ]] && [[ "$waited" -lt "$max_wait" ]]; do
        local lock_pid
        lock_pid=$(cat "$MW_CLAUDE_LOCK" 2>/dev/null) || true
        if [[ -n "$lock_pid" ]] && ! kill -0 "$lock_pid" 2>/dev/null; then
            mw_log "Removing stale Claude lock (PID $lock_pid dead)"
            rm -f "$MW_CLAUDE_LOCK"
            break
        fi
        sleep 10
        waited=$(( waited + 10 ))
    done
    if [[ -f "$MW_CLAUDE_LOCK" ]] && [[ "$waited" -ge "$max_wait" ]]; then
        mw_log "Claude lock timeout after ${max_wait}s — proceeding anyway"
        rm -f "$MW_CLAUDE_LOCK"
    fi
    echo $$ > "$MW_CLAUDE_LOCK"
}

# Release the Claude lock. Safe to call multiple times.
mw_release_claude_lock() {
    local lock_pid
    lock_pid=$(cat "$MW_CLAUDE_LOCK" 2>/dev/null) || true
    if [[ "$lock_pid" == "$$" ]]; then
        rm -f "$MW_CLAUDE_LOCK"
    fi
}

# === Stale process cleanup ===

# Kill Claude processes matching a pattern that are older than 15 minutes.
mw_kill_stale_claude() {
    local pattern="$1"
    while IFS= read -r pid; do
        if [[ -n "$pid" ]]; then
            local etime_str elapsed=0
            etime_str=$(ps -o etime= -p "$pid" 2>/dev/null | tr -d ' ') || true
            if [[ -n "$etime_str" ]]; then
                local parts
                IFS=: read -ra parts <<< "${etime_str//-/:}"
                local i len=${#parts[@]}
                for (( i=0; i<len; i++ )); do
                    case $(( len - i )) in
                        4) elapsed=$(( elapsed + ${parts[i]#0} * 86400 )) ;;
                        3) elapsed=$(( elapsed + ${parts[i]#0} * 3600 )) ;;
                        2) elapsed=$(( elapsed + ${parts[i]#0} * 60 )) ;;
                        1) elapsed=$(( elapsed + ${parts[i]#0} )) ;;
                    esac
                done
            fi
            if [[ "$elapsed" -gt 900 ]]; then
                mw_log "Killing stale Claude process (PID $pid, ${elapsed}s old)"
                kill "$pid" 2>/dev/null || true
            fi
        fi
    done < <(pgrep -f "claude.*--print.*${pattern}" 2>/dev/null || true)
}

# === Pre-flight checks ===

mw_preflight_claude() {
    local test_output
    test_output=$($CLAUDE --print -p "ok" 2>&1) || true

    if echo "$test_output" | grep -qi "not logged in\|authentication\|unauthorized"; then
        mw_log "PREFLIGHT FAIL: Claude auth broken — ${test_output}"
        echo "PREFLIGHT:AUTH" >&2
        return 1
    fi

    if [[ -z "$test_output" ]]; then
        mw_log "PREFLIGHT FAIL: Claude returned empty output"
        echo "PREFLIGHT:EMPTY" >&2
        return 1
    fi

    return 0
}

mw_preflight_prompt() {
    local prompt_file="$1"
    if [[ ! -f "$prompt_file" ]]; then
        mw_log "PREFLIGHT FAIL: Prompt file not found — ${prompt_file}"
        echo "PREFLIGHT:MISSING_FILE:${prompt_file}" >&2
        return 1
    fi
    if [[ ! -r "$prompt_file" ]]; then
        mw_log "PREFLIGHT FAIL: Prompt file not readable — ${prompt_file}"
        echo "PREFLIGHT:PERMISSION:${prompt_file}" >&2
        return 1
    fi
    return 0
}

# === Claude execution ===

# Run Claude with a prompt file, log output, and retry once on failure.
# Usage: mw_run_claude "$PROMPT_FILE" "Read,Write,Glob,Grep,Bash" [model]
mw_run_claude() {
    local prompt_file="$1"
    local allowed_tools="$2"
    local model="${3:-sonnet}"

    if ! mw_preflight_claude; then
        MW_EXIT_CODE=1
        return
    fi

    local output_file
    output_file=$(mktemp "${TMPDIR:-/tmp}/${MW_SCRIPT_NAME}-output.XXXXXX")

    set +e
    $CLAUDE --print \
      --model "$model" \
      --allowedTools "$allowed_tools" \
      < "$prompt_file" > "$output_file" 2>&1
    MW_EXIT_CODE=$?
    set -e

    if [[ -s "$output_file" ]]; then
        echo "--- Claude output (last 30 lines) ---" >> "$MW_LOG_FILE"
        tail -30 "$output_file" >> "$MW_LOG_FILE"
        echo "--- End Claude output ---" >> "$MW_LOG_FILE"
    fi

    # Retry once on failure
    if [[ "$MW_EXIT_CODE" -ne 0 ]]; then
        mw_log "First attempt failed (exit code $MW_EXIT_CODE), retrying in 10s..."
        sleep 10
        set +e
        $CLAUDE --print \
          --model "$model" \
          --allowedTools "$allowed_tools" \
          < "$prompt_file" > "$output_file" 2>&1
        MW_EXIT_CODE=$?
        set -e
        if [[ -s "$output_file" ]]; then
            echo "--- Claude retry output (last 30 lines) ---" >> "$MW_LOG_FILE"
            tail -30 "$output_file" >> "$MW_LOG_FILE"
            echo "--- End Claude retry output ---" >> "$MW_LOG_FILE"
        fi
    fi

    rm -f "$output_file"
}

# === Slack webhooks ===

# Post a text message to a Slack webhook.
# Usage: mw_post_slack "$SLACK_WEBHOOK_URL" "message text"
mw_post_slack() {
    local webhook_url="$1"
    local message="$2"
    if [[ -z "$webhook_url" ]]; then
        mw_log "Skipped Slack post (no webhook configured)"
        return 0
    fi
    local payload
    payload=$(python3 -c "import json, re, sys; print(json.dumps({'text': re.sub(r'~(?=\d)', '\u2248', sys.argv[1])}))" "$message" 2>/dev/null)
    local response
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        -X POST -H 'Content-type: application/json' \
        --data "$payload" \
        "$webhook_url" 2>/dev/null || echo "000")
    if [[ "$response" == "200" ]]; then
        mw_log "Posted to Slack (HTTP 200)"
    else
        mw_log "Slack webhook failed (HTTP ${response})"
    fi
}

# Post contents of a file to a Slack webhook.
# Usage: mw_post_slack_file "$SLACK_WEBHOOK_URL" "/path/to/file.md"
mw_post_slack_file() {
    local webhook_url="$1"
    local source_file="$2"
    if [[ -z "$webhook_url" ]]; then
        mw_log "Skipped Slack post (no webhook configured)"
        return 0
    fi
    if [[ ! -f "$source_file" ]]; then
        mw_log "Skipped Slack post (file not found: $source_file)"
        return 0
    fi
    local payload
    payload=$(python3 -c "
import json, re, sys
with open(sys.argv[1], 'r') as f:
    content = f.read()
content = re.sub(r'~(?=\d)', '\u2248', content)
print(json.dumps({'text': content}))" "$source_file" 2>/dev/null)
    if [[ -z "$payload" ]]; then
        mw_log "ERROR: Failed to build Slack payload from $source_file"
        return 0
    fi
    local response
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        -X POST -H 'Content-type: application/json' \
        --data "$payload" \
        "$webhook_url" 2>/dev/null || echo "000")
    if [[ "$response" == "200" ]]; then
        mw_log "Posted to Slack (HTTP 200)"
    else
        mw_log "Slack webhook failed (HTTP ${response})"
    fi
}
