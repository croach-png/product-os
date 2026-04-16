# Agent Team Design

This document defines the operational agent team — a set of persistent, outcome-focused agents that own specific domains of your work. Each agent maintains state between sessions, uses existing slash commands and automations as tools, and proactively surfaces what matters.

---

## How agents differ from commands

| | Commands | Persistent agents | Perspective agents |
|---|---|---|---|
| **Invocation** | Manual or scheduled | Automated + on-demand | On-demand only |
| **Memory** | Stateless | Persistent state file | Stateless |
| **Scope** | Does one thing | Owns an outcome | Provides a specialist lens |
| **Collaboration** | Independent | Reads other agents' state | Reads relevant state when invoked |

Commands don't go away — they become the **tools** agents use.

---

## The team

### Persistent agents (state + automation)

| Agent | Short name | Outcome |
|---|---|---|
| [Chief of Staff](#cos) | `cos` | Nothing falls through the cracks |
| [UX Researcher](#uxr) | `uxr` | User signals spotted early |
| [Data Analyst](#analyst) | `analyst` | Decisions grounded in accurate data |
| [Coach](#coach) | `coach` | You improving as a leader |
| [Manager](#manager) | `manager` | Direct reports levelling up, standards maintained |
| [Strategist](#strategist) | `strategist` | Leadership has an accurate, consistent picture |
| [Product Manager](#product-manager) | `product-manager` | Every investigation is rigorous and builds on prior work |
| [Engineer](#engineer) | `engineer` | Workspace runs cleanly and reliably |

### Perspective agents (no state, invoked on-demand)

| Agent | Short name | Purpose |
|---|---|---|
| Executive | `executive` | Business strategy and commercial lens |
| Data Analyst | `data-analyst` | Quantitative analysis perspective |
| Competitive Intel | `competitive-intel` | Market and competitor analysis |
| User Researcher | `user-researcher` | Qualitative research perspective |
| Customer Success | `customer-success` | Customer experience and support lens |

### Panel agents (multi-persona review)

| Agent | Short name | Purpose |
|---|---|---|
| Customer Panel | `customer-panel` | Reviews proposals through all customer personas |
| Stakeholder Panel | `stakeholder-panel` | Reviews proposals through partner/B2B personas |

### Stakeholder agents (create your own)

Stakeholder agents simulate real executives for stress-testing proposals. See `.claude/agents/stakeholder-template.md` to create your own.

---

## Invocation model

Each persistent agent operates in two modes:

| Mode | How it works | When |
|---|---|---|
| **Automated** | Scheduled script runs the agent's refresh — updates state file, posts notifications if anything needs attention | On a cadence (daily, weekly) via launchd/cron |
| **On-demand** | You invoke `@{short-name}` for a deeper conversation; agent reads its already-fresh state file | Any time |

The automation keeps state files current so on-demand invocations are fast and cheap — the agent already knows the context and doesn't need to re-derive from raw sources.

### Recommended automation schedule

Start simple and build up:

| Agent | Recommended cadence | Why |
|---|---|---|
| `cos` | Daily (morning) | Meeting prep and action tracking need to be fresh |
| `analyst` | Weekly (Monday) | Metrics refresh weekly; Monday gives you the latest data |
| `uxr` | Weekly (Monday) | Aggregates the week's signals before your week starts |
| `coach` | Weekly (Friday) | End-of-week reflection is the natural review point |
| `manager` | Weekly (Monday) | Prep for the week's 1:1s |
| `strategist` | Weekly (Friday) | Prepares the leadership update before the weekend |
| `product-manager` | On-demand | Updates state as a side-effect of each invocation |
| `engineer` | Weekly (Friday) | End-of-week workspace health check |

See `scripts/README.md` for how to set up automation.

---

## Persistent agent definitions

### COS
**Chief of Staff**

**Outcome:** You walk into every meeting prepared, every action is tracked, nothing slips, and your time is well spent.

**Responsibilities:**
- Generate daily briefing and focus priorities
- Prepare meeting briefs for all 1:1s and recurring meetings
- Extract actions from meetings and assign to the right owner
- Chase overdue follow-ups — flag items ageing without progress
- Monitor calendar density and flag when meeting load is unsustainable
- Surface schedule conflicts with focus time or priorities

**Tools:** `/daily-prep`, `/meeting-prep`, `/meeting-schedule`, `/todo`

**Key sources:**
- `team/{initials}/todo_list.md` — current action items
- `context/current-priorities.md` — quarterly priorities
- Calendar and meeting notes (via MCP)

**State file:** `team/{initials}/agents/state/cos.md`

---

### UXR
**UX Researcher**

**Outcome:** The team always knows what users are experiencing, what the market is doing, and where the biggest unmet needs are. Signals are spotted early and connected across sources.

**Responsibilities:**
- Monitor user sentiment across review platforms and support channels
- Extract signals from user interviews, research sessions, and meeting transcripts
- Aggregate and theme product suggestions from the team
- Track competitor moves and assess strategic implications
- Synthesise qualitative research — connect new findings to existing evidence
- Maintain a rolling theme tracker: what's growing, fading, or new
- Ground insights in personas — identify which persona a theme affects most

**Tools:** `/customer-reviews`, `/app-review-digest`, `/product-suggestions-digest`, `/competitor-monitor`, `/investigate`, `/verify-source`

**Key sources:**
- `insights/qual/` — qualitative research studies
- `insights/market/competitors/` — competitive landscape
- `context/personas/customer-personas.md` — user personas

**Hypothesis validation protocol:**
When validating any hypothesis, the UXR agent MUST:
1. Search `insights/` first — the primary evidence base
2. Seek both confirming AND disconfirming evidence
3. Check multiple source types — a strong signal appears across sources
4. Flag the evidence gap — if only confirming evidence is found, state it explicitly
5. Cite precisely — file path, study name, sample size, date

**State file:** `team/{initials}/agents/state/uxr.md`

---

### Analyst
**Product & Commercial Analyst**

**Outcome:** Every decision is grounded in accurate data. Trends are spotted before they become problems. Experiment results are analysed rigorously and learnings are captured.

**Responsibilities:**
- Monitor core funnel trends and flag anomalies
- Distinguish product-driven vs external metric changes
- Track leading indicators and alert before lagging ones confirm problems
- Spot patterns and segments of interest
- Answer ad hoc data questions using your data warehouse
- Maintain a "known gotchas" list for data interpretation
- Verify evidence quality when data is cited in decisions
- Analyse experiment results — validate statistical significance, check guardrails, assess segments

**Tools:** `/investigate`, `/verify-source`, `/experiment-writeup`, data warehouse (via MCP)

**Key sources:**
- `data/funnel-context.md` — canonical metric definitions
- `data/reports/` — data exports and reports
- `data/experiment-results-log.md` — experiment tracking

**State file:** `team/{initials}/agents/state/analyst.md`

---

### Coach

**Outcome:** You become a better product leader. You are continuously learning and improving. Patterns are spotted, goals are tracked, and growth compounds over time.

**Responsibilities:**
- Conduct weekly operating reviews (progress, stale work, effectiveness)
- Conduct monthly reviews (aggregate patterns, assess goals, set new ones)
- Track development priorities from performance reviews
- Spot recurring themes across weeks that aren't being addressed
- Monitor operating patterns and flag when behaviour drifts from intentions
- Surface when workload patterns don't match stated priorities
- Recommend learning opportunities tailored to current development gaps

**Tools:** `/weekly-review`

**Key sources:**
- `team/{initials}/weekly-reviews/` — weekly review history
- `team/{initials}/monthly-reviews/` — monthly review history
- Performance and development goals

**State file:** `team/{initials}/agents/state/coach.md`

---

### Manager

**Outcome:** Your direct reports are levelling up, standards are maintained, and nothing falls through the cracks on your team.

**Responsibilities:**
- Track direct report progress against goals and development priorities
- Prepare 1:1 briefs with recent context and open items per person
- Flag when a PM is stuck, blocked, or not progressing
- Surface common patterns across the team (recurring issues, skills gaps)
- Monitor experiment and project quality against playbook standards
- Track hiring pipeline if applicable

**Tools:** `/meeting-prep`, `/weekly-review`, `/todo`

**Key sources:**
- `team/{initials}/` — 1:1 notes, PM-specific context files
- `context/current-priorities.md` — who owns what
- `pm-playbook/` — quality standards for project docs

**State file:** `team/{initials}/agents/state/manager.md`

---

### Strategist

**Outcome:** Leadership has an accurate, consistent picture of what's happening, what matters, and what needs their input.

**Responsibilities:**
- Draft executive updates and communications
- Maintain a consistent narrative across updates (no contradictions week to week)
- Track what leadership cares about and frame updates accordingly
- Surface items that need escalation or executive input
- Connect operational details to strategic priorities

**Tools:** `/weekly-review`

**Key sources:**
- `context/current-priorities.md` — quarterly priorities and targets
- `strategy/` — roadmaps and strategic documents
- Other agents' state files — synthesise across domains

**State file:** `team/{initials}/agents/state/strategist.md`

---

### Product Manager

**Outcome:** Every investigation is rigorous and builds on prior work. The PM playbook is followed, evidence is grounded, and learnings accumulate.

**Responsibilities:**
- Run structured investigations using the PM playbook stages
- Ensure new work references prior investigations and experiment results
- Maintain a map of what's been explored, what's been tested, and what's still unknown
- Flag when a proposal skips evidence stages or lacks rigour
- Connect current investigations to past experiment learnings

**Tools:** `/investigate`, `/create-new-project`, `/experiment-setup`, `/experiment-writeup`, `/verify-source`, `/prototype`

**Key sources:**
- `projects/` — active experiments and project docs
- `data/experiment-results-log.md` — past experiment results
- `pm-playbook/` — process and templates
- `insights/` — research and evidence base

**State file:** `team/{initials}/agents/state/product-manager.md` (100-line budget)

---

### Engineer

**Outcome:** The workspace runs cleanly and reliably. Automation works, files are well-organised, and technical debt is managed.

**Responsibilities:**
- Monitor automation health — are scheduled scripts running successfully?
- Flag stale state files or broken references
- Check for file organisation issues (orphaned files, broken links)
- Monitor repo health (large files, gitignore coverage)
- Surface technical improvements that would make the workspace more effective

**Tools:** Bash, Glob, Grep (direct codebase access)

**Key sources:**
- `scripts/` — automation infrastructure
- `scripts/logs/` — execution logs
- All workspace files — for health checks

**State file:** `team/{initials}/agents/state/engineer.md`

---

## State file format

All persistent agents use a standard state file format. See `team/TEMPLATE/agents/state/example-state.md` for the template.

**Key rules:**
- **80-line budget** (100 for product-manager) — forces prioritisation
- **Frontmatter:** `Last refreshed: {datetime}` and `Next due: {datetime}`
- **Sections:** Active items, Watch list, Patterns, Open requests
- **Pruning:** Resolved items are removed (not marked done). Watch list items older than 4 weeks are removed. Patterns older than 1 quarter are archived
- **Quarterly archive:** At quarter start, archive all state files and rebuild fresh

## Long-term memory

Each agent also has a memory file (150-line budget) plus a shared memory file (200-line budget). Memory stores permanent institutional knowledge that survives state pruning:

- Data gotchas that keep recurring
- Seasonal patterns
- Stakeholder preferences
- Past investigation conclusions
- Experiment learnings that inform future work

**When to write to memory:**
- When state is being pruned (move permanent learnings first)
- When an investigation concludes
- When you say "remember this"
- When an experiment writeup is created

**When to read memory:**
- At the start of every refresh
- When starting a new investigation (check what's already known)

See `team/TEMPLATE/agents/memory/` for the template format.

---

## Cross-agent collaboration

Agents read each other's state files for context:

| Agent | Reads from |
|---|---|
| `cos` | All state files (for daily brief synthesis) |
| `analyst` | `uxr` (to connect quant trends to qual signals) |
| `uxr` | `analyst` (to check if qual themes have quant support) |
| `coach` | `cos` (for operating patterns), `manager` (for team context) |
| `manager` | `coach` (for your development context) |
| `strategist` | All state files (for leadership narrative) |
| `product-manager` | `analyst`, `uxr` (for evidence and signals) |
| `engineer` | All state files (for health monitoring) |

This enables agents to build on each other's work without back-and-forth conversations.
