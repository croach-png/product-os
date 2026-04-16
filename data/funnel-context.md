# Key Metrics and KPIs

This document provides a shared understanding of your core metrics. It is intended as context for analysis, reporting, and decision-making.

<!-- SETUP: This is a critical file. The analyst agent, /investigate command, and
experiment analysis all reference it. Define your metrics precisely — ambiguity
here propagates through every analysis. -->

---

## Reporting Cadence

<!-- SETUP: How often you report on metrics and what a typical reporting period looks like.

Example:
- **Timeframe:** Weekly (Monday to Sunday)
- **Report day:** Tuesday (previous week's data)
- **Example week:** Week commencing 01/01/2026 (Week 1)
-->

---

## Funnel Overview

<!-- SETUP: Draw your funnel. Include every stage from top to bottom.

Example:
**Leads → Sign-Up → Onboarding Complete → Activated → Paid → Retained**

Churn sits between Paid and Retained and is a critical quality signal.

Explain any nuances — for instance, if "Active" includes both new users and
returning users, note the distinction and why it matters. -->

---

## Core Metrics

<!-- SETUP: For each metric in your funnel, provide a definition, why it matters,
and a typical value. Use the format below.

### {Metric Name}

**Definition:** {Precise definition — what counts, what doesn't, how it's calculated}

**Why it matters:** {Why this metric is important for decision-making}

**Typical value:** {Recent example or range}

**Leading or lagging:** {Does this predict future performance (leading) or confirm past performance (lagging)?}

---

Example:

### Leads

**Definition:** The total number of users who visit the pricing page or request a demo during the week.

**Why it matters:** Top-of-funnel input and leading indicator of future revenue. Driven by marketing spend across brand, SEO, PPC, and content channels.

**Typical value:** ~2,500/week

**Leading or lagging:** Leading

---

### Activation Rate

**Definition:** Percentage of sign-ups who complete the onboarding checklist and perform their first [key action] within 7 days.

**Why it matters:** The strongest predictor of long-term retention. Users who activate within 7 days retain at 3x the rate of those who don't.

**Typical value:** 28% (target: 40%)

**Leading or lagging:** Leading
-->

---

## Metric Relationships

<!-- SETUP: Document how your metrics relate to each other and any known gotchas.

Example:
- **Leads and activation are decoupled:** A spike in leads from a viral campaign
  often reduces activation rate because the new cohort is less qualified
- **Retention is a 90-day lagging indicator:** Changes to onboarding won't show
  in retention numbers for 3 months
- **Revenue per user varies by segment:** Enterprise users are 5x the ARPU of
  self-serve users — always segment when analysing revenue trends
-->

---

## Data Sources

<!-- SETUP: Where your metrics come from. This helps the analyst agent know
which tools to query and which sources to trust.

Example:
| Metric | Primary Source | Secondary Source | Notes |
|--------|---------------|-----------------|-------|
| Leads | Analytics platform (GA4) | CRM (HubSpot) | GA4 is authoritative; CRM may double-count |
| Activation | Product database | Analytics | Database is authoritative |
| Revenue | Billing system (Stripe) | Data warehouse | Stripe is source of truth |
-->
