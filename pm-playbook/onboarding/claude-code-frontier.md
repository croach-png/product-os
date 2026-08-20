<!-- owner: shared | audience: all-pms | last-updated: 2026-06-04 -->
<!-- purpose: Reference list of cutting-edge Claude Code / Anthropic capabilities to track against in the weekly review. The coach checks this file and recommends one item per week to try. -->

# Claude Code Frontier

A maintained list of cutting-edge Claude Code and Anthropic capabilities. The coach reads this during the weekly review and recommends one item per week that you haven't tried yet (or hasn't pushed deep enough).

Status values: `not tried` / `tried` / `using` / `mastered`.

Update this file when you start using something new — or when a new capability is released worth tracking.

## Claude Code harness

| Capability | What it'd unlock | Status | Notes |
|------------|------------------|--------|-------|
| Hooks (PreToolUse, PostToolUse, Stop, UserPromptSubmit) | Auto-actions on Claude events — e.g. block destructive commands, auto-format on Edit, log every tool call | not tried | settings.json based |
| Sub-agents (`.claude/agents/`) | Specialised agents with own tools/model — already using stakeholder/perspective | using | Persistent agents use this pattern; could push further with model overrides per agent |
| Skills (`.claude/skills/` or system skills) | Reusable, discoverable workflows with own context | using | 40+ commands; question is whether more *should* be skills not commands |
| MCP servers (consuming) | Connect to Granola, Slack, Notion, BigQuery | using | Could push: authoring own MCP server for {Your Company}-specific data |
| MCP servers (authoring) | Build a {Your Company}-specific MCP server (e.g. for personal agent state and todos) | not tried | Would replace several script wrappers with structured tools |
| Headless mode (`claude --print`) | Run Claude non-interactively in scripts and CI | using | All Friday automations use this |
| Plan mode | Enforced read-only research before write | not tried | Useful for risky changes; could wrap into command |
| Worktrees (isolation: "worktree") | Isolated git copies for parallel agent work | not tried | Could speed up parallel investigations |
| Background agents (run_in_background) | Long-running work in parallel | not tried | Useful for slow research while you continue elsewhere |
| `/loop` skill | Self-paced or interval-based recurring work | not tried | Could replace some cron jobs with adaptive cadence |
| ScheduleWakeup | Dynamic re-entry based on context (vs fixed cron) | not tried | Smarter than launchd for some workflows |
| Custom statusline | Surface live state (e.g. open PR count, current goal) in CLI | not tried | Quick win for keeping context top-of-mind |
| Output styles | Control verbosity/format per command | not tried | Could tighten review output |
| Memory system (auto-memory) | Cross-session memory in `~/.claude/projects/` | using | Already substantial; question is whether agents are reading it |
| Hooks + Slack | Auto-post on `Stop` event to keep your team's Slack channels live | not tried | Replaces some periodic posters with event-driven |
| Permission modes (`allowedTools`) | Lock down what each agent can do | using | Friday script uses this |
| Settings.json env vars and per-project config | Project-specific behaviour | using | Could push further with per-agent env |
| `/goal` command | Set a session completion condition so Claude stops cleanly at a defined outcome | not tried | Changelog v2.1.162+; useful for long-running automation scripts where stop condition is ambiguous |
| `claude agents` command | CLI dashboard showing running background sub-agents and their status | not tried | Changelog v2.1.162+; run `claude upgrade` first; most useful when background agents are in flight |

## Anthropic SDK / API

| Capability | What it'd unlock | Status | Notes |
|------------|------------------|--------|-------|
| Prompt caching | 90% cost reduction + 4x latency on repeat-context calls | not tried | Friday scripts re-send context every run; ideal candidate |
| Tool use (function calling) | Structured outputs vs parsing markdown | not tried | Would harden agent state updates |
| Batch API | 50% cost on async batch jobs | not tried | Weekly bulk operations |
| Files API | Upload reference docs once, cite many times | not tried | Useful for long-running agents |
| Vision (image inputs) | Read screenshots, diagrams, design files | not tried | Could power design-review workflows |
| PDF inputs (native) | Read PDFs without conversion | not tried | Replaces `convert-pdf` pipeline |
| Citations | Auto-grounded responses with source pointers | not tried | Would harden evidence standards |
| Extended thinking | More compute on hard reasoning tasks | not tried | Worth trying on strategy doc drafts |
| Computer use | Agent that controls a browser/desktop | not tried | Long-tail; could automate some web tasks |
| Eval frameworks (Anthropic Evals / Inspect / Promptfoo) | Measure prompt quality changes objectively | not tried | Currently no eval harness for own agents |
| Claude Code in CI (GitHub Actions) | Auto-review PRs, auto-update docs | not tried | Worth piloting on one repo |
| Agent SDK | Build standalone Claude-powered tools (not via Claude Code) | not tried | E.g. a {Your Company}-specific PM assistant for the team |

## How the coach uses this

Every Friday the coach reads this file and:
1. Scans for items with status `not tried` or `tried` (not yet `using`).
2. Picks the one most relevant to a current gap or unrealised value.
3. Recommends it for the coming week with a 1-line "what to try" suggestion.
4. Tracks whether the recommendation was acted on the following week.

When an item moves to `using` or `mastered`, replace it with a new frontier item.
