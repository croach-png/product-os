#!/bin/bash
# Wrapper script for all launchd automations — catches failures and alerts.
#
# Usage (in plist ProgramArguments):
#   /bin/bash ~/.local/bin/pm-workspace/run-with-alert.sh <script-path> [args...]
#
# What it does:
#   1. Runs the target script
#   2. On failure: sends alerts via Telegram AND Slack
#   3. On success: sends Slack notification
#   4. Always exits with the script's original exit code
#
# Requires in .env:
#   TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID — for Telegram alerts (optional)
#   SLACK_WEBHOOK_URL — for Slack alerts (optional)

DEPLOY_DIR="${HOME}/.local/bin/pm-workspace"
SCRIPT="$1"
shift

if [[ -z "$SCRIPT" ]]; then
    echo "Usage: run-with-alert.sh <script-path> [args...]" >&2
    exit 1
fi

SCRIPT_NAME=$(basename "$SCRIPT" .sh)

# --- High-frequency jobs (logged, not individually alerted on success) ---
HIGH_FREQUENCY="daily-meeting-prep post-meeting-actions"

is_high_frequency() {
    for job in $HIGH_FREQUENCY; do
        [[ "$SCRIPT_NAME" == "$job" ]] && return 0
    done
    return 1
}

# --- Load env and notification helper ---
if [[ -f "${DEPLOY_DIR}/.env" ]]; then
    set -a
    source "${DEPLOY_DIR}/.env" 2>/dev/null || true
    set +a
fi
source "${DEPLOY_DIR}/notify-telegram.sh" 2>/dev/null || true

# --- Slack webhook helper ---
send_slack_alert() {
    local message="$1"
    if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
        return 1
    fi

    local payload
    payload=$(python3 -c "
import json, sys
print(json.dumps({'text': sys.stdin.read()}))
" <<< "$message" 2>/dev/null)

    curl -s -o /dev/null -w "%{http_code}" \
        -X POST -H 'Content-type: application/json' \
        --data "$payload" \
        "$SLACK_WEBHOOK_URL" 2>/dev/null
}

# --- Daily run history log ---
RUN_HISTORY="${DEPLOY_DIR}/logs/run-history.log"
mkdir -p "${DEPLOY_DIR}/logs"

log_run() {
    local status="$1"
    local exit_code="$2"
    echo "$(date '+%Y-%m-%d %H:%M')|${SCRIPT_NAME}|${status}|${exit_code}" >> "$RUN_HISTORY"
}

# --- Run the script, capturing stderr ---
STDERR_FILE=$(mktemp /tmp/pm-workspace-stderr-XXXXXX)
ERROR_LOG="${DEPLOY_DIR}/logs/${SCRIPT_NAME}-error.log"
START_TIME=$(date +%s)
/bin/bash "$SCRIPT" "$@" 2>"$STDERR_FILE"
EXIT_CODE=$?
END_TIME=$(date +%s)
DURATION=$(( END_TIME - START_TIME ))

# Persist stderr to error log for post-mortem debugging
if [[ -s "$STDERR_FILE" ]]; then
    echo "--- $(date '+%Y-%m-%d %H:%M:%S') | exit code ${EXIT_CODE} ---" >> "$ERROR_LOG"
    cat "$STDERR_FILE" >> "$ERROR_LOG"
fi

# Format duration
if [[ "$DURATION" -ge 60 ]]; then
    DURATION_STR="$(( DURATION / 60 ))m $(( DURATION % 60 ))s"
else
    DURATION_STR="${DURATION}s"
fi

# --- Skip (exit code 2) — log only, suppress all alerts ---
if [[ "$EXIT_CODE" -eq 2 ]]; then
    log_run "SKIP" "2"
    rm -f "$STDERR_FILE"
    exit 0

# --- Alert on failure ---
elif [[ "$EXIT_CODE" -ne 0 ]]; then
    STDERR_TAIL=$(tail -15 "$STDERR_FILE" 2>/dev/null)
    log_run "FAIL" "$EXIT_CODE"

    # Categorise stderr for the alert
    FAIL_HINT=""
    if echo "$STDERR_TAIL" | grep -qi "not logged in\|PREFLIGHT:AUTH"; then
        FAIL_HINT=" — *Claude auth failure*"
    elif echo "$STDERR_TAIL" | grep -qi "PREFLIGHT:MISSING_FILE"; then
        FAIL_HINT=" — *missing prompt/config file*"
    elif echo "$STDERR_TAIL" | grep -qi "ModuleNotFoundError"; then
        FAIL_HINT=" — *missing Python module*"
    elif echo "$STDERR_TAIL" | grep -qi "Operation not permitted"; then
        FAIL_HINT=" — *macOS permission denied*"
    fi

    # --- Telegram alert ---
    TG_MESSAGE="*Automation failed: ${SCRIPT_NAME}*${FAIL_HINT}
_Exit code ${EXIT_CODE} — $(date '+%A %-d %B, %H:%M') (${DURATION_STR})_"

    if [[ -n "$STDERR_TAIL" ]]; then
        TG_MESSAGE="${TG_MESSAGE}

\`\`\`
${STDERR_TAIL}
\`\`\`"
    fi

    send_telegram "$TG_MESSAGE" 2>/dev/null || true

    # --- Slack alert ---
    SLACK_MESSAGE=":x: *Automation failed: ${SCRIPT_NAME}*${FAIL_HINT}
Exit code ${EXIT_CODE} — $(date '+%A %-d %B, %H:%M') (${DURATION_STR})"

    if [[ -n "$STDERR_TAIL" ]]; then
        SLACK_MESSAGE="${SLACK_MESSAGE}

\`\`\`
${STDERR_TAIL}
\`\`\`"
    fi

    send_slack_alert "$SLACK_MESSAGE" 2>/dev/null || true

# --- On success ---
else
    log_run "OK" "0"
    SLACK_SUCCESS=":white_check_mark: *${SCRIPT_NAME}* completed — $(date '+%A %-d %B, %H:%M') (${DURATION_STR})"
    send_slack_alert "$SLACK_SUCCESS" 2>/dev/null || true
fi

rm -f "$STDERR_FILE"
exit $EXIT_CODE
