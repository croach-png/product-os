# Getting Started

This guide has two paths: a 5-minute demo to see the workspace in action, and a full setup to make it your own. Start with the demo.

---

## Prerequisites

Before you start, you need three things installed:

1. **Git** — version control. [Install guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git). If you're on a Mac, you may already have it — open Terminal and type `git --version` to check.

2. **Node.js 18+** — required by Claude Code. [Download here](https://nodejs.org/). Choose the LTS version.

3. **Claude Code** — the AI tool that powers the workspace. [Install guide](https://docs.anthropic.com/en/docs/claude-code/overview). After installing Node.js, run:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

4. **An Anthropic account** — Claude Code requires either API credits (pay-as-you-go) or a [Max subscription](https://www.anthropic.com/pricing). You'll be prompted to log in the first time you run Claude Code.

**New to the terminal?** See `PM-GIT-GUIDE.md` (once you've cloned the repo) for a beginner-friendly guide to the terminal, VS Code, and Git.

---

## Phase 1: Try the demo (5 minutes)

See the workspace in action with fictional company data before investing time in setup.

### 1. Clone the repo

Open your terminal and run:

```bash
git clone https://github.com/{your-org}/pm-workspace-template.git my-pm-workspace
cd my-pm-workspace
```

### 2. Install the demo

```bash
bash scripts/try-demo.sh
```

You'll be asked to choose a demo company:
- **Velo** — a fictional online bike marketplace
- **NestFind** — a fictional rental property marketplace

The script copies pre-written context files into the workspace so the commands have something to work with.

### 3. Open Claude Code

```bash
claude
```

This opens Claude Code in your terminal. You'll be prompted to log in the first time.

### 4. Try some commands

Once Claude Code is running, type any of these:

```
/investigate Why is our listing completion rate dropping?
```

This runs a structured investigation — it reads your company context, metrics, and priorities, then produces a hypothesis with supporting and counter-evidence.

```
/prototype Improve the seller onboarding experience
```

This generates three solution concepts, evaluates them against your personas, and maps assumptions.

```
/review-design Sellers abandon because the process feels too long
```

This runs a design review using a psych audit, persona panels, and activation fit analysis.

### What to expect

- Each command takes 30-60 seconds to run. You'll see Claude reading files and thinking in real time.
- The output is a structured document — not a chat response. It reads like an analysis a colleague wrote.
- Because this is demo data, the analysis is illustrative. With your real company context, the outputs become genuinely useful.

### 5. Clean up when done

```bash
bash scripts/try-demo.sh --clean
```

This restores the template files to their original state so you can set up for your company.

---

## Phase 2: Make it yours (1-2 hours)

Now that you've seen what the workspace can do, populate it with your company's context. This is the most important step — the workspace is only as good as the context you give it.

### What "good context" looks like

- **Specific, not vague.** "Our activation rate is 28%, down from 34% last quarter, driven by a drop in mobile onboarding completion" is useful. "We need to improve activation" is not.
- **Opinionated where it matters.** If your company measures success a specific way, or has strong views on trade-offs (e.g. "we prioritise retention over acquisition"), say so. Claude will follow your framing.
- **Honest about gaps.** "We don't currently measure churn by segment — this is a known gap" is more useful than leaving it blank.
- **Updated regularly.** Stale context is worse than no context. Update `current-priorities.md` each quarter.

**Tip:** Open the demo files you just tried (in `demo/velo/` or `demo/nestfind/`) as examples of what a populated file looks like. Use them as a reference while writing your own.

### Populate these files in order

Each file has section headers and instructions. Later files reference earlier ones.

| Step | File | What to write | Time |
|:----:|------|---------------|:----:|
| 1 | `context/company.md` | Company background, team structure, key people | 20 min |
| 2 | `context/product.md` | How your product works, user journeys, pain points | 20 min |
| 3 | `context/glossary.md` | Company-specific terms, acronyms, metric names | 10 min |
| 4 | `data/funnel-context.md` | Funnel stages, metric definitions, data sources | 20 min |
| 5 | `context/current-priorities.md` | This quarter's focus areas, targets, initiatives | 15 min |
| 6 | `context/personas/customer-personas.md` | User personas (needs-based framework) | 15 min |
| 7 | `CLAUDE.md` | Update the "About" section and review conventions | 10 min |

You don't have to do all seven in one sitting. Even just `company.md` and `current-priorities.md` will make the commands noticeably better.

---

## Phase 3: Set up your workspace (5 minutes)

Your workspace is created by the `/setup-agent` command in Phase 5. It builds your team directory, copies the todo list, sets up agent directories, and bootstraps the agent's context from your calendar and meeting notes in one step. You don't need to do anything manually here — skip to Phase 4 unless you specifically want to start without a persistent agent.

If you only want the todo list (no persistent agent yet):

```bash
mkdir -p team/{YOUR_INITIALS}
cp team/TEMPLATE/todo_list.md team/{YOUR_INITIALS}/todo_list.md
```

Then come back to Phase 5 when you're ready to add an agent.

---

## Phase 4: Connect your tools (optional)

The workspace can integrate with your existing tools via MCP (Model Context Protocol). This is optional — commands gracefully skip tools that aren't configured.

```bash
cp .mcp.json.example .mcp.json
```

Edit `.mcp.json` to add integrations:

| Integration | What it enables |
|-------------|----------------|
| Meeting notes (Granola, Otter) | Meeting prep, action extraction |
| Project management (Notion, Linear, Jira) | Tracking and wiki access |
| Messaging (Slack) | Reading channels, posting updates |
| Data warehouse (BigQuery, Snowflake) | Metric queries in investigations |
| Calendar (Google Calendar) | Scheduling and daily prep |
| Email (Gmail) | Exec communications |

The more you connect, the more powerful the workflows become. But start without integrations and add them as you see the need.

---

## Phase 5: Activate agents (come back to this later)

The workspace includes perspective agents you can use right away and persistent agents that maintain state between sessions.

### Perspective agents (ready to use now)

These work out of the box with no setup. They're stateless specialist lenses you can invoke on any topic:

| Agent | Invoke with | What it does |
|-------|------------|-------------|
| `executive` | `@executive` | Frames your work for leadership |
| `data-analyst` | `@data-analyst` | Quantitative analysis perspective |
| `competitive-intel` | `@competitive-intel` | Market and competitor analysis |
| `user-researcher` | `@user-researcher` | Qualitative research perspective |
| `customer-success` | `@customer-success` | Customer experience lens |

Try `@executive` on a project doc to see how it reframes your work for a leadership audience.

### Persistent agents (one command to set up)

Persistent agents maintain state between sessions, build long-term memory, and can run on automated schedules. Setup is a single command.

```
/setup-agent SJ, Steve, cos
```

Replace with your initials, first name, and chosen agent type. The command:

1. Checks which MCPs you have connected and flags missing ones with concrete reasoning
2. Creates your team directory, todo list, and shared memory file
3. Copies the right starter agent and personalises it with your details
4. Bootstraps context from your calendar (recurring meetings), meeting notes (action items, decisions) and messaging
5. Tells you exactly what to review, how to test the agent, and how to correct what it gets wrong

| If you are... | Start with |
|--------------|-----------|
| Any PM | **cos** (Chief of Staff) — meeting prep, action tracking |
| Data-driven PM | **analyst** — metric monitoring, experiment analysis |
| PM owning user-facing features | **uxr** — qualitative signal synthesis |
| PM with direct reports | **manager** — team tracking, development |
| Anyone wanting structured reflection | **coach** — weekly operating reviews |
| PM presenting to execs regularly | **strategist** — narrative framing, exec feedback tracking |
| When you have 3+ automations running | **engineer** — workspace health, automation reliability |

Want the full guide? Read `.claude/agents/examples/README.md` — it explains the 3-layer system (definition + state + memory), how to connect agents to messaging, how to automate them on a schedule, and what separates a good agent from a great one.

### Stakeholder agents

To stress-test proposals against real exec pushback:

1. Copy `.claude/agents/stakeholder-template.md` to `.claude/agents/{name}.md`
2. Fill in how this person thinks, their priorities, and communication style
3. Use `@{name}` to get their perspective on any proposal

### Automation

Once an agent is producing output worth reading daily (typically after 1-2 weeks), automate its refresh on a schedule. See `.claude/agents/examples/README.md` for the full pattern, and `scripts/README.md` for deployment.

---

## Phase 6: Try the core workflows

Now that your context is populated, try these commands with real questions about your product:

| Command | Example | What it does |
|---------|---------|-------------|
| `/investigate` | `/investigate Why is our conversion rate dropping?` | Structured investigation with quant + qual evidence |
| `/create-new-project` | `/create-new-project` | Guided project/experiment doc creation |
| `/meeting-prep` | `/meeting-prep Sarah` | Prep brief for your next meeting with someone |
| `/weekly-review` | `/weekly-review JK` | End-of-week progress and effectiveness review |
| `/review-design` | `/review-design Users abandon checkout because...` | Psych audit, persona panels, assumption mapping |
| `/prototype` | `/prototype Improve onboarding for new users` | 3 solution concepts with persona evaluation |
| `/experiment-setup` | `/experiment-setup Test shorter onboarding flow` | Sample size, run time, ROTI, decision rules |

See `CLAUDE.md` for the full list of 25+ commands.

---

## Phase 7: Create your own commands (ongoing)

Slash commands are the most powerful part of this workspace. They turn multi-step workflows into one-command operations.

### How commands work

A command is a markdown file in `.claude/commands/` that contains instructions for Claude. When you type `/command-name`, the file's contents are loaded as the prompt. Arguments (e.g. `/investigate Why is churn rising?`) are available as `$ARGUMENTS`.

### Anatomy of a good command

```markdown
<!-- owner: shared | audience: all-pms | last-updated: 2026-04 -->
<!-- purpose: One-line description of what this command does -->

# Command Name

[Clear instructions for what Claude should do]

## Steps
1. [Read specific context files]
2. [Perform analysis or gather data]
3. [Produce structured output]

## Output format
[Exact structure of what the output should look like]

## Principles
[Quality standards and constraints]
```

What makes commands effective:
- **Reference specific files** — tell Claude exactly which context files to read. Don't make it guess.
- **Be prescriptive about output** — define the exact format, sections, and structure.
- **Include quality standards** — reference the evidence standards in `pm-playbook/evidence-standards/`.
- **Chain tools** — commands can use MCP tools, read files, write files, and run analysis.

### Creating a new command

1. Create a file in `.claude/commands/` (e.g. `my-command.md`)
2. Add frontmatter: `<!-- owner: JK | audience: personal | last-updated: 2026-04 -->`
3. Write clear instructions (study existing commands for patterns)
4. Test it: `/my-command` in Claude Code
5. Iterate — commands get better with refinement

### Personal vs shared commands

Prefix personal commands with your initials (e.g. `jk-weekly-standup.md`). This keeps them distinct from shared commands.

### Command ideas

| Command | What it would do |
|---------|-----------------|
| `{initials}-standup` | Daily standup update from todo list and yesterday's activity |
| `{initials}-exec-update` | Weekly update email for your leadership chain |
| `{initials}-1on1-prep` | Prep for all your 1:1s this week |
| `retro-summary` | Summarise a team retrospective from meeting notes |
| `quarterly-goals` | Draft quarterly goals from current priorities |

---

## What's next

- Explore the full command list in `CLAUDE.md`
- Read the PM playbook at `pm-playbook/README.md`
- Try the 6-module training course starting with `/learn-1-discovery`
- Create commands for your recurring workflows
- Set up automation for agents you use regularly

---

## Troubleshooting

**"command not found" when running `claude`:**
Make sure Claude Code is installed (`npm install -g @anthropic-ai/claude-code`) and that your Node.js version is 18+. Run `node --version` to check.

**"command not found" when running `git`:**
Install Git from [git-scm.com](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git). On Mac, you can also install it by running `xcode-select --install`.

**Commands reference files that don't exist yet:**
Most commands check for files before reading them and skip gracefully. Populate the context files first for the best experience.

**MCP tools not available:**
Commands that use MCP tools (calendar, Slack, data warehouse) will skip those steps if the MCP isn't configured. The command still runs — you just get fewer data sources.

**Agent state files are empty:**
Agents populate their state on first run. Invoke the agent once (e.g. `@cos`) and it will do a full initial derivation.

**The demo data is still showing after I set up my own context:**
Run `bash scripts/try-demo.sh --clean` to restore the template files, then populate them with your own content.
