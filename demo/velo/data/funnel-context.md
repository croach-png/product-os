# Key Metrics and KPIs

> ⚠️ **DEMO DATA** — Fictional metrics. Replace with your own when ready.

---

## Reporting Cadence

- **Timeframe:** Weekly (Monday to Sunday)
- **Report day:** Tuesday (previous week's data)
- **Monthly deep-dive:** First Tuesday of each month

---

## Funnel Overview

**Seller funnel:**
Visit → Start Listing → Complete Listing → Listing Live → Sold

**Buyer funnel:**
Visit → Browse (3+ listings viewed) → Add to Watchlist / Make Offer → Purchase → Delivery Confirmed

Churn: Sellers who listed once but never listed again within 90 days.
Return: Buyer raises issue within 48-hour inspection window.

---

## Core Metrics

### Seller: Visits

**Definition:** Unique visitors to any seller-facing page (sell landing page, pricing page, listing flow) per week.

**Why it matters:** Top-of-funnel input for supply. Driven by SEO, social, and word of mouth.

**Typical value:** ~8,500/week

**Leading or lagging:** Leading

---

### Seller: Listing Start Rate

**Definition:** Percentage of seller visits that begin the listing flow (upload first photo or select category).

**Why it matters:** Measures whether the sell proposition is compelling enough to start.

**Typical value:** 34%

**Leading or lagging:** Leading

---

### Seller: Listing Completion Rate

**Definition:** Percentage of started listings that reach "listing live" status. Excludes drafts saved but not published within 7 days.

**Why it matters:** The biggest drop-off in the seller funnel. Currently 58% — the condition checklist is the main friction point.

**Typical value:** 58% (target: 72%)

**Leading or lagging:** Leading

---

### Seller: Time to Sell

**Definition:** Median days from listing going live to sale confirmed.

**Why it matters:** Faster sales = happier sellers = more repeat listings. Also a signal of pricing accuracy.

**Typical value:** 9 days (road bikes: 6, mountain bikes: 11, e-bikes: 14)

**Leading or lagging:** Lagging

---

### Buyer: Purchase Conversion Rate

**Definition:** Percentage of buyer visits (3+ listings viewed) that result in a completed purchase within 14 days.

**Why it matters:** Core demand-side health metric.

**Typical value:** 3.8% (target: 5%)

**Leading or lagging:** Lagging

---

### Marketplace: Return Rate

**Definition:** Percentage of completed sales where the buyer raises a condition dispute within the 48-hour inspection window.

**Why it matters:** Direct measure of trust and condition accuracy. High returns erode buyer confidence and cost ~£35/return in logistics.

**Typical value:** 6.2% (target: 4%)

**Leading or lagging:** Lagging

---

### Marketplace: GMV

**Definition:** Gross merchandise value — total value of bikes sold in the period (before fees).

**Why it matters:** Top-line growth metric. Revenue = GMV × take rate.

**Typical value:** £2.1M/month

**Leading or lagging:** Lagging

---

## Metric Relationships

- **Listing completion and time-to-sell are linked:** Bikes with complete condition reports and good photos sell 40% faster. Improving listing quality has a compounding effect.
- **Return rate lags condition verification changes by ~3 weeks:** Changes to the checklist won't show in return data for at least 2-3 weeks due to delivery and inspection timing.
- **Buyer conversion is seasonal:** Summer months (May-Aug) see 1.5x the conversion rate of winter. Always compare year-on-year, not month-on-month.
- **GMV can grow while unit economics shrink:** A shift toward cheaper bikes (hybrids) increases volume but reduces average revenue per transaction. Always check ASP alongside GMV.

---

## Data Sources

| Metric | Primary Source | Secondary Source | Notes |
|--------|---------------|-----------------|-------|
| Seller visits | GA4 | — | Filtered to seller pages only |
| Listing rates | Product database | Amplitude | Database is authoritative |
| Purchase conversion | Product database | GA4 | GA4 undercounts due to ad blockers |
| Return rate | Ops database | Zendesk tickets | Ops DB is source of truth |
| GMV / Revenue | Stripe | Data warehouse | Stripe is source of truth |
