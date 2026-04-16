#!/bin/bash
# Command Completion Notification Hook
# Fires on PostToolUse for Bash and BigQuery — sends macOS notification
# when potentially long-running commands complete.
#
# Useful when tabbing away during data queries, script runs, or git pushes.

INPUT=$(cat)

# Extract tool name and command
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))" 2>/dev/null)
COMMAND=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('command', ''))" 2>/dev/null)

# For BigQuery MCP tool, always notify
if [[ "$TOOL_NAME" == *"BigQuery"* ]]; then
    SQL=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('sql', '')[:60])" 2>/dev/null)
    osascript -e "display notification \"$SQL\" with title \"Claude Code\" subtitle \"BigQuery query completed\"" 2>/dev/null
    exit 0
fi

# For Bash, only notify for commands likely to take a while
if [[ "$COMMAND" == *"python3 scripts/"* ]] || \
   [[ "$COMMAND" == *"git push"* ]] || \
   [[ "$COMMAND" == *"git pull"* ]] || \
   [[ "$COMMAND" == *"pip install"* ]] || \
   [[ "$COMMAND" == *"npm install"* ]] || \
   [[ "$COMMAND" == *"gcloud"* ]]; then
    SHORT_CMD=$(echo "$COMMAND" | cut -c1-60)
    osascript -e "display notification \"$SHORT_CMD\" with title \"Claude Code\" subtitle \"Command completed\"" 2>/dev/null
fi

exit 0
