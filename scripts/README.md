# Scripts & Automation

This directory contains the automation infrastructure for the PM workspace. Scripts are authored here, deployed to a runtime location, and run on schedules via macOS launchd (or cron on Linux).

## Architecture

```
scripts/              ← You edit scripts here (in the repo)
  ├── lib.sh          ← Shared library (standard paths, env, logging, helpers)
  ├── deploy.sh       ← Copies scripts to runtime location
  ├── run-with-alert.sh ← Wrapper that catches failures and sends alerts
  ├── setup-notebooks.sh ← One-time Jupyter notebook environment setup
  ├── .env.example    ← Template for webhook/token configuration
  └── examples/       ← One complete example automation
      ├── daily-meeting-prep.sh       ← Example script
      ├── daily-meeting-prep-prompt.txt ← Companion prompt file
      └── com.example.daily-meeting-prep.plist ← Example launchd schedule

~/.local/bin/pm-workspace/  ← Scripts run from here (deployed)
  ├── lib.sh
  ├── .env
  ├── *.sh
  ├── *-prompt.txt
  └── logs/

~/Library/LaunchAgents/     ← Plist files run from here (deployed)
  └── com.yourproject.*.plist
```

## How it works

1. **Scripts** source `lib.sh` for standard paths, environment loading, logging, dedup, and Claude execution helpers
2. **Prompt files** (`*-prompt.txt`) contain the instructions sent to Claude — one per script
3. **`run-with-alert.sh`** wraps every launchd job — sends Slack/Telegram alerts on failure, Slack on success
4. **`deploy.sh`** copies scripts and plists from the repo to their runtime locations

## Getting started

### 1. Set up your environment

```bash
cp scripts/.env.example scripts/.env
# Edit .env with your Slack webhook URL and (optionally) Telegram tokens
```

### 2. Start with one script

The example in `scripts/examples/` shows the complete pattern. To create your first real automation:

1. Copy `examples/daily-meeting-prep.sh` to `scripts/daily-meeting-prep.sh`
2. Copy `examples/daily-meeting-prep-prompt.txt` to `scripts/daily-meeting-prep-prompt.txt`
3. Customise the prompt file with your initials and context
4. Test it manually: `bash scripts/daily-meeting-prep.sh --force`
5. When it works, create a plist (copy and modify the example)
6. Deploy: `bash scripts/deploy.sh`

### 3. Build up gradually

Recommended order for adding automations:

| Week | Add | Why |
|------|-----|-----|
| 1 | Daily meeting prep | Get value immediately from daily briefings |
| 2 | Weekly review (Friday) | End-of-week reflection and goal tracking |
| 3 | Weekly analyst refresh (Monday) | Start the week with fresh metrics |
| 4+ | Add more as your workflow matures | UXR refresh, competitor monitor, etc. |

## Conventions

- **Naming:** `{frequency}-{purpose}.sh` — e.g. `daily-meeting-prep.sh`, `weekly-analyst-refresh.sh`
- **Prompt files:** Each Claude-invoking script has a companion `{script-name}-prompt.txt`
- **All scripts** source `lib.sh` and call `mw_init "script-name"` first
- **Guard checks:** Scripts skip gracefully on weekends, holidays, and duplicate runs (exit code 2)
- **Environment:** `.env` at the deploy dir holds Slack webhooks and Telegram tokens

## Key functions from lib.sh

| Function | Purpose |
|----------|---------|
| `mw_init "name"` | Set up logging, load env, load helpers |
| `mw_skip_if_not_working_day` | Skip on weekends/holidays |
| `mw_skip_if_already_run_today "$marker"` | Dedup daily runs |
| `mw_skip_if_already_run_week "$marker"` | Dedup weekly runs |
| `mw_wait_for_workspace_access` | Handle macOS TCC/wake-from-sleep |
| `mw_kill_stale_claude "pattern"` | Kill hung Claude processes |
| `mw_acquire_claude_lock` / `mw_release_claude_lock` | Serialise Claude calls |
| `mw_run_claude "$prompt" "$tools" [model]` | Run Claude with retry |
| `mw_post_slack "$webhook" "$message"` | Post to Slack |
| `mw_trap_errors` | Install ERR trap for debugging |

## Deployment

```bash
bash scripts/deploy.sh          # deploy all scripts + plists
bash scripts/deploy.sh --check  # dry run — show what would change
```
