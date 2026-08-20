# Getting Started with Claude Code and the PM Repo

A practical guide for new PMs joining the {Your Company} product team.

This guide covers three things:
1. **Setting up Claude Code** — what it is, how to install it, what it can do
2. **The PM repo** — what's in it, how to use it, how to keep it updated
3. **Commands and workflows** — the automations we've built to speed up PM work

Work through it in order. Each section builds on the previous one. If you get stuck at any point, ask Claude — it has full context on this repo and can help you troubleshoot, explain concepts, or walk you through any step.

---

## Part 1: What is Claude Code and why do we use it?

Claude Code is Anthropic's CLI (command line interface) for Claude. It runs in your terminal and can read, write, and edit files, search the web, connect to Slack, Granola, Google Calendar, and other tools via MCP integrations.

We use it as a **PM operating system**. It sits on top of our shared repo of strategy docs, research, templates, and processes. Because Claude can read all of these files, it has deep context about {Your Company} — our funnel, personas, activation strategies, brand voice, and current priorities. That context makes it dramatically more useful than a generic AI chat.

### How it makes us faster and more effective

The goal is simple: spend less time on process and more time on thinking, decisions, and outcomes. Claude Code handles the legwork — pulling context together, drafting structured outputs, connecting information across tools — so you can focus on the PM work that actually matters.

Here's some examples of what that looks like in practice:

- **Ask it what good looks like / for its opinion on your approach.** Review @pm-playbook for templates and best practise guidelines.
- **Create and validate experiment docs in minutes.** `/create-new-project` walks you through Socratic questioning to stress-test your thinking, generates a structured doc, and reviews it against our quality criteria — all in one session.
- **Draft tailored messages for cross-functional stakeholders in seconds.** Need to brief an engineer on a project decision, summarise a meeting outcome for your squad, or draft a Slack update? Claude knows the context and can draft to the right audience.
- **Check your understanding of previous work immediately.** Ask "What did we decide about X in our last team meeting?" or "What experiments have we run on {area}?" and get answers grounded in your actual meeting notes and project docs.
- **Answer data questions quickly.** Claude can query dbt models, explain metric definitions from our funnel context, and help you interpret data without context-switching to a different tool.
- **Prep for meetings in 30 seconds.** `/meeting-prep` pulls together your last meeting notes, open actions, squad goals, and development themes into a structured brief.
- **Stay on top of customer sentiment.** `/customer-reviews` fetches this week's reviews from Trustpilot, App Store, and Slack, categorises themes, and drafts a summary.
- **Run your weekly review as a conversation.** `/weekly-review` pulls your meetings, todos, commits, and priorities, then walks you through progress, operating effectiveness, and goal-setting interactively.
- **Extract action items without re-reading notes.** `/todo` scans your recent Granola meetings and updates your todo list automatically.
- **Double-check your work before sharing.** Before circulating any document, ask Claude *"Can you check this doc for coherence, gaps, and anything that doesn't read well?"* — it catches issues you'll miss after working on something for a while. Build this into your habit: draft, review yourself, then get Claude to review before sending to colleagues.

### What it's not

- It's not a replacement for thinking. It accelerates your workflow, but you still own the decisions. You must review the output and work with it to shape the outputs. The goal is not to produce immediate average work, it's to produce excellent work much quicker than before. Don't circulate docs or assets you've not reviewed and are not happy with — sending unreviewed AI-generated content wastes other people's time and undermines trust. Always read what Claude produces before sharing it.
- It's not always right. Check its outputs, especially data claims. We have evidence standards (covered in the repo section below).
- It's not connected to Looker/BigQuery by default. If you need live data, you'll still use those tools directly.

---

## Part 2: Setting up Claude Code

### Prerequisites

You need:
- **A Mac** with macOS 13+ (everyone on the team uses Mac)
- **An IDE (code editor)** — we strongly recommend using one so you can browse, read, and search the repo files easily alongside Claude Code. See "Set up your IDE" below
- **Git** — check by running `git --version` in your terminal. If not installed, run `xcode-select --install`
- **Node.js 18+** — check with `node --version`. If needed, install via `brew install node` (install Homebrew first if you don't have it: https://brew.sh)

### Step 1: Set up your IDE

While you'll interact with Claude Code in a terminal, you'll spend a lot of time reading and navigating the repo's files — strategy docs, research, project files, playbook templates, and more. An IDE (integrated development environment) makes this much easier than working in the terminal alone. It gives you a file tree sidebar, search across files, markdown preview, and a built-in terminal to run Claude Code from.

We recommend **VS Code** (free, lightweight, works well for non-engineers):

1. Download from https://code.visualstudio.com/
2. Install and open it
3. Go to **File > Open Folder** and select `~/Documents/pm-workspace`
4. You'll see the full folder structure in the sidebar — you can click any file to read it
5. Open the built-in terminal with `` Ctrl+` `` (backtick) — this is where you'll run Claude Code

**Other options that also work well:**
- **Cursor** — an AI-native editor built on VS Code. Same interface, with additional AI features built in
- **Windsurf** — another AI-focused editor option

Any of these will work. The key thing is having a file explorer alongside your terminal so you can quickly find and read files while working with Claude.

**Useful VS Code tips for PMs:**
- `Cmd+P` — quick file search (type part of a filename to jump to it)
- `Cmd+Shift+F` — search across all files in the repo
- Click a `.md` file, then click the preview icon (top right) to see rendered markdown
- You can have multiple terminal tabs open — useful for running Claude Code in one and git commands in another

### Step 2: Install Claude Code

Open your terminal and run:

```bash
npm install -g @anthropic-ai/claude-code
```

Verify it installed:

```bash
claude --version
```

### Step 3: Authenticate

Run:

```bash
claude
```

It will prompt you to authenticate. Follow the browser flow to sign in with your Anthropic account. Ask your manager if you don't have one.

### Step 4: Clone the PM repo

You'll need a GitHub account with access to the {Your Company} organisation. If you don't have access, ask IT to add you.

If you're new to GitHub and git, work through the short intro in this repo first: [git-for-pms.md](./git-for-pms.md) — it covers the basics of cloning, pulling, committing, and pushing.

Then clone the repo:

```bash
cd ~/Documents
git clone https://github.com/{your-org}/pm-workspace-template pm-workspace
```

### Step 5: Open the repo in Claude Code

```bash
cd ~/Documents/pm-workspace
claude
```

That's it. Claude will automatically read the `CLAUDE.md` file (our project instructions) and load all the context about {Your Company}.

### Step 6: Test it works

Try asking Claude something to confirm everything is connected:

```
What are {Your Company}'s current strategic priorities?
```

It should read `context/current-priorities.md` and give you a grounded answer. If it does, you're set up.

### Step 7: MCP integrations

MCP (Model Context Protocol) servers connect Claude Code to external tools. These are what make commands like `/meeting-prep` and `/todo` work — they pull live data from your calendar, meetings, and Slack directly into the session.

You'll need to set up access to each of these. Some are configured at the project level (already in the repo settings), but most require you to authenticate individually.

| MCP Server | What it does | Used by | Setup |
|------------|-------------|---------|-------|
| **Granola** | Reads your meeting transcripts, notes, and documents | `/todo`, `/meeting-prep`, `/weekly-review`, `/export-transcripts` | Install the Granola desktop app and sign in. The MCP server connects via your local Granola instance. You'll need a Granola account — ask IT if you don't have one |
| **Google Calendar** | Reads your upcoming events, finds free time, creates/updates events | `/meeting-prep` (auto-detects next meeting if no name given) | Authenticates via Google OAuth. On first use, Claude will prompt you to authorise access to your Google Calendar. Use your {Your Company} Google account |
| **Gmail** | Reads and drafts emails | Ad-hoc — useful for drafting stakeholder comms | Authenticates via Google OAuth, same as Calendar. Use your {Your Company} Google account |
| **Slack** | Reads channels/threads, searches messages, drafts messages | `/customer-reviews`, ad-hoc Slack drafting and research | Authenticates via Slack OAuth. On first use you'll be prompted to authorise. Use your {Your Company} Slack workspace |
| **Notion** | Reads Notion wiki pages and databases | Ad-hoc — useful for pulling context from the {Your Company} wiki | Authenticates via Notion OAuth. On first use you'll be prompted to authorise. Use your {Your Company} Notion account |
| **Google Docs** | Reads and creates Google Docs | Pulling content from shared docs, drafting docs for stakeholders | Authenticates via Google OAuth, same as Calendar/Gmail. Use your {Your Company} Google account |
| **Google BigQuery** | Queries BigQuery datasets and tables directly | Ad-hoc data exploration and validation | Requires Google Cloud credentials. Ask IT for BigQuery access if you don't have it. Uses your {Your Company} Google account |
| **dbt** | Queries dbt models, explores data lineage and definitions | Answering data questions, understanding metric definitions | Requires access to the dbt project. Ask the Data team or IT for setup |

**To check which MCPs are connected:** Inside a Claude Code session, type `/mcp` to see the status of all configured MCP servers. This will show you which are connected, which need authentication, and which are failing.

You can also try a quick test for each:
- Granola: "Search my meetings from the last 2 days"
- Google Calendar: "What meetings do I have tomorrow?"
- Slack: "Read the last 5 messages from #product-managers"

If any of these fail, see the Troubleshooting section at the bottom of this guide.

### Tips for working in the terminal

If you're using VS Code or another IDE, open the built-in terminal (`` Ctrl+` ``) — you don't need a separate Terminal app.

If you're new to the terminal:

- `ls` — list files in the current directory
- `cd folder-name` — move into a folder
- `cd ..` — go back up one level
- `pwd` — show where you are
- Up arrow — repeat the last command
- `Ctrl+C` — cancel what's running

Inside a Claude Code session:
- Type naturally — it's a conversation
- `/` followed by a command name runs a slash command (e.g. `/todo XX, {Your Name}`)
- `/help` shows available options
- `/mcp` shows which MCP servers are connected
- `/usage` shows your current session token usage (useful for understanding how much context you've used)
- `Ctrl+C` interrupts Claude if it's mid-response
- Type `exit` or press `Ctrl+D` to end the session

---

## Part 3: The PM Repo

### What is it?

The repo is our shared knowledge base. Everything that matters for PM work lives here in plain text (markdown files), version-controlled with git. This means:

- **Everyone has the same context** — when Claude reads the repo, it knows what every PM knows
- **Changes are tracked** — git history shows who changed what and when
- **It's always up to date** — we update it as priorities, strategies, and research evolve

### Folder structure

Here's what's in the repo and when you'll use each folder:

| Folder | What's in it | When you'll use it |
|--------|-------------|-------------------|
| `context/` | Company context, current priorities, product overview, personas, brand guidelines. Includes `glossary.md` for {Your Company}-specific terminology | **First week** — read these to get oriented. Referenced by almost every command |
| `strategy/` | Activation strategies, roadmaps, OKRs, quarterly tracking, exec emails | When planning work, writing strategy docs, or reviewing team plans |
| `teams/` | **Current home for all project work** — per-squad workspaces with team info, project indexes, and stage artifacts per initiative. See structure below | When you want to know what a squad is working on, or to create/update project docs for your team |
| `insights/` | **Shared research for the whole team** — competitor research, seller/dealer qual and quant research, market analysis, UXR studies | When doing discovery, competitive analysis, or grounding a hypothesis. All research goes here so everyone benefits |
| `data/` | Funnel definitions, metric glossary, saved queries | When you need to understand how we measure things |
| `pm-playbook/` | **Critical** — PM process docs, templates, best practices, Reforge frameworks (see detailed section below) | When following our PM process, going through training modules, or creating project docs |
| `personal/` | Your personal workspace — todo list, weekly reviews, 1:1 notes, agent state files. Gitignored (stays on your machine only). See "Personal workspace" below | Day-to-day: your todo list lives here. Set it up in week one |
| `projects/` | **Legacy** — older project docs predating the `teams/` structure. New work goes in `teams/{name}/projects/`, not here | Reference only |
| `scripts/` | Utility scripts for automation | Rarely — these run behind the scenes |
| `.claude/` | Commands, agents, settings, hooks | When you want to see how a command works or create your own |

### Team folders

Every squad has a folder at `teams/{team-name}/`. This is where team-specific work lives — who's on the team, what they're building, and the full history of each initiative.

```
teams/
  {team-name}/
    team-info.md        ← who's on the team, contacts, Slack, cadence
    projects.md         ← project index: all initiatives with status and one-line note
    projects/
      {slug}/
        canonical.md    ← single source of truth for the initiative
        discovery.md    ← Stage 1: Discovery & Prioritisation
        prototypes.md   ← Stage 2: Solution Prototyping & Validation
        experiment.md   ← Stage 3: Experiment Design & Prioritisation
        results.md      ← Stage 6: Analyse & Learn
```

Add your squad folders under `teams/` following the same structure — one folder per squad, each with `team-info.md`, `projects.md`, and a `projects/` subfolder.

**To find out what a squad is working on:** open `teams/{team-name}/projects.md`. For depth on a specific initiative, follow the link to its `canonical.md`.

**To create a new project:** use `/create-new-project` — it will scaffold the right files in the right place. Templates are in `teams/_templates/`.

**If you're not sure where something goes**, ask Claude (`"Where should I put X?"`) or ask your manager or any PM on the team.

### Where to put insights and research

Insights always live at the global `insights/` level — never inside a team folder. This means qual research, UXR studies, analysis summaries, and competitor research are shared across the whole PM team rather than buried in a squad folder.

**Rule:** if you conduct a user interview, do a qual analysis, write up a survey summary, or produce any synthesis of research findings — put it in `insights/`. The right subfolder depends on the type:

| Type | Where it goes |
|------|-------------|
| Qualitative user research (per customer segment) | `insights/qual/{segment}/` |
| UXR studies | `insights/qual/uxr/` |
| Customer support / call analysis | `insights/qual/support-analysis/` |
| Quantitative analysis | `insights/quant/` |
| Competitor research | `insights/market/` |
| Summaries and synthesis | `insights/summaries/` |

Then link to the insight from your team's `canonical.md` or project doc so the connection between the research and the initiative is clear. The insight stays shared; the link lives in the project.

### The PM Playbook

The `pm-playbook/` folder is the most important reference for how we do product management at {Your Company}. It defines our end-to-end process and the standards we hold ourselves to.

**The product development process** follows six stages, each with its own best-practice guide and templates:

| Stage | Guide | What it covers |
|-------|-------|---------------|
| 1. Discovery & Prioritisation | `pm-playbook/process/1-discovery-and-prioritisation.md` | How to identify opportunities, gather evidence, and prioritise what to work on. Templates: [discovery planning](pm-playbook/templates/discovery-planning-template.md), [opportunity summary](pm-playbook/templates/opportunity-summary-template.md) |
| 2. Solution Prototyping & Validation | `pm-playbook/process/2-solution-prototyping-and-validation.md` | How to move from problem to solution — prototyping approaches, validation techniques, when to commit vs iterate |
| 3. Experiment Design & Prioritisation | `pm-playbook/process/3-experiment-design-and-prioritisation.md` | How to design rigorous experiments with clear hypotheses, success metrics, and guardrails. Templates: [experiment](pm-playbook/templates/experiment-template.md), [event tracking](pm-playbook/templates/event-tracking-template.md) |
| 4. Design Best Practice | `pm-playbook/process/4-design.md` | Our design review frameworks — psych audits, persona checks, activation fit, usability heuristics |
| 5. Build & Launch | `pm-playbook/process/5-build-and-launch.md` | Templates: [launch checklist](pm-playbook/templates/launch-checklist.md), [event tracking](pm-playbook/templates/event-tracking-template.md), stakeholder alignment, QA processes |
| 6. Analyse & Learn | `pm-playbook/process/6-analyse-and-learn.md` | How to analyse experiment results, make ship/kill/iterate decisions, and capture learnings |

Every command we've built maps to one or more of these stages. For example, `/create-new-project` follows the Stage 3 template, `/review-design` applies the Stage 4 frameworks, and `/learn-1-discovery` through `/learn-6-analyse` are interactive training modules that walk you through each stage.

**Reforge frameworks** are also in the playbook (`pm-playbook/Reforge/`). We use Reforge's retention, engagement, and growth frameworks throughout our strategy work — particularly activation moments, the PNIP pyramid, and the psych framework. You'll encounter these in the activation strategies and in the training modules.

**Templates** all live in `pm-playbook/templates/`. The key ones:
- Experiment/project template (Stage 3)
- Discovery planning template (Stage 1)
- Opportunity summary table (Stage 1)
- Event tracking template (Stage 5)
- Launch checklist (Stage 5)

You don't need to memorise all of this. The training modules (`/learn-1-discovery` through `/learn-6-analyse`) will walk you through each stage interactively, using real {Your Company} examples. Work through them in your first few weeks.

### Personal workspace

Your personal folder is at `personal/{your-initials}/` (e.g. `personal/AB/`). It's gitignored — nothing in it ever gets pushed to GitHub, so it's safe to keep private notes, draft docs, and 1:1 context there.

**Set it up on Day 1:**

```bash
mkdir -p ~/Documents/pm-workspace/personal/AB
```

Then run `/todo {initials}, {your name}` — this will create your `personal/AB/todo_list.md` automatically and populate it from your Granola meetings.

What typically lives here:
- `todo_list.md` — your task list, updated by `/todo` and `/weekly-review`
- `1:1/` — notes and context files for recurring 1:1s (populated by `/meeting-prep` and `/todo`)
- Agent state and memory files if you set up a personal agent team (see the agent team section below)

Nothing in `personal/` is shared — if you want to share a doc, move or copy it to the appropriate shared folder (`teams/`, `insights/`, etc.) and commit it.

### Canonical documents

The `teams/` structure uses a **canonical doc** pattern as the single source of truth for every initiative. It's worth understanding this early because you'll create and maintain canonical docs for your own projects.

The core idea: every initiative has one `canonical.md` that acts as an index — it summarises the current state, links to all the stage artifacts (discovery, experiment, results), and records key decisions. It doesn't duplicate content from those docs; it links to them.

**Why it matters:** instead of searching across five docs to understand where a project stands, anyone can open `canonical.md` and get the full picture in two minutes. It's your responsibility as the PM to keep it current.

The full convention is in `pm-playbook/conventions/canonical-documents.md` — read it before creating your first project. The short version: create the canonical doc first, update it after each stage completes, and never paste content into it that already lives in a stage doc.

### Glossary

`context/glossary.md` contains {Your Company}-specific terminology — funnel stages, product terms, team names, and abbreviations. Check it when you encounter an unfamiliar term rather than guessing. If you discover a term that's missing, add it.

### Your first orientation: key files to read

Read these files in your first week. You can either open them in a text editor or ask Claude to summarise them.

**Start here (day 1):**

1. `context/product.md` — how {Your Company} works end-to-end (seller journey, dealer journey, squads)
2. `context/current-priorities.md` — what we're focused on this quarter
3. `data/funnel-context.md` — our funnel, core metrics, leading vs lagging indicators
4. `context/glossary.md` — {Your Company}-specific terminology. Skim it early; come back to it whenever you hit an unfamiliar term

**Then (first week):**

5. `context/personas/seller-personas.md` — who our sellers are (needs-based personas)
6. `context/personas/dealer-personas.md` — who our dealers are
7. `insights/qual/` — qualitative research: seller reviews, dealer interviews, UXR studies. Browse to understand what evidence we have and how we capture it
8. `insights/quant/` — quantitative insights: funnel data, conversion analysis. Understand the data-driven side of our decision-making
9. `context/brand/messaging/how-we-sound.md` — brand voice and tone

**Tip:** You can ask Claude to walk you through any of these interactively:

```
Can you summarise the key themes from our recent seller qualitative research?
```

```
What do our dealer personas tell us about their buying behaviour? Quiz me on the key differences.
```

### Pushing and pulling — sharing your work

The repo is shared across the PM team. You need to **pull** other people's changes and **push** your own to keep everything in sync.

**Pull before you start work each day:**

```bash
cd ~/Documents/pm-workspace
git pull
```

Then open Claude Code:

```bash
claude
```

**Push when you've made changes others should see:**

When you add research, update a project doc, create a new command, or make any change to shared files, you need to commit and push so others get those changes too.

```bash
git add -A
git commit -m "Add dealer interview notes from fireside chat"
git push
```

**What to push vs what stays local:**
- **Push:** Strategy docs, project files, insights, shared commands, playbook updates — anything in the shared folders
- **Don't push (automatic):** The `personal/` folder is gitignored, so your personal files (todo lists, weekly reviews, 1:1 notes) stay on your machine only

**Be careful with shared files.** Templates, shared commands (in `.claude/commands/` without a personal prefix), and the `CLAUDE.md` file affect everyone. If you want to change a shared command or template, let the team know first — either in #product-managers or by raising it in a PM sync. Create a personal copy (prefixed with your initials) if you want to experiment with changes.

### Conventions to follow

- **UK English** throughout (organisation, not organization; colour, not color)
- **Outcome-oriented goals** — "Increase activation from 4% to 10%" not "Launch new onboarding flow"
- **Evidence standards** — cite sources, flag confidence levels, don't fill gaps with assumptions. The full standards are in the `CLAUDE.md` file
- **Don't create files without thinking** — prefer editing existing files. The repo should stay lean and useful

---

## Part 4: Commands and Workflows

Commands are the most powerful part of the setup. They're pre-built workflows that combine Claude's intelligence with our {Your Company} context.

### How to run a command

Inside a Claude Code session, type `/` followed by the command name:

```
/todo {your initials}, {your name}
```

Some commands take arguments (shown after the command name). Some are interactive and will ask you questions as they go.

### Command reference

#### Day-to-day workflow commands

| Command | What it does | When to use it | Try it |
|---------|-------------|----------------|--------|
| `/todo {initials}, {name}` | Scans your recent Granola meetings, extracts action items, prioritises them, and updates your todo list at `personal/{initials}/todo_list.md` | After meetings, or at the start/end of each day | `/todo {your initials}, {your name}` |
| `/meeting-prep {person}` | Pulls your last meeting notes, open actions, their squad goals, development themes, and carry-forward items into a structured prep brief | Before any 1:1 or recurring meeting | `/meeting-prep {person's first name}` |
| `/weekly-review {initials}` | End-of-week review: assesses progress against goals, evaluates how you operated, suggests actions, and sets goals for next week. Interactive — it asks for your input at each stage | Friday afternoon | `/weekly-review {your initials}` |
| `/customer-reviews` | Fetches this week's customer reviews from Trustpilot, App Store, and Slack. Categorises themes, saves a summary, and drafts a Slack message | Weekly (usually Monday) | `/customer-reviews` |

#### Project and strategy commands

| Command | What it does | When to use it |
|---------|-------------|----------------|
| `/create-new-project` | Guided project/experiment doc creation. Uses Socratic questioning to stress-test your thinking, then generates a structured doc and reviews it against quality criteria | When starting a new experiment or project |
| `/review-design {hypothesis}` | Systematic design review: psych audit, persona evaluation, activation fit, usability heuristics, assumption mapping. Paste screenshots and it analyses them | When reviewing designs before engineering handoff |
| `/verify-source` | Audits evidence you've just gathered for accuracy, confidence level, and bias | After pulling data or insights to check your own work |

#### Research and data commands

| Command | What it does | When to use it |
|---------|-------------|----------------|
| `/competitor-monitor` | Searches for recent competitor news, analyses it, and generates a digest | When you want to check what competitors are doing |
| `/convert-pdf {filepath}` | Converts a PDF to markdown so Claude can read and work with its contents | When you have a PDF report or document to analyse |
| `/export-transcripts` | Exports Granola meeting transcripts to local markdown files | When you want a local backup of your meeting notes |

#### Training modules

We have a 6-part PM training programme built as interactive commands. Each module teaches a specific PM skill using {Your Company}'s own frameworks and context:

| Command | Module | What you'll learn |
|---------|--------|------------------|
| `/learn-1-discovery` | Discovery & Prioritisation | How to identify and prioritise opportunities |
| `/learn-2-solution` | Solution Prototyping & Validation | How to prototype and validate solutions |
| `/learn-3-experiment` | Experiment Design & Prioritisation | How to design experiments with proper hypotheses |
| `/learn-4-design` | Design Best Practice | Psych framework, personas, usability heuristics |
| `/learn-5-build-launch` | Build & Launch | Launch checklists, stakeholder alignment, QA |
| `/learn-6-analyse` | Analyse & Learn | How to analyse experiment results and make decisions |

**Recommended:** Complete all 6 modules in your first two weeks. They'll teach you our frameworks while grounding everything in real {Your Company} context.

### Agent team

We've built an operational **agent team** — persistent agents that maintain state, run on automated schedules, and proactively surface things that need attention. This is a step beyond commands: where commands do one thing when you invoke them, persistent agents own an outcome and keep working in the background.

**How agents differ from commands:**

| | Commands | Persistent agents | Perspective agents |
|---|---|---|---|
| **Invocation** | Manual or scheduled | Automated + on-demand | On-demand only |
| **Memory** | Stateless | Persistent state file | Stateless |
| **Scope** | Does one thing | Owns an outcome | Provides a specialist lens |
| **Collaboration** | Independent | Reads other agents' state | Reads relevant state when invoked |

Commands don't go away — they become the **tools** agents use.

**Persistent agents** (your team — you'll interact with their outputs via daily briefs, Slack channels, and meeting prep):

| Agent | What it does | How you'll encounter it |
|-------|-------------|----------------------|
| **Chief of Staff** | Tracks actions, deadlines, follow-ups. Nothing falls through the cracks | Your daily prep brief pulls from this agent's state |
| **UX Researcher** | Monitors seller and dealer signals from reviews, research, Slack | Surfaces emerging themes in the weekly UXR digest |
| **Data Analyst** | Runs funnel analysis, anomaly detection, experiment tracking | Pre-computed notebooks and data summaries |
| **Coach** | Tracks your operating patterns and development | Feeds into weekly reviews |
| **Manager** | Tracks PM goals, development, team health across three pillars (Impact, Process, Culture) | Prepares 1:1 briefs, flags development opportunities |
| **Strategist** | Maintains the executive narrative and ensures consistent messaging | Generates weekly exec emails |
| **Product Manager** | Builds on prior investigations, maintains institutional knowledge | Enriches `/investigate` with cumulative context |
| **Engineer** | Keeps the workspace clean and reliable | Weekly repo sweeps, script health checks |

Each agent has a state file, a memory file, and (optionally) a Slack channel. You don't need to interact with these directly — they run in the background and feed into the commands and daily briefs you'll use. But it helps to know they exist so you understand where synthesised context comes from.

**The full agent team design doc is at `context/agent-team.md`** — read this if you want to understand how the system works under the hood or if you're interested in building agents for your own workflows.

**Setting up your own agents:** once you're comfortable with commands and the repo structure, you can build a personal agent team using `/setup-agent {initials}, {name}, {agent}`. This scaffolds an agent definition, creates a state file in `personal/{initials}/agents/state/`, and bootstraps context from live sources. Most new PMs start with a Chief of Staff agent to manage actions and follow-ups, then add others as their workflow matures. Ask a peer what's worked well before designing your own setup.

**Perspective and panel agents** — these are separate from the persistent team. They're stateless agents you invoke on-demand to stress-test ideas:

- **Stakeholder agents** — simulate exec/leadership pushback: `executive`, plus any company-specific stakeholders you scaffold (see `stakeholder-template.md`)
- **Panel agents** — review through all personas at once: `customer-panel`, or company-specific segments you define

**Example use:** Before presenting a proposal to the CEO, run it through the executive agent to pressure-test the commercial case. Before finalising a customer-facing design, run it through the customer panel to check it works for all persona types.

### Creating your own commands

You can create personal commands for your own workflows:

1. Create a file in `.claude/commands/` named `{your-initials}-{command-name}.md` (e.g. `ab-standup-notes.md`)
2. Add frontmatter:
   ```
   <!-- owner: AB | audience: personal | last-updated: 2026-03 -->
   <!-- purpose: One-line description of what this command does -->
   ```
3. Write the instructions for what Claude should do

Look at existing commands in `.claude/commands/` for examples of how they're structured. The `/todo` and `/meeting-prep` commands are good templates to learn from.

### Spotting automation opportunities

One of the most valuable things you can do is identify repetitive tasks in your workflow that Claude Code could handle. Here are some prompts to help you think about it:

**Ask yourself weekly:**
- What did I do this week that I'll do again next week in exactly the same way?
- Where did I spend time pulling information together from multiple sources before I could actually think?
- What tasks do I put off because they're tedious, even though they're useful?

**Common patterns that are good candidates for automation:**
- **Recurring synthesis tasks** — e.g. weekly seller reviews, competitor monitoring, stakeholder updates. If you're pulling from the same sources and producing the same format each time, that's a command.
- **Meeting prep and follow-up** — any meeting where you always check the same things beforehand or always need to extract actions afterwards.
- **Feedback and reflection** — the `/weekly-review` command exists because weekly reflection is valuable but easy to skip when it's manual. If you have a monthly planning ritual or a quarterly review process, consider building a command for it.
- **Document creation with a consistent structure** — if you create the same type of doc regularly (stakeholder briefs, experiment write-ups, sprint summaries), a command can scaffold it and ensure quality.
- **Cross-referencing** — checking a proposal against personas, checking an experiment against strategic priorities, verifying evidence. These are tasks where Claude's access to the full repo context is especially useful.

When you spot a pattern, either build a personal command (see above) or raise it with the team if it would benefit everyone.

### Automating tasks with scheduled runs

Claude Code can run non-interactively, which means you can schedule commands to run automatically — for example, extracting your todo items every Friday afternoon, or running a weekly competitor scan.

**How it works:**

The `scripts/` folder contains examples of automated scripts. The pattern is:

1. **A shell script** that runs Claude Code in `--print` mode (non-interactive, no human input required)
2. **A macOS launchd plist** that schedules the script to run at a specific time

Here's a simplified example of what an automated script looks like:

```bash
#!/bin/bash
# Weekly todo extraction — runs Friday at 4pm

WORKSPACE="$HOME/Documents/pm-workspace"
CLAUDE="/opt/homebrew/bin/claude"

cd "$WORKSPACE"

$CLAUDE --print "/todo AB, Alex" \
  --model sonnet \
  --allowedTools "mcp__granola__search_meetings,mcp__granola__get_meeting_documents,Read,Write,Edit,Glob,Grep,ToolSearch" \
  >> scripts/logs/todo.log 2>&1
```

Key points:
- `--print` runs Claude non-interactively (no questions, just output)
- `--model sonnet` uses a faster/cheaper model for automated tasks
- `--allowedTools` restricts which tools the automated run can use (important for safety)
- Output is logged to a file so you can check what happened

**Scheduling with launchd (macOS):**

Create a plist file in `~/Library/LaunchAgents/`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.{your-company}.weekly-todo</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/you/Documents/pm-workspace/scripts/weekly-todo.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Weekday</key>
        <integer>5</integer>
        <key>Hour</key>
        <integer>16</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
</dict>
</plist>
```

Load it:

```bash
launchctl load ~/Library/LaunchAgents/com.{your-company}.weekly-todo.plist
```

**Existing automated scripts** (in `scripts/`) that you can use as templates:
- `weekly-todo.sh` — extracts action items from Granola meetings every Friday
- `weekly-review.sh` — runs the full weekly review non-interactively and sends a Slack DM summary
- `weekly-customer-reviews.sh` — fetches and summarises seller reviews
- `weekly-competitor-monitor.sh` — runs the competitor scan
- `daily-meeting-prep.sh` — generates meeting prep briefs for the day's meetings

If you want to set up your own scheduled tasks, look at these scripts and adapt them. The main things to change are your initials/name, the command being run, and the schedule in the plist. Ask your manager or a peer if you need help getting started.

---

## Part 5: Your first week checklist

The goal for week one isn't just to read files — it's to **actively use the tools** so you understand both {Your Company}'s context and how to work effectively with Claude Code. By the end of the week you should have created a real project document grounded in evidence from the repo.

### Day 1: Set up and get oriented
- [ ] Install VS Code (or your preferred IDE) and open the repo folder
- [ ] Install Claude Code (`npm install -g @anthropic-ai/claude-code`)
- [ ] Clone the PM repo
- [ ] Run `claude` in the IDE's built-in terminal and verify it works
- [ ] Read `context/product.md` — ask Claude to explain anything unclear
- [ ] Read `context/current-priorities.md`
- [ ] Read `data/funnel-context.md`

### Day 2-3: Learn the context and explore evidence
- [ ] Read the persona files (seller and dealer)
- [ ] Read the brand voice guidelines (`context/brand/messaging/how-we-sound.md`)
- [ ] Browse `insights/qual/` — read 2-3 seller and dealer research files to understand what evidence we have and how we capture it
- [ ] Browse `insights/quant/` — understand the quantitative data available
- [ ] Ask Claude to help you explore: "What are the main themes across our qualitative research?" or "Summarise what we know about {topic} from the insights folder"
- [ ] Start `/learn-1-discovery` training module
- [ ] Run `/meeting-prep` before your first 1:1

### Day 4-5: Create something real
- [ ] Run `/todo {initials}, {name}` to set up your todo list
- [ ] **Run `/create-new-project` with a real or realistic experiment idea.** Pick something connected to your squad's area — it doesn't need to be perfect, the point is to practise the process. The command will guide you through hypothesis formation, evidence gathering, and quality review. Use the insights files you explored on days 2-3 to ground your evidence section — ask Claude to pull relevant qual or quant data to support your hypothesis
- [ ] After creating the project doc, run `/verify-source` to check the evidence quality
- [ ] Run `/weekly-review {initials}` on Friday
- [ ] Start `/learn-2-solution` training module

### Ongoing
- [ ] Pull the repo daily (`git pull`)
- [ ] Use `/meeting-prep` before 1:1s
- [ ] Use `/todo` after meetings
- [ ] Use `/weekly-review` every Friday
- [ ] Work through remaining training modules (3-6)
- [ ] Create your first personal command when you spot a repeated workflow

---

## Troubleshooting

### Claude Code won't install or authenticate

| Problem | Likely cause | Fix |
|---------|-------------|-----|
| `npm install` fails with permission errors | Node.js permissions | Try `sudo npm install -g @anthropic-ai/claude-code` or reinstall Node via Homebrew (`brew install node`) |
| `claude` command not found after install | npm global bin not in PATH | Run `npm config get prefix` and make sure `{prefix}/bin` is in your PATH. Ask IT if unsure |
| Authentication fails / browser redirect doesn't work | Corporate proxy interfering | See "Corporate proxy issues" below |
| "No API key" or authentication errors | Anthropic account not provisioned | Ask your manager or IT to check your Anthropic account access |

### Corporate proxy issues (Netskope, Zscaler, etc.)

If your organisation uses a corporate network security tool (Netskope, Zscaler, and similar proxies), it can interfere with Claude Code's HTTPS connections, causing SSL certificate errors or failed API calls.

**Symptoms:**
- `UNABLE_TO_GET_ISSUER_CERT_LOCALLY` or similar SSL errors
- Claude Code connects but then fails mid-response
- MCP servers fail to authenticate (especially Google OAuth)

**What to do:**
1. **First, contact IT** and explain you're setting up Claude Code (an Anthropic CLI tool) and are hitting SSL/proxy issues. They can add the necessary certificate exceptions or configure the proxy to allow the traffic.
2. If IT provides a proxy CA certificate, there's a setup script in the repo at `scripts/` that may help — ask your manager for the current approach.
3. Some MCP OAuth flows (Google Calendar, Gmail, Slack) may also need proxy exceptions. Flag these to IT at the same time.

### MCP servers not connecting

| Problem | Fix |
|---------|-----|
| Granola: "No meetings found" or connection error | Check that the Granola desktop app is running and you're signed in. Restart Granola if needed. If you don't have a Granola account, ask IT |
| Google Calendar/Gmail: OAuth prompt doesn't appear or fails | Likely a proxy issue — ask IT to allowlist the Google OAuth endpoints. Make sure you're using your {Your Company} Google account |
| Slack: Authentication fails | Ask IT to confirm you have API access to the {Your Company} Slack workspace. The Slack MCP needs specific OAuth scopes |
| Notion: Connection error or no pages found | Ensure you have a {Your Company} Notion account and the MCP integration has been authorised. Ask IT if you don't have Notion access |
| Google Docs: OAuth fails or no access | Same as Google Calendar/Gmail — uses Google OAuth. Ensure a proxy isn't blocking the auth flow |
| BigQuery: Permission denied | You need BigQuery access provisioned by IT. Ask for read access to the relevant datasets |
| dbt: Connection refused or not found | dbt setup requires access to the dbt project. Contact the Data team or IT |

### General tips

- **If a command fails partway through**, it's usually an MCP connection issue. Check which integration it was trying to use and test that specific MCP (see the test commands in Step 7 above).
- **If Claude seems slow or unresponsive**, check your internet connection. Corporate proxies can occasionally throttle connections.
- **If you get "context window exceeded"**, your conversation has gotten very long. Start a new session with `exit` then `claude`.

### Who to contact

| Issue | Contact |
|-------|---------|
| Anthropic account access | Your manager |
| Corporate proxy / network / SSL issues | IT |
| Granola account | IT |
| Google Workspace access (Calendar, Gmail, Docs, BigQuery) | IT |
| Slack API access | IT |
| Notion access | IT |
| dbt project access | Data team or IT |
| Repo access (GitHub) | Your manager or IT |
| Claude Code usage questions / command help | your manager or any PM on the team |

---

## Getting help

- **Claude Code help:** Type `/help` inside a session
- **Command questions:** Read the command file directly in `.claude/commands/` — they're well-documented
- **Repo questions:** Ask Claude — it knows the full structure
- **Setup issues:** Ask your manager or another PM on the team

If something isn't working or you have an idea for a new command, raise it — we're actively building this out as a team.
