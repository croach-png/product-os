#!/bin/bash
# Project Doc Validation Hook
# Fires on PostToolUse for Write/Edit — checks project docs for required sections
# Warns but does not block (exits 0 always)
#
# Required sections for project/experiment docs:
#   Objective, Hypothesis, Evidence, Success Measures, Experiment Details, Risks

# Read the tool input from stdin (JSON with tool_name, file_path, etc.)
INPUT=$(cat)

# Extract the file path from the hook input
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; data = json.load(sys.stdin); print(data.get('tool_input', {}).get('file_path', data.get('tool_input', {}).get('filePath', '')))" 2>/dev/null)

# Exit immediately if not a projects/ file or not a markdown file
if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

if [[ "$FILE_PATH" != *"/projects/"* ]] || [[ "$FILE_PATH" != *.md ]]; then
    exit 0
fi

# Skip non-experiment files (discovery docs, design reviews, personal learning, etc.)
if [[ "$FILE_PATH" == *"/discovery/"* ]] || [[ "$FILE_PATH" == *"/design-reviews/"* ]] || [[ "$FILE_PATH" == *"/personal-learning/"* ]]; then
    exit 0
fi

# Check file exists
if [[ ! -f "$FILE_PATH" ]]; then
    exit 0
fi

# Required sections (case-insensitive heading check)
REQUIRED_SECTIONS=("Objective" "Hypothesis" "Evidence" "Success [Mm]easures" "Experiment [Dd]etails" "Risks")
MISSING=()

for section in "${REQUIRED_SECTIONS[@]}"; do
    if ! grep -qiE "^#{1,3}\s+${section}" "$FILE_PATH"; then
        # Clean up regex chars for display
        DISPLAY_NAME=$(echo "$section" | sed 's/\[.*\]//g; s/  / /g')
        MISSING+=("$DISPLAY_NAME")
    fi
done

# Report missing sections (stdout is injected into Claude's context)
if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "PROJECT DOC VALIDATION WARNING"
    echo "File: $FILE_PATH"
    echo "Missing required sections: ${MISSING[*]}"
    echo "Project/experiment docs should include: Objective, Hypothesis, Evidence, Success Measures, Experiment Details, Risks"
    echo "Please add the missing sections to ensure this document meets the PM playbook standard."
fi

# Always exit 0 — warn only, never block
exit 0
