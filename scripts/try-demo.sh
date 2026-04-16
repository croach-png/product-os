#!/bin/bash
# Try the PM workspace with pre-populated demo data.
#
# Usage:
#   bash scripts/try-demo.sh              # interactive — choose a demo
#   bash scripts/try-demo.sh velo         # use the Velo (bike marketplace) demo
#   bash scripts/try-demo.sh nestfind      # use the NestFind (rental marketplace) demo
#   bash scripts/try-demo.sh --clean      # remove demo data and restore templates

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$SCRIPT_DIR/.." && pwd)"
DEMO_DIR="$WORKSPACE/demo"

# Files the demo populates
DEMO_FILES=(
    "context/company.md"
    "context/product.md"
    "context/current-priorities.md"
    "context/personas/customer-personas.md"
    "data/funnel-context.md"
)

clean_demo() {
    echo "Restoring template files..."
    git -C "$WORKSPACE" checkout -- "${DEMO_FILES[@]}" 2>/dev/null || {
        echo "Could not restore via git. You may need to manually revert the files."
        exit 1
    }
    echo "Done. Template files restored to their original state."
}

install_demo() {
    local demo_name="$1"
    local source="$DEMO_DIR/$demo_name"

    if [[ ! -d "$source" ]]; then
        echo "Error: demo '$demo_name' not found in $DEMO_DIR"
        exit 1
    fi

    echo "Installing '$demo_name' demo data..."
    for file in "${DEMO_FILES[@]}"; do
        if [[ -f "$source/$file" ]]; then
            cp "$source/$file" "$WORKSPACE/$file"
            echo "  ✓ $file"
        fi
    done

    # Set up a team directory for the demo
    mkdir -p "$WORKSPACE/team/DEMO/agents/state"
    mkdir -p "$WORKSPACE/team/DEMO/agents/memory"
    if [[ -f "$WORKSPACE/team/TEMPLATE/todo_list.md" ]]; then
        cp "$WORKSPACE/team/TEMPLATE/todo_list.md" "$WORKSPACE/team/DEMO/todo_list.md" 2>/dev/null || true
    fi
    if [[ -f "$WORKSPACE/team/TEMPLATE/agents/memory/shared.md" ]]; then
        cp "$WORKSPACE/team/TEMPLATE/agents/memory/shared.md" "$WORKSPACE/team/DEMO/agents/memory/shared.md" 2>/dev/null || true
    fi

    echo ""
    echo "✅ Demo installed. You're ready to go!"
    echo ""
    echo "Next steps:"
    echo "  1. Open Claude Code in this directory"
    echo "  2. Try:  /investigate Why is our listing completion rate dropping?"
    echo "  3. Try:  /prototype Improve the seller onboarding experience"
    echo "  4. Try:  /review-design Sellers abandon because the process feels too long"
    echo ""
    echo "When you're done, run:  bash scripts/try-demo.sh --clean"
}

# Handle arguments
case "${1:-}" in
    --clean)
        clean_demo
        ;;
    velo|nestfind)
        install_demo "$1"
        ;;
    "")
        echo "PM Workspace — Demo Setup"
        echo ""
        echo "Choose a demo company to try the workspace with:"
        echo ""
        echo "  1) Velo      — A fictional online bike marketplace (Bristol, Series A)"
        echo "  2) NestFind  — A fictional rental property marketplace (Manchester, Series B)"
        echo ""
        read -rp "Enter 1 or 2: " choice
        case "$choice" in
            1) install_demo "velo" ;;
            2) install_demo "nestfind" ;;
            *) echo "Invalid choice. Run again and enter 1 or 2." ; exit 1 ;;
        esac
        ;;
    *)
        echo "Usage: bash scripts/try-demo.sh [velo|nestfind|--clean]"
        exit 1
        ;;
esac
