# Proposal: Fixing the Feedback Loop

**Author:** {Your Name}
**Date:** March 2026
**Status:** Draft — for discussion with {CPO} and exec team

---

## The problem

Teams are spending more time agreeing direction than building. Feedback from leadership arrives late, spread across multiple conversations, and without clear rationale — leaving PMs and EMs to piece together what's being asked and why.

This isn't about the quality of the feedback itself. The ideas and challenges raised by leadership are usually valuable. The problem is **how and when** feedback reaches teams, and **what happens after** it's given.

---

## What's happening

### 1. Feedback arrives late in the process

Teams bring work to product review or exec check-ins after weeks of discovery and development. Feedback at this stage — especially if it changes direction — carries high overhead: context switching, unfinished work in flight, unvalidated thinking, new alignment needed.

**Example:** Early docs feedback was delivered over several weeks and the project was paused despite being dev-ready. The team had invested significant effort, and the pause came after the build, not before it.

### 2. Feedback is fragmented across conversations

A direction change might surface as a comment in a 1:1, a Slack message, a question in a product review, and a separate conversation with the EM — but never as a single, clear statement of "here's what I think and why." PMs and EMs end up triangulating the message from multiple signals.

This adds overhead and — more importantly — means teams sometimes get it wrong. They build to what they think was asked, only to find the expectation was different.

### 3. "Look into this" vs "Do this now" is ambiguous

When an exec raises an idea or a concern, it's often unclear whether this is:
- **Explore for later** — "worth thinking about for Q2"
- **Investigate now** — "look into this and come back with a view"
- **Do this now** — "I want this shipped"

Without explicit prioritisation, teams default to treating everything as urgent. This creates unplanned work that displaces planned work, leading to incomplete quarterly plans and missed goals.

**Evidence:** {Team A} switched focus mid-quarter. {Team B} delivered 5 unplanned features. Both cases involved reasonable requests — the issue was the implicit urgency, not the ask itself.

### 4. No follow-through mechanism

Some feedback leads to action, some doesn't, and there's no shared view of which is which. Exec might raise something in a product review, the PM takes a note, but there's no agreement on: is this happening? By when? Who's deciding? This ambiguity means some feedback falls through the cracks entirely, while other feedback gets over-indexed on because the PM assumed it was more urgent than it was.

---

## Impact on teams

| Impact | Description |
|--------|-------------|
| **Longer cycle times** | Spending longer agreeing direction than developing |
| **Context switching** | Unplanned asks displace planned work mid-sprint |
| **Unmet expectations** | Teams deliver what they think was asked; exec expected something different |
| **PM overhead** | PMs spend time triangulating, aligning, and re-aligning rather than driving outcomes |
| **Team morale** | Repeated direction changes erode confidence that the plan will hold. Teams become hesitant to commit to ambitious work |

---

## Root causes

This isn't a people problem — it's a process gap. We don't have a consistent mechanism for:

1. **Getting feedback early enough** — before significant effort is invested
2. **Making feedback explicit** — what's the ask, what's the rationale, what's the priority
3. **Tracking feedback to resolution** — who's acting on it, by when, and what was decided

---

## Proposed changes

### 1. Flag projects that matter at the quarterly check-in

**Problem it solves:** Not everything needs the same level of leadership engagement, but currently there's no shared understanding of which projects leadership wants to weigh in on.

**Proposal:** At each quarterly P&E tracking review, the leadership group identifies which upcoming projects they're particularly interested in. These are flagged as **leadership-attention projects** — typically because they're strategically significant, high-risk, or cross-cutting.

**What this means for PMs:**
- Flagged projects need early directional alignment (see section 4 below)
- Unflagged projects are trusted to the team — leadership reviews outcomes, not plans

**What this means for leadership:**
- Be selective. If everything is flagged, nothing is. Aim for 2–3 projects per quarter across the org
- Flagging means "I want input on direction" — not "I want to approve every decision"

### 2. Scale feedback to project size and risk

**Problem it solves:** Feedback arrives too late because there's no tiered engagement model — everything gets the same treatment.

**Proposal:** The depth of leadership engagement should be proportional to the blast radius.

| Project type | Examples | Leadership engagement |
|---|---|---|
| **Large / high-risk** | New product capability, pricing changes, major flow redesign, cross-team initiatives | Direction alignment before solution design. Check-in at key stage gates (hypothesis, design, pre-launch) |
| **Medium** | Significant experiment on a core flow, new feature within existing product | Async review of hypothesis and success metrics. PM flags if direction is uncertain |
| **Small / iterative** | Copy tests, UI tweaks, minor optimisations, backlog items | No leadership review needed. PM owns end-to-end. Results shared in normal reporting |

PMs should use judgement — if you're unsure whether something needs alignment, it probably does. A 15-minute conversation early is cheaper than rework later.

### 3. Earlier exposure, lighter format

**Problem it solves:** Feedback arrives too late because teams present polished work at product reviews, inviting directional challenges at the worst possible moment.

**Proposal:** PMs share thinking earlier — before designs are polished and before builds start — using a lightweight format (one-pager, Slack post, or 5-minute slot in an existing meeting). The bar is deliberately low: "here's what we're thinking and why" — not a finished plan.

**What this means for execs:** You'll see rougher work earlier. The trade-off is that your input shapes the direction rather than redirecting it.

**What this means for PMs:** You'll need to be comfortable sharing incomplete thinking. The benefit is that when you do build, you're building with confidence.

### 4. Direction alignment at the right moment — then step back

**Problem it solves:** Even when leadership engages, the highest-value input gets diluted by feedback on execution details.

**Proposal:** For flagged or high-risk projects, the alignment checkpoint is **after discovery, before solution design** — i.e., at the point where the team has a clear hypothesis and evidence base, but hasn't committed to a specific solution.

When leadership engages, the highest-value input is on direction:

1. **The problem is worth solving** — Is this the highest-impact opportunity? Does it connect to our strategic priorities?
2. **The hypothesis is sound** — Does the logic hold? Is there evidence behind it?
3. **The success metric is right** — Are we measuring the outcome that matters? Are guardrails in place?
4. **The risks are understood** — What could go wrong? What's the downside if we're wrong?

**Format:** A short brief covering problem statement and evidence, hypothesis, proposed success metric and guardrails, key risks and assumptions, and estimated size/complexity. This can be a 1-page doc shared async or a 15-minute conversation. The goal is a go/no-go on direction, not a detailed review.

**After alignment:** The team owns execution. Leadership stays informed through normal reporting (weekly RAG updates, post-experiment comms) and doesn't re-open directional questions unless new information emerges.

**Known risk — the "{Project X} problem":** The biggest risk with this model is that leadership agrees to a direction, but then reacts when they see the actual design or implementation — effectively re-opening a settled decision. This is exactly what happened with {Project X}: the hypothesis and direction were agreed, but feedback on the solution arrived after the build was complete, causing a pause and significant rework. For this to work, we need an explicit compact: once direction and guardrails are aligned, implementation decisions belong to the team. Leadership input on solution and design is welcome and often valuable — but it should build on the agreed direction, not revisit it. If new information genuinely changes the picture, the right move is to flag it explicitly ("I have new information that changes my view on direction") rather than giving solution-level feedback that implicitly undermines the agreed direction.

### 5. Explicit ask classification

**Problem it solves:** "Look into this" vs "Do this now" is ambiguous.

**Proposal:** When leadership raises a new idea, request, or concern, it gets an explicit classification:

| Classification | Meaning | PM action |
|---------------|---------|-----------|
| **Explore** | Worth investigating, not urgent | Add to opportunity backlog, pick up when capacity allows |
| **Investigate** | Want a view back within a defined timeframe | Time-box discovery, come back with recommendation by [date] |
| **Prioritise** | This should displace planned work | PM proposes what to deprioritise, gets alignment, then acts |

This doesn't require a new tool or process — it requires the habit of asking "is this an explore, investigate, or prioritise?" when a new request lands.

### 6. Written feedback with rationale

**Problem it solves:** Feedback is fragmented and PMs triangulate.

**Proposal:** For material direction changes (not small tweaks), the feedback should be captured in writing — even informally. A Slack message or comment on the doc is fine. The key elements:

- **What's the concern or suggestion?**
- **Why does it matter?** (what's the risk, what's the opportunity)
- **What action is expected?** (stop, change direction, investigate, or just be aware)

This doesn't add much overhead for the person giving feedback, but dramatically reduces the overhead for the person receiving it.

### 7. Feedback tracker in existing rituals

**Problem it solves:** No follow-through mechanism.

**Proposal:** Add a standing "open feedback" section to the weekly PM/exec sync. Nothing new — just a running list of: feedback given → PM owner → status (investigating / actioned / deprioritised with rationale). This makes it visible when feedback has been addressed and when it hasn't, without requiring a separate process.

---

## What I'm not proposing

- **More meetings.** This works within existing cadences
- **Bureaucratic sign-off processes.** The goal is clarity, not gates
- **Restricting exec input.** The input is valuable — the delivery mechanism needs to improve
- **Blaming anyone.** This is a growing-pains problem. We've scaled from a small team where context was ambient to a larger org where it needs to be explicit

---

## How to trial this

1. **Start with one squad** — pick a team that's been most affected (e.g. the team with the most unplanned work last quarter)
2. **Run for one quarter** — adopt the seven changes above for Q2
3. **Measure:** Ratio of planned vs unplanned work delivered; number of mid-quarter direction changes; PM-reported overhead on alignment (qualitative)
4. **Review at Q2 retro** — did it improve? What needs adjusting?

---

## Summary

| Guideline | One-liner |
|---|---|
| Flag what matters | Leadership identifies 2–3 high-interest projects per quarter at the tracking review |
| Scale feedback to risk | Large projects get stage-gate check-ins; small projects need no review |
| Share early, share rough | PMs expose thinking before designs are polished — execs shape direction, not redirect it |
| Direction, then step back | Align on problem, hypothesis, metric, and risk — then trust the team on implementation |
| Classify asks explicitly | Every new request gets labelled: explore, investigate, or prioritise |
| Write it down | Material feedback captured in writing with rationale and expected action |
| Track to resolution | Standing "open feedback" list in existing rituals — visible follow-through |

---

## Discussion questions

1. Does this diagnosis match your experience? What's missing?
2. Which of the seven changes would have the most impact?
3. Is there a risk this creates friction that slows down legitimate urgent requests?
4. Who should own making this stick — PMs, EMs, or both?
5. Can leadership commit to the compact in section 4 — that once direction is aligned, implementation belongs to the team? If not, what additional checkpoint would provide confidence without creating the churn we're trying to fix?
