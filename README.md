# PM Workspace Template

An AI-powered product management workspace built on [Claude Code](https://claude.ai/code). It provides a structured system for PM decision-making, experimentation, investigation, and team management — with persistent AI agents that maintain context across sessions.

## What this is

A ready-to-use workspace that gives you:

- **A PM playbook** — 6-stage product process with templates for experiments, discovery, launches, and design reviews
- **25+ slash commands** — one-command workflows for investigation, meeting prep, experiment design, weekly reviews, and more
- **Persistent AI agents** — 8 specialist agents (Chief of Staff, Analyst, UX Researcher, Coach, Manager, Strategist, PM, Engineer) that maintain state between sessions
- **An automation framework** — scheduled scripts that keep agents fresh and surface insights proactively
- **Evidence standards** — built-in audit criteria to keep analysis honest and grounded
- **A 6-module training course** — hands-on PM training using a realistic scenario

## Who this is for

- Product managers and product leaders
- Anyone who wants a structured, evidence-driven PM practice powered by AI
- Teams looking to establish consistent PM processes

No technical setup is required to read or use most of the content. Claude Code is needed for the slash commands and agents.

## Quick start

Try it in 5 minutes with demo data, or set it up for your company.

### Option A: Try the demo (5 minutes)

```bash
git clone https://github.com/{your-org}/pm-workspace-template.git my-pm-workspace
cd my-pm-workspace
bash scripts/try-demo.sh
```

Then open Claude Code and try: `/investigate Why is our listing completion rate dropping?`

### Option B: Set up for your company

See `GETTING-STARTED.md` for the full guide.

### Prerequisites

You'll need:
- **Claude Code** — [install guide](https://docs.anthropic.com/en/docs/claude-code/overview) (requires Node.js 18+)
- **An Anthropic account** — Claude Code requires either API credits or a [Max subscription](https://www.anthropic.com/pricing). Usage costs vary by how much you use it
- **Git** — [install guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## What you'll find here

| Folder | Purpose |
|--------|---------|
| `context/` | Company background, product overview, personas, current priorities |
| `pm-playbook/` | PM process docs, templates, evidence standards, training course |
| `projects/` | Your active experiments and project documents |
| `insights/` | Market analysis, qualitative research, competitor intelligence |
| `strategy/` | Roadmaps, OKRs, and strategic planning |
| `data/` | Metric definitions, saved queries, notebooks, reports |
| `scripts/` | Automation infrastructure for scheduled agent runs |
| `team/` | Private team notes, agent state files, todo lists (gitignored) |
| `.claude/agents/` | AI agent definitions (persistent, perspective, panel, stakeholder) |
| `.claude/commands/` | Slash command definitions |

## Where to start

1. Try the demo: `bash scripts/try-demo.sh` (5 minutes)
2. Read `GETTING-STARTED.md` to set it up for your company
3. Populate the context files — the more you add, the more useful it becomes
4. Explore the PM playbook at `pm-playbook/README.md`

## Licence

MIT — Created by [Charlotte Roach](https://www.linkedin.com/in/charlotteroach/) at [Motorway](https://motorway.co.uk).
