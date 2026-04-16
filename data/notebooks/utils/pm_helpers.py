"""
PM Workspace Analyst Helpers

Shared utilities for Jupyter notebook analysis:
- Data loading (CSV, database)
- Z-score anomaly detection
- Chart styling
- Export helpers

SETUP: Customise the chart colours and styling to match your brand.
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path

# === Chart styling ===

# SETUP: Replace with your brand colours
BRAND_COLOURS = {
    "primary_blue": "#2563EB",
    "green": "#059669",
    "red": "#DC2626",
    "dark_navy": "#1E3A5F",
    "mid_grey": "#6B7280",
    "secondary": "#7C3AED",
    "warning": "#D97706",
}

PALETTE = list(BRAND_COLOURS.values())
CHART_PALETTE = PALETTE


def set_chart_style():
    """Apply workspace chart styling."""
    sns.set_theme(style="whitegrid", palette=CHART_PALETTE)
    plt.rcParams.update({
        "figure.figsize": (12, 6),
        "axes.titlesize": 14,
        "axes.labelsize": 12,
        "font.size": 10,
    })


# === Data loading ===

def load_csv(path, parse_dates=None):
    """Load a CSV file with standard options."""
    return pd.read_csv(path, parse_dates=parse_dates)


def load_csv_reports(directory, pattern="*.csv", parse_dates=None):
    """Load all CSV files matching a pattern from a directory into a dict."""
    reports = {}
    dir_path = Path(directory)
    for csv_file in sorted(dir_path.glob(pattern)):
        reports[csv_file.stem] = pd.read_csv(csv_file, parse_dates=parse_dates)
    return reports


# === Anomaly detection ===

def detect_anomalies(series, window=8, threshold=2.0):
    """Flag values outside threshold standard deviations from rolling mean.

    Returns a boolean Series (True = anomaly).
    """
    rolling_mean = series.rolling(window=window, min_periods=3).mean()
    rolling_std = series.rolling(window=window, min_periods=3).std()
    z_scores = (series - rolling_mean) / rolling_std
    return z_scores.abs() > threshold


# === Export helpers ===

CHARTS_DIR = Path(__file__).parent.parent.parent / "reports" / "charts"


def save_chart(fig, name, date_str=None):
    """Save a chart to the standard output directory."""
    CHARTS_DIR.mkdir(parents=True, exist_ok=True)
    suffix = f"-{date_str}" if date_str else ""
    path = CHARTS_DIR / f"{name}{suffix}.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    return path


def save_json(data, name, date_str=None):
    """Save a JSON file to the standard output directory."""
    import json
    CHARTS_DIR.mkdir(parents=True, exist_ok=True)
    suffix = f"-{date_str}" if date_str else ""
    path = CHARTS_DIR / f"{name}{suffix}.json"
    with open(path, "w") as f:
        json.dump(data, f, indent=2, default=str)
    return path
