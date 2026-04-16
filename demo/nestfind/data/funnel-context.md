# Key Metrics and KPIs

> ⚠️ **DEMO DATA** — Fictional metrics. Replace with your own when ready.

---

## Reporting Cadence

- **Timeframe:** Weekly (Monday to Sunday)
- **Report day:** Tuesday (previous week's data)
- **Monthly deep-dive:** First Tuesday of each month

---

## Funnel Overview

**Landlord funnel:**
Visit → Start Listing → Photos Complete → Listing Published → Application Received → Tenant Selected → Tenancy Started

**Tenant funnel:**
Visit → Search (3+ listings viewed) → Save / Apply → Referencing Passed → Offer Accepted → Move-in Complete

Key transitions: Listing publication is the landlord activation moment. Photo completion is the biggest landlord drop-off. Application-to-tenancy depends on referencing speed and landlord responsiveness.

---

## Core Metrics

### Landlord: Visits

**Definition:** Unique visitors to any landlord-facing page (list your property, pricing, landlord dashboard) per week.

**Why it matters:** Top-of-funnel input for supply. Driven by SEO, PPC, and word of mouth.

**Typical value:** ~6,200/week

**Leading or lagging:** Leading

---

### Landlord: Listing Start Rate

**Definition:** Percentage of landlord visits that begin the listing flow (enter property address or upload first photo).

**Why it matters:** Measures whether the value proposition is compelling enough to start.

**Typical value:** 28%

**Leading or lagging:** Leading

---

### Landlord: Listing Completion Rate

**Definition:** Percentage of started listings that reach "published" status. Excludes drafts saved but not published within 14 days.

**Why it matters:** The biggest drop-off in the landlord funnel. Currently 52% — the photo/description step is the main friction point.

**Typical value:** 52% (target: 68%)

**Leading or lagging:** Leading

---

### Landlord: Time to Let

**Definition:** Median days from listing going live to tenancy agreement signed.

**Why it matters:** Faster lets = happier landlords = more repeat listings. Also a signal of pricing accuracy and demand health.

**Typical value:** 18 days (flats: 12, houses: 22, HMOs: 28)

**Leading or lagging:** Lagging

---

### Tenant: Application Conversion Rate

**Definition:** Percentage of tenant visits (3+ listings viewed) that result in at least one submitted application within 14 days.

**Why it matters:** Core demand-side health metric.

**Typical value:** 11% (target: 15%)

**Leading or lagging:** Leading

---

### Tenant: Application-to-Tenancy Rate

**Definition:** Percentage of submitted applications that result in a signed tenancy agreement.

**Why it matters:** Measures the efficiency of the matching and referencing process. Low rates mean wasted tenant effort and landlord time.

**Typical value:** 34% (target: 45%)

**Leading or lagging:** Lagging

---

### Marketplace: Dispute Rate

**Definition:** Percentage of tenancies where either party raises a formal dispute within the first 90 days.

**Why it matters:** Direct measure of trust and listing accuracy. Disputes are expensive (~£85/dispute in ops cost) and damage reputation.

**Typical value:** 4.8% (target: 3%)

**Leading or lagging:** Lagging

---

### Marketplace: GMV

**Definition:** Gross merchandise value — total annual rent value of tenancies started in the period.

**Why it matters:** Top-line growth metric. Revenue = tenant fees + landlord subscriptions.

**Typical value:** £12M/month

**Leading or lagging:** Lagging

---

## Metric Relationships

- **Listing completion and time-to-let are linked:** Listings with professional photos and complete descriptions let 35% faster. Improving listing quality has a compounding effect through the funnel.
- **Referencing speed and application conversion are correlated:** When referencing drops below 3 days, application-to-tenancy rate improves by ~8pp — tenants don't drop out to accept offers elsewhere.
- **Dispute rate lags listing quality changes by ~6 weeks:** Due to move-in timing and the 90-day dispute window.
- **Tenant demand is seasonal:** September (student lets) and January (new year moves) see highest demand. December is softest.
- **GMV can grow while margins shrink:** A shift toward lower-rent properties increases volume but reduces average revenue per tenancy.

---

## Data Sources

| Metric | Primary Source | Secondary Source | Notes |
|--------|---------------|-----------------|-------|
| Landlord visits | GA4 | — | Filtered to landlord pages only |
| Listing rates | Product database | Amplitude | Database is authoritative |
| Application conversion | Product database | GA4 | GA4 undercounts due to ad blockers |
| Dispute rate | Ops database | Zendesk tickets | Ops DB is source of truth |
| GMV / Revenue | Stripe | Data warehouse | Stripe is source of truth |
