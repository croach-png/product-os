# Onboarding Plan Template — for Managers

A reusable structure for creating a personalised 90-day onboarding plan for a new PM. This is the artefact you hand to the new hire on Day 1. The **`manager-pm-onboarding-guide.md`** covers what *you* (the manager) need to do; this template covers what *they* work through.

The plan is designed to be used in two ways simultaneously:
- As a **Notion doc** the PM ticks off week by week
- As an **interactive guide inside Claude Code**, so they can ask questions, quiz themselves on reading, and generate outputs as they go

Duplicate this file for each new hire (e.g. `pm-playbook/onboarding/plans/{first-name}-{squad}-onboarding-plan.md`), fill in the placeholders, and share.

---

## How to use this template

1. **Copy the whole file** to a per-hire plan.
2. **Fill in every `{placeholder}`.** If you can't answer one, that's a signal you have work to do before Day 1 — not something to hand-wave.
3. **Delete the *"Guidance for the manager"* callouts** before sharing. They're for you, not the new hire.
4. **Tailor Milestones and Focus area sections to the squad.** The rest of the structure should stay the same across hires.

---

# Onboarding Plan — {Role title, e.g. PM, {Squad} team}

Hi {First name}, welcome to the team — we're really excited to have you. This plan will help you get set up and hit the ground running. Please don't hesitate to reach out to {manager first name} at any point if there's anything they can do to help.

## Step 1: Get set up

This plan is designed to be used in two ways simultaneously — as a Notion doc you track your progress against week by week, and as an interactive guide inside Claude Code. Complete this step as early as possible so you can start using the interactive features from Day 1.

### 1a. General {Your Company} onboarding

Before anything PM-specific, work through the **[New Employee First Day Guide]({link})**. Complete this first.

### 1b. Request access (do before Day 1)

Three things require requests — don't leave these until Day 1:

| What | Who to ask | Why you need it |
|------|-----------|-----------------|
| **Anthropic account** | IT | To authenticate Claude Code |
| **GitHub access** | IT | To clone the PM repo — ask to be added to the `{your-org}` GitHub organisation |
| **Granola account** | IT | For meeting transcripts and todo extraction from Day 1 |

### 1c. Set up Claude Code and clone the repo

Follow **[claude-code-setup-guide.md](./claude-code-setup-guide.md)**. Once you're set up, come back here.

> **Stuck?** Contact IT for access and tooling issues. Message {manager first name} on Slack for PM-specific questions.

---

## Step 2: Use this plan in Notion and Claude Code together

**In Notion (this doc):** Use it to track your progress. Tick off tasks as you complete them. This is your plan of record.

**In Claude Code:** Once you're set up, Claude Code makes the plan interactive. Open the repo, run `claude`, and start with:

> *"I'm starting my onboarding as the new {role}. Please read `pm-playbook/onboarding/plans/{filename}.md` and walk me through today's tasks step by step — ask me to confirm each task before moving on, quiz me on the reading, and help me produce the required outputs."*

---

## Context

You will join the **{Squad name}** team. {One-paragraph description of what the team does, its remit, and why it matters.}

The role reports to {manager first name} and sits within {org structure — e.g. the Product & Engineering organisation under the CPO}.

{One paragraph on the *philosophy* of the role — the thing that's easy to get wrong. For example: "Automation is not the default answer" for an automation PM, or "This is a marketplace role, not a seller role" for a bidirectional PM. This is where you set expectations about how to think, not just what to do.}

**This is an AI-first PM role.** From day one, you'll operate using Claude Code as your primary working environment — drafting docs, querying data, prepping for meetings, running analyses, and managing your todo list through a shared repo with deep {Your Company} context built in. This isn't an optional productivity tool; it's how this team works.

---

## Milestones

These are the checkpoints you'll be measured against. Adjust the timing and content of the last two milestones to match your quarterly planning cycle.

| Milestone | By | What good looks like |
|-----------|-----|---------------------|
| Oriented and set up | End of Week 1 | Understanding goals and business model. Set up with tooling and clear on PM git repo structure. |
| Deep in the evidence | End of Week 2 | Draft opportunity tree of your space, with a discovery plan for validating key areas. |
| Validated hypotheses | End of Week 4 | First experiment doc completed, validated key hypotheses. Helping team deliver current roadmap and starting to identify opportunities to add to the backlog. |
| Executing | Day 60 | First experiment in build or launched, validated backlog prioritised. |
| End of first full quarter | ~Day 90 | Experiments written and in flight. Some early impact being delivered. Following good PM process end to end. |
| End of second quarter | ~Day 180 | Clear, evidence-based understanding of the problem space. Strong validated roadmap. Evidence of moving {team's key metric} or its leading indicators. PM practice consistently in line with {Your Company}'s PM goals. |

---

## A few things to know before you start

**Don't sit on questions.** Ask {manager first name} immediately if something is unclear. A quick conversation is always better than going down the wrong path.

**AI lets you generate content quickly — but everything still needs review.** The goal is excellent work produced faster, not average work produced instantly. Before sharing anything, ask Claude to check it: *"Can you check this for gaps and anything that doesn't read well?"*

**The milestones above are what you're being measured against.** The sections below are things that will help you hit them — they're not a prescribed weekly schedule. Use your judgement.

---

## Core reading

Work through these to understand the business. Prompts included so you can make each reading interactive:

- `context/product.md` — how the product works end-to-end
  > *"Summarise `context/product.md` in plain language. Then quiz me on the {main customer journey} — ask me 3 questions and tell me if I get them right."*
- `context/current-priorities.md` — current focus areas and targets
  > *"Read `context/current-priorities.md` and explain what it means for the {squad} team specifically."*
- `data/funnel-context.md` — funnel definitions, core metrics, leading vs lagging indicators
- `context/personas/` — customer segments and their needs
- `context/brand/messaging/how-we-sound.md` — how the company communicates
- **[PM best practice process]({link to your PM process wiki})** — how we do PM end-to-end. This sets the bar for how we work. Flag any questions with {manager first name}.

---

## {Squad} team context

Start here to understand the space you've inherited and agree your focus area with {manager first name}. Some of this material may be out of date — check anything that seems stale.

- **[{Squad} opportunity tree]({link})** — the starting point for understanding the problem space. Treat it as a hypothesis to validate, not a finished artefact.
- `strategy/team-strategy-docs/{squad}-strategy.md` — the written strategy doc.
- [{Squad} Product wiki]({link}) — archive of everything the team has shipped.
- **Handover from {outgoing PM name}** — {link to handover doc}
- **Handover from {EM name}** — projects in flight, technical context, key relationships.
- **Agree a focus area with {manager first name}** — the one area to go deep on first. This shapes everything else.

---

## {Domain-specific data and analysis}

> **Guidance for the manager.** Every squad has some evidence source that matters more than the others (call transcripts, support tickets, sales notes, session recordings, cohort dashboards). Point at it explicitly here and give the new hire example queries to run in their first week. If you don't have this section for a squad, that's a signal to build it.

**The most valuable evidence source for this role is {source name}.** {Where it lives, how to query it, why it matters.}

Example queries to get started:

> *"{Example query 1 — plain-English question about the data}"*

> *"{Example query 2 — comparative or hypothesis-testing question}"*

> *"{Example query 3 — surfacing opportunities}"*

A few things this data won't tell you: {gaps and blindspots to be aware of}.

---

## Operational immersion

{What "getting close to the operation" looks like for this squad — customer support shadowing, sales ride-along, warehouse visit, live-ops observation. The data tells you what happens; immersion tells you why.}

Arrange via {contact name}. What to do when you're there:
- {Specific thing 1}
- {Specific thing 2}
- {Specific thing 3}

---

## People to meet

| Person | Role | Why |
|--------|------|-----|
| **{Manager name}** | {Manager role} | Line manager, weekly 1:1 |
| **{Peer buddy name}** | PM (peer buddy) | Day-to-day questions, peer support |
| **{EM name}** | EM, {squad} | Team handover — projects in flight, engineering capacity |
| **{Designer name}** | Designer, {squad} | Design partnership, current work |
| **{CPO / product exec name}** | {Role} | Product strategy, expectations |
| **{Data partner name}** | Data Analyst | Dashboards, analytics support |
| **{Cross-functional stakeholders}** | Various | {Why relevant to this role} |

---

## Data dashboards and access to set up

- {Dashboard 1} — {what it shows, how to get access}
- {Dashboard 2} — {what it shows, how to get access}
- {Data-warehouse / BigQuery / Snowflake access} — {any training required, e.g. Data University L1}
- {Squad-specific dashboards}

---

## PM training

Work through all 6 modules using `/learn-1-discovery` through `/learn-6-analyse`. These teach the PM process you'll be expected to follow — do them early so the frameworks are in place before you're writing experiment docs.

---

## Shipping: creating and validating docs

When you're ready to write your first experiment or project doc:

- Use `/create-new-project` — Claude will ask you questions to sharpen your thinking before generating the doc.
- Run `/verify-source` to audit the evidence quality before sharing anything with stakeholders.
- Use the `engineer` agent to stress-test proposals for technical feasibility before review.

---

## Daily workflows

Start using these from Day 1:

- `/meeting-prep {person}` — before every 1:1
- `/todo {initials}, {name}` — after meetings to extract action items
- `/weekly-review {initials}` — end of week reflection and goal-setting

---

## Ongoing support structure

| Support | Detail |
|---------|--------|
| **Line manager** | {Manager name} — weekly 1:1, ad-hoc questions always welcome |
| **Peer buddy** | {Peer name} — day-to-day questions, cross-team context |
| **Operational immersion** | {Cadence — e.g. weekly, bi-weekly} — arranged via {contact} |
| **PM team rituals** | PM sync, quarterly roadmap planning, mid-Q check-ins |
| **Claude Code** | Full company context available 24/7 |

---

## Useful Slack channels

| Channel | Why |
|---------|-----|
| #product-managers | PM team channel |
| #product-launches | Feature launches and releases |
| #reviews | Customer reviews |
| #red-alerts / #amber-alerts | Product issues and incidents |
| #product-suggestions | Internal feedback and feature requests |
| {Squad-specific channels} | {Why} |

---

## Regular meetings & events

| Meeting | Frequency | What | Who |
|---------|-----------|------|-----|
| PM sync | Weekly | PMs share info, discuss approaches | All PMs |
| **Product review** | Ad-hoc — PM-organised | Required before releasing any material feature. Use the template at `pm-playbook/templates/product-review-template.md` | PM-led, key stakeholders |
| P&E All Hands | Monthly | Announcements, demos, progress | All P&E |
| Quarterly roadmap planning | Quarterly | Teams propose goals and roadmaps | All product teams |
| Mid-Q check-in | Mid-quarter | Progress review | Selected teams |
| Company all-hands | Quarterly | Company-wide news | All company |
