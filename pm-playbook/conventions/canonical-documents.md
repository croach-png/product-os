# Canonical Documents

A documentation convention for the PM org. Every major entity — squads, initiatives, workstreams — gets one authoritative document as its index. Based on [Naomi Gleit's "Canonical Everything" methodology](https://naomi.com/canonical-everything-c85441a84e70).

## Core principles

These apply to all canonical docs, regardless of level.

1. **One doc to rule them all.** Each entity has exactly one canonical doc. If someone asks "where do I find out about {X}?", the answer is always the canonical doc.

2. **Links, doesn't duplicate.** The canonical doc summarises and links to detailed docs. Don't copy-paste a discovery analysis into it — link to `discovery.md`.

3. **Recursion.** Every major item listed in a canonical doc should have its own canonical doc. A squad canonical links to each initiative's canonical. An initiative canonical links to each workstream's docs. It's canonical docs all the way down.

4. **Single-threaded ownership.** Every canonical doc has one clear owner responsible for keeping it current.

5. **Canonical nomenclature.** Use consistent terms everywhere. Reference `data/funnel-context.md` and `context/glossary.md` for company-specific definitions.

## Levels

| Level | Location | Owner | Links to |
|-------|----------|-------|----------|
| **Squad** | `squads/{squad}/canonical.md` | Squad PM | Initiative canonicals, quarterly tracking, team info |
| **Initiative** | `projects/{slug}/canonical.md` | Owning PM | Stage artifacts (discovery, prototypes, experiment, results) |
| **Workstream** | Within initiative folder | Workstream lead | Sub-docs if needed |

## Squad canonical template

```markdown
# {Squad Name} — Canonical Document

> Owner: {PM name}
> Last updated: {date}

## Mission

<!-- One sentence. What does this squad exist to do? -->

## Goals — {Quarter}

<!-- Current quarter outcome metrics with targets. Link to quarterly tracking sheet for detail. -->

| Goal | Metric | Target | Status |
|------|--------|--------|--------|
| | | | |

See also: [{Quarter} Quarterly Tracking — {Squad}](link)

## Team

| Role | Name |
|------|------|
| PM | |
| EM | |
| Designer | |
| Analyst | |
| Key stakeholders | |

## Active Projects

<!-- Link to each initiative's canonical doc. Brief status summary here. -->

| Project | Owner | Stage | Status | Doc |
|---------|-------|-------|--------|-----|
| | | | | [canonical.md](link) |

## Opportunity Backlog

<!-- Prioritised list of what the squad could work on next, with brief rationale. -->

1. **{Opportunity}** — {Why it matters / evidence}
2. ...

## Processes

### Meetings & cadence

| Meeting | Frequency | Attendees | Purpose |
|---------|-----------|-----------|---------|
| | | | |

### Communication

- **Slack channel**: #{channel}
- **Notion space**: {link}

### How we work

<!-- Squad-specific process notes. Don't repeat org-wide process — link to pm-playbook/ instead. -->

## Key Context

- [Funnel definitions](../../data/funnel-context.md)
- [Product overview](../../context/product.md)
- [Current priorities](../../context/current-priorities.md)
- [Customer personas](../../context/personas/customer-personas.md)
- [Partner personas](../../context/personas/partner-personas.md)
```

## Initiative canonical template

Every initiative in `projects/{slug}/` gets a `canonical.md` alongside its stage artifacts:

```
projects/{slug}/
  canonical.md          ← The one doc
  discovery.md          ← Stage 1: Discovery & Prioritisation
  prototypes.md         ← Stage 2: Solution Prototyping & Validation
  experiment.md         ← Stage 3: Experiment Design & Prioritisation
  launch-checklist.md   ← Stage 5: Build & Launch (copy of template)
  results.md            ← Stage 6: Analyse & Learn
```

```markdown
# {Initiative Name} — Canonical Document

> Owner: {PM name}
> Squad: {squad name}
> Last updated: {date}
> Current stage: {Discovery | Prototype | Experiment Design | Design | Build & Launch | Analyse & Learn}

## Summary

<!-- One paragraph: what problem are we solving, for whom, and why now -->

## Current status

<!-- 2-3 sentences: where are we, what's the next step -->

## Stage artifacts

| Stage | Doc | Status |
|-------|-----|--------|
| Discovery | [discovery.md](discovery.md) | {Complete / In progress / Not started} |
| Prototype | [prototypes.md](prototypes.md) | {Complete / In progress / Not started} |
| Experiment | [experiment.md](experiment.md) | {Complete / In progress / Not started} |
| Launch checklist | [launch-checklist.md](launch-checklist.md) | {Complete / In progress / Not started} |
| Results | [results.md](results.md) | {Complete / In progress / Not started} |

## Key metrics

- **Primary metric:** {metric name} (baseline: {value})
- **Guardrails:** {metrics that must not degrade}

## Key decisions

<!-- Decisions made during this initiative, with date and context -->
- {YYYY-MM-DD}: {Decision and rationale}

## Links

- Squad canonical: {link if exists}
- Notion project page: {link if exists}
- Jira: {link if exists}
- Slack channel: {link if exists}
```

## How to maintain

### When to create

- **Squad canonical:** When a squad is formed or at the start of each quarter
- **Initiative canonical:** When the first stage artifact is created (usually `/investigate` creating `discovery.md`)

### When to update

- **After completing a stage:** Update the stage artifacts table and current stage
- **When a decision is made:** Add to Key decisions
- **Weekly:** Quick status update (2 minutes). Update the "Current status" and "Last updated"
- **Quarterly:** Full review — check all links work, remove completed initiatives, update goals

### How commands interact with canonical docs

| Command | Canonical action |
|---------|-----------------|
| `/investigate` | Creates initiative folder + `canonical.md` + `discovery.md` |
| `/prototype` | Updates canonical: stage → Prototype, adds prototypes.md link |
| `/create-new-project` | Updates canonical: stage → Experiment Design, adds experiment.md link, updates Key metrics. Copies launch checklist template into the project folder |
| `/experiment-writeup` | Updates canonical: stage → Analyse & Learn, adds results.md link, adds decision to Key decisions |

If a command runs and no canonical doc exists for the initiative, create one.

### How agents interact with canonical docs

All agents should reference canonical docs when looking up initiative status:
- **PM agent:** Creates and updates canonical docs as it progresses through stages
- **COS agent:** Checks that initiative canonical docs exist and are current; flags when initiatives aren't linked from squad canonicals
- **Manager agent:** Can reference initiative canonicals when assessing squad project quality
- **Analyst agent:** Can reference initiative canonicals to find experiment docs for analysis

## FAQs

**How is this different from our quarterly tracking sheet?**
The quarterly tracking sheet is a snapshot of planned work and progress for a specific quarter. The canonical doc is persistent — it covers mission, team, processes, and backlog as well as active work, and it carries forward across quarters. The tracking sheet is one input that gets linked from the canonical doc.

**How often should I update this?**
As things change. A good rhythm is: update the status/active projects section weekly (takes 2 minutes), review the full doc at the start of each quarter. If someone asks a question and the answer isn't in the canonical doc, add it.

**Does my EM/designer need to contribute?**
Share it with them and ask for input on the team and process sections. But the PM owns and maintains it.
