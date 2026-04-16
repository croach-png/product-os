#!/bin/bash
# Shared Telegram notification helper — sourced by automation scripts
# Sends a message to the configured Telegram chat via Bot API
#
# Usage:
#   source scripts/notify-telegram.sh
#   send_telegram "Your message here"
#   send_telegram_failure "script-name" "/path/to/logfile"
#
# Requires TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID in .env

# --- Bank holiday and working day helpers ---

BANK_HOLIDAYS_FILE="${DEPLOY_DIR:-${HOME}/.local/bin/pm-workspace}/bank-holidays.txt"

# Returns 0 (true) if the given date (or today) is a bank holiday
is_bank_holiday() {
    local check_date="${1:-$(date '+%Y-%m-%d')}"
    if [[ ! -f "$BANK_HOLIDAYS_FILE" ]]; then
        return 1
    fi
    grep -q "^${check_date}" "$BANK_HOLIDAYS_FILE" 2>/dev/null
}

# Returns 0 (true) if today is a working day (Mon-Fri, not a bank holiday)
is_working_day() {
    local day_of_week
    day_of_week=$(date '+%u')
    if [[ "$day_of_week" -gt 5 ]]; then
        return 1
    fi
    if is_bank_holiday; then
        return 1
    fi
    return 0
}

send_telegram() {
    local message="$1"

    if [[ -z "${TELEGRAM_BOT_TOKEN:-}" ]] || [[ -z "${TELEGRAM_CHAT_ID:-}" ]]; then
        return 0
    fi

    if [[ -z "$message" ]]; then
        return 0
    fi

    if [[ ${#message} -gt 4000 ]]; then
        message="${message:0:3990}

_(truncated)_"
    fi

    local response
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
        -H "Content-Type: application/json" \
        -d "$(python3 -c "
import json, sys
print(json.dumps({
    'chat_id': '${TELEGRAM_CHAT_ID}',
    'text': sys.stdin.read(),
    'parse_mode': 'Markdown',
    'disable_web_page_preview': True,
}))
" <<< "$message")")

    if [[ "$response" != "200" ]]; then
        response=$(curl -s -o /dev/null -w "%{http_code}" \
            -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
            -H "Content-Type: application/json" \
            -d "$(python3 -c "
import json, sys
print(json.dumps({
    'chat_id': '${TELEGRAM_CHAT_ID}',
    'text': sys.stdin.read(),
    'disable_web_page_preview': True,
}))
" <<< "$message")")
    fi

    echo "$response" >&2
}

send_telegram_failure() {
    local script_name="$1"
    local log_file="$2"
    local log_tail=""

    if [[ -f "$log_file" ]]; then
        log_tail=$(tail -10 "$log_file" 2>/dev/null || true)
    fi

    local message="*:x: Automation failed: ${script_name}*

_$(date '+%A %-d %B, %H:%M')_"

    if [[ -n "$log_tail" ]]; then
        message="${message}

\`\`\`
${log_tail}
\`\`\`"
    fi

    send_telegram "$message"
}
