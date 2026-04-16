# Release & Experiment Launch Checklist

Checklist for all product releases (experiments and non-experiment launches). Every item must have a named owner. The PM is responsible for ensuring the checklist is completed — not for doing every item themselves.

This applies to **all releases**, not just your experiment platform experiments. If you're shipping a code change that affects users, use this checklist.

---

## 1. Pre-build: Define success and risk

> **When:** Before engineering starts building. **Owner:** PM

- [ ] Success metric and guardrail metrics defined and agreed with analyst
- [ ] Baseline values for success and guardrail metrics captured (what does "normal" look like today?)
- [ ] Key questions listed — what do we need to track to answer them?
- [ ] Risks identified — what could go wrong? What would the impact be?
- [ ] Rollback plan defined — how do we revert if something breaks? (feature flag, config change, code revert)

---

## 2. Pre-launch: QA & validation

> **When:** Before going live. **Owners:** PM, EM, Analyst

### QA (Owner: EM)

- [ ] Acceptance criteria tested against every requirement in the spec/experiment doc
- [ ] Edge cases and error states tested (e.g., incomplete profiles, unusual account types, timeout scenarios)
- [ ] Regression check — existing flows that could be affected have been tested
- [ ] Cross-browser / cross-device testing where applicable
- [ ] Tested in staging environment with production-like data
- [ ] If experiment: your experiment platform setup reviewed — audience allocations, variant previews, no config errors

### Tracking & data (Owner: PM + Analyst)

- [ ] Event tracking implemented per the [tracking template](event-tracking-template.md)
- [ ] Tracking verified firing correctly in staging (not just implemented — actually validated)
- [ ] Dashboard built and showing data correctly from staging/test events
- [ ] If experiment: run time and sample size recorded

### Rollback readiness (Owner: EM)

- [ ] Feature flag or kill switch in place and tested (can we turn this off in under 5 minutes?)
- [ ] Rollback procedure documented (who does what, in which system)
- [ ] Team knows who has permissions to roll back outside working hours

---

## 3. Pre-launch: Communications & sign-off

> **When:** Before going live. **Owner:** PM

- [ ] Stakeholders notified of upcoming launch (what, when, what to expect)
- [ ] Relevant operational teams briefed (Customer Success, Sales, Support) — do they know what's changing and how to handle questions?
- [ ] Any required sign-offs captured (e.g., legal, finance, leadership for high-risk changes)

---

## 4. Launch: Controlled rollout

> **When:** Go-live. **Owner:** EM + PM

- [ ] Gradual rollout plan agreed (e.g., 5% → 25% → 50% → 100%, with hold periods)
- [ ] Initial rollout to smallest audience first
- [ ] PM and EM online and monitoring during initial rollout
- [ ] Launched — timestamp recorded: `___________`

---

## 5. Post-launch: Active monitoring (first 48 hours)

> **When:** 2 hours, 24 hours, and 48 hours after launch. **Owners:** PM + EM + Analyst

### 2-hour check (Owner: EM + PM)

- [ ] Tracking events firing correctly in production (spot-check real data, not just "no errors")
- [ ] No error spikes in logs or monitoring tools
- [ ] Feature behaving as expected — PM has manually walked through the live experience
- [ ] Dashboard updating with real data

### 24-hour check (Owner: PM + Analyst)

- [ ] Dashboard metrics make sense — are numbers in the expected range vs. baseline?
- [ ] No unexpected changes in guardrail metrics (e.g., drop in conversion, increase in errors, cancellation spike)
- [ ] Funnel volumes look normal — no unexpected drops or surges
- [ ] If experiment: variant split is balanced and sample is accumulating as expected

### 48-hour check (Owner: PM + Analyst)

- [ ] Confirm all tracking is complete and accurate (compare against expected volumes)
- [ ] Check for any downstream data issues (e.g., reporting pipelines, BI dashboards, finance data)
- [ ] Decision: proceed with rollout ramp, hold, or roll back?

---

## 6. Post-launch: Comms

> **When:** Within 24 hours of launch. **Owner:** PM

- [ ] Launch update posted to relevant Slack channel with: what launched, what to watch for, who to contact with issues
- [ ] Wider business comms if user-facing change (format depends on scale — Slack message, email, or product update)

---

## What to do when something goes wrong

1. **Don't wait for certainty.** If something looks off, flag it immediately. A false alarm costs nothing; a missed issue damages trust.
2. **Roll back first, investigate second.** If there's a user-facing problem, disable via feature flag or roll back. Don't try to hotfix under pressure.
3. **Notify stakeholders proactively.** If you've rolled back or paused, tell people before they find out themselves. A short Slack message: "We've paused [X] while we investigate [Y]. Will update in [timeframe]."
4. **Run a brief retro.** What went wrong, what did the checklist miss, how do we prevent it next time? Update this checklist if needed.

---

## Quick reference: Who owns what

| Check | PM | EM | Analyst |
|---|---|---|---|
| Success metrics & baselines | **Lead** | | Support |
| QA & regression | Support | **Lead** | |
| Tracking implementation | Support | **Lead** | Support |
| Tracking validation | **Lead** | | **Lead** |
| Dashboard | Support | | **Lead** |
| Rollback plan | Support | **Lead** | |
| Comms & stakeholders | **Lead** | | |
| Post-launch monitoring | **Lead** | **Lead** | **Lead** |
