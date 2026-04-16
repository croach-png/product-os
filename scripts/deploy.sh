#!/bin/bash
# Deploy workspace scripts to the runtime location (~/.local/bin/pm-workspace/)
# and install/reload launchd plists.
#
# Usage:
#   bash scripts/deploy.sh          # deploy all scripts + plists
#   bash scripts/deploy.sh --check  # dry run — show what would change
#
# What it does:
#   1. Copies all .sh scripts and *-prompt.txt files to DEPLOY_DIR
#   2. Copies all .plist files to ~/Library/LaunchAgents/
#   3. Reloads any plists that changed
#   4. Reports what was updated

set -euo pipefail

# SETUP: Update WORKSPACE to match your repo location
WORKSPACE="${PM_WORKSPACE:-${HOME}/Documents/pm-workspace}"
DEPLOY_DIR="${HOME}/.local/bin/pm-workspace"
LAUNCH_AGENTS_DIR="${HOME}/Library/LaunchAgents"
CHECK_ONLY=false

if [[ "${1:-}" == "--check" ]]; then
    CHECK_ONLY=true
fi

mkdir -p "$DEPLOY_DIR"
mkdir -p "$LAUNCH_AGENTS_DIR"

CHANGED=0
UNCHANGED=0

deploy_file() {
    local src="$1"
    local dst="$2"
    local filename
    filename=$(basename "$src")

    if [[ ! -f "$src" ]]; then
        return
    fi

    if [[ -f "$dst" ]] && diff -q "$src" "$dst" > /dev/null 2>&1; then
        UNCHANGED=$(( UNCHANGED + 1 ))
        return
    fi

    if $CHECK_ONLY; then
        if [[ -f "$dst" ]]; then
            echo "  CHANGED: $filename"
        else
            echo "  NEW:     $filename"
        fi
    else
        cp "$src" "$dst"
        if [[ "$filename" == *.sh ]]; then
            chmod +x "$dst"
        fi
    fi
    CHANGED=$(( CHANGED + 1 ))
}

# --- Deploy scripts ---
echo "Scripts (→ ${DEPLOY_DIR}):"

for f in "${WORKSPACE}/scripts/"*.sh; do
    [[ -f "$f" ]] || continue
    [[ "$(basename "$f")" == "deploy.sh" ]] && continue
    deploy_file "$f" "${DEPLOY_DIR}/$(basename "$f")"
done

# Deploy prompt files
for f in "${WORKSPACE}/scripts/"*-prompt.txt; do
    [[ -f "$f" ]] || continue
    deploy_file "$f" "${DEPLOY_DIR}/$(basename "$f")"
done

# Deploy lib.sh
if [[ -f "${WORKSPACE}/scripts/lib.sh" ]]; then
    deploy_file "${WORKSPACE}/scripts/lib.sh" "${DEPLOY_DIR}/lib.sh"
fi

echo "  ${CHANGED} changed, ${UNCHANGED} unchanged"

# --- Deploy plists ---
PLIST_CHANGED=0
PLIST_UNCHANGED=0
PLISTS_TO_RELOAD=()

echo ""
echo "Plists (→ ${LAUNCH_AGENTS_DIR}):"

for f in "${WORKSPACE}/scripts/"*.plist; do
    [[ -f "$f" ]] || continue
    filename=$(basename "$f")
    dst="${LAUNCH_AGENTS_DIR}/${filename}"

    if [[ -f "$dst" ]] && diff -q "$f" "$dst" > /dev/null 2>&1; then
        PLIST_UNCHANGED=$(( PLIST_UNCHANGED + 1 ))
        continue
    fi

    if $CHECK_ONLY; then
        if [[ -f "$dst" ]]; then
            echo "  CHANGED: $filename"
        else
            echo "  NEW:     $filename"
        fi
    else
        label="${filename%.plist}"
        if launchctl list 2>/dev/null | grep -q "$label"; then
            launchctl unload "$dst" 2>/dev/null || true
        fi
        cp "$f" "$dst"
        PLISTS_TO_RELOAD+=("$dst")
    fi
    PLIST_CHANGED=$(( PLIST_CHANGED + 1 ))
done

echo "  ${PLIST_CHANGED} changed, ${PLIST_UNCHANGED} unchanged"

# --- Reload changed plists ---
if [[ ${#PLISTS_TO_RELOAD[@]} -gt 0 ]] && ! $CHECK_ONLY; then
    echo ""
    echo "Reloading plists:"
    for plist in "${PLISTS_TO_RELOAD[@]}"; do
        label=$(basename "$plist" .plist)
        launchctl load "$plist" 2>/dev/null && echo "  Loaded: $label" || echo "  FAILED: $label"
    done
fi

# --- Summary ---
TOTAL_CHANGED=$(( CHANGED + PLIST_CHANGED ))
echo ""
if $CHECK_ONLY; then
    echo "DRY RUN — ${TOTAL_CHANGED} file(s) would change. Run without --check to deploy."
else
    echo "Deployed ${TOTAL_CHANGED} file(s)."
fi
