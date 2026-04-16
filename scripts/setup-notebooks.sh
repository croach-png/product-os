#!/bin/bash
# Setup script for analyst Jupyter notebooks
# Creates venv, installs dependencies, registers Jupyter kernel
#
# Usage: bash scripts/setup-notebooks.sh

set -euo pipefail

WORKSPACE="$(cd "$(dirname "$0")/.." && pwd)"
NOTEBOOK_DIR="${WORKSPACE}/data/notebooks"
VENV_DIR="${NOTEBOOK_DIR}/.venv"
REQUIREMENTS="${NOTEBOOK_DIR}/requirements.txt"
KERNEL_NAME="pm-analyst"

echo "=== PM Analyst Notebook Setup ==="

# --- Detect Python ---
if command -v /opt/homebrew/bin/python3.12 &>/dev/null; then
    PYTHON="/opt/homebrew/bin/python3.12"
    echo "Using Homebrew Python 3.12: $PYTHON"
elif command -v python3.12 &>/dev/null; then
    PYTHON="python3.12"
    echo "Using Python 3.12: $PYTHON"
elif command -v python3 &>/dev/null; then
    PYTHON="python3"
    PY_VERSION=$($PYTHON --version 2>&1 | awk '{print $2}')
    echo "Using system Python: $PYTHON ($PY_VERSION)"
else
    echo "ERROR: Python 3 not found. Install via: brew install python@3.12"
    exit 1
fi

# --- Create venv ---
if [[ -d "$VENV_DIR" ]]; then
    echo "Existing venv found at ${VENV_DIR} — removing and recreating"
    rm -rf "$VENV_DIR"
fi

echo "Creating virtual environment..."
$PYTHON -m venv "$VENV_DIR"

# --- Install dependencies ---
echo "Installing dependencies..."
"${VENV_DIR}/bin/pip" install --upgrade pip --quiet
"${VENV_DIR}/bin/pip" install -r "$REQUIREMENTS" --quiet

# --- Register Jupyter kernel ---
echo "Registering Jupyter kernel '${KERNEL_NAME}'..."
"${VENV_DIR}/bin/python" -m ipykernel install --user --name "$KERNEL_NAME" --display-name "PM Analyst"

# --- Verify installation ---
echo ""
echo "=== Verification ==="
"${VENV_DIR}/bin/python" -c "
import pandas, numpy, scipy, matplotlib, seaborn, papermill
print(f'pandas:     {pandas.__version__}')
print(f'numpy:      {numpy.__version__}')
print(f'scipy:      {scipy.__version__}')
print(f'matplotlib: {matplotlib.__version__}')
print(f'seaborn:    {seaborn.__version__}')
print(f'papermill:  {papermill.__version__}')
"

echo ""
echo "=== Setup complete ==="
echo "Venv:   ${VENV_DIR}"
echo "Kernel: ${KERNEL_NAME}"
echo "Run notebooks: ${VENV_DIR}/bin/papermill <input.ipynb> <output.ipynb>"
