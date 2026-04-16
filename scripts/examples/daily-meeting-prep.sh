#!/bin/bash
# Example: Daily meeting prep automation
#
# This is a canonical example of how to write an automated agent script.
# It runs the Chief of Staff agent to generate a daily briefing.
#
# The pattern:
#   1. Source lib.sh and initialise
#   2. Guard checks (working day, dedup, hour)
#   3. Wait for workspace access
#   4. Kill stale Claude processes
#   5. Acquire Claude lock (serialise automation calls)
#   6. Run Claude with a prompt file
#   7. Post results to Slack
#   8. Release lock and mark completion

set -euo pipefail

# Source the shared library
source "${DEPLOY_DIR:-${HOME}/.local/bin/pm-workspace}/lib.sh" 2>/dev/null \
    || source "$(dirname "$0")/../lib.sh" 2>/dev/null || true
mw_init "daily-meeting-prep"
mw_trap_errors

# --- Guards ---
mw_skip_if_not_working_day "${1:-}"

MARKER="${LOG_DIR}/.daily-meeting-prep-marker"
mw_skip_if_already_run_today "$MARKER" "${1:-}"

# --- Pre-flight ---
mw_wait_for_workspace_access || { mw_log "TCC blocked"; exit 1; }

# --- Prompt file ---
PROMPT_FILE="${DEPLOY_DIR}/daily-meeting-prep-prompt.txt"
mw_preflight_prompt "$PROMPT_FILE" || exit 1

cd "$WORKSPACE"

# --- Kill stale processes and acquire lock ---
mw_kill_stale_claude "meeting-prep"
mw_acquire_claude_lock

# --- Run Claude ---
mw_log "Starting daily meeting prep"
mw_run_claude "$PROMPT_FILE" "Read,Write,Glob,Grep,Bash,mcp__claude_ai_Google_Calendar__list_events,mcp__claude_ai_Granola__list_meetings"

# --- Release lock ---
mw_release_claude_lock

# --- Post to Slack ---
if [[ "$MW_EXIT_CODE" -eq 0 ]]; then
    # SETUP: Replace with your Slack webhook env var
    mw_post_slack "${SLACK_WEBHOOK_COS:-}" "Daily prep completed — $(date '+%A %-d %B')"
    mw_mark_today "$MARKER"
    mw_log "Completed successfully"
else
    mw_log "Failed (exit code ${MW_EXIT_CODE})"
    exit "$MW_EXIT_CODE"
fi
