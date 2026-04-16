# Experiment Results: Progressive Onboarding

*This is a fabricated scenario for training purposes. All results are illustrative, not real.*

---

## Experiment summary

| Field | Value |
|-------|-------|
| **Name** | Progressive Onboarding — Remove invite gate |
| **Hypothesis** | IF we remove the mandatory invite step from onboarding and instead prompt users to invite teammates at natural collaboration moments (creating 2nd project, assigning a task), THEN activation rate will increase from 22% to 28%, BECAUSE users will reach value faster and invite with higher intent |
| **Primary metric** | Activation rate (sign-up to activated within 14 days) |
| **Secondary metrics** | Invite rate (% who invite at least 1 teammate within 14 days), Time to activation, First project creation rate |
| **Guardrail metrics** | Team size at activation, 30-day retention, Paid conversion rate |
| **Run time** | 4 weeks (2 weeks run + 2 weeks metric maturity) |
| **Traffic split** | 50/50 |
| **Sample size** | Control: 6,400 | Treatment: 6,400 |
| **Platform** | Web only (mobile excluded due to separate onboarding redesign) |

---

## Results

### Primary metric: Activation rate

| Variant | Activation rate | Difference | Confidence |
|---------|----------------|------------|------------|
| Control (current flow) | 22.1% | — | — |
| Treatment (progressive) | 27.8% | **+5.7pp (+25.8%)** | **97.2%** |

**Result: Clear winner.** The treatment significantly outperformed control on the primary metric. The 5.7pp lift exceeds the 6pp target (22% → 28%) set in the hypothesis.

### Secondary metrics

| Metric | Control | Treatment | Change | Significant? |
|--------|---------|-----------|--------|-------------|
| Invite rate (14 days) | 38.0% | 31.2% | **-6.8pp** | Yes (98.1%) |
| Time to activation (median) | 4.2 days | 2.8 days | **-1.4 days** | Yes (99.3%) |
| First project creation | 27.0% | 41.5% | **+14.5pp** | Yes (99.8%) |

**Invite rate dropped but activation rose.** Fewer users invited teammates in the treatment group (-6.8pp), but more users activated overall (+5.7pp). This means many users who would have abandoned at the invite gate now complete onboarding and activate — some solo, some by inviting later at natural moments.

### Guardrail metrics

| Guardrail | Control | Treatment | Change | Status |
|-----------|---------|-----------|--------|--------|
| Team size at activation | 3.2 members | 2.4 members | **-0.8** | ⚠️ Below threshold |
| 30-day retention | 52.1% | 49.8% | -2.3pp | Within tolerance |
| Paid conversion | 68.0% | 65.2% | -2.8pp | Within tolerance |

**Team size is the concern.** Activated users in the treatment have smaller teams (2.4 vs 3.2 members). This could affect long-term retention and LTV if collaboration is the key retention driver.

---

## Segment analysis

| Segment | Control activation | Treatment activation | Lift |
|---------|-------------------|---------------------|------|
| Organic search | 20.5% | 26.8% | +6.3pp |
| Paid ads | 17.2% | 24.1% | +6.9pp |
| Referral | 28.4% | 32.1% | +3.7pp |
| Enterprise trial | 31.0% | 33.5% | +2.5pp |
| **Desktop** | 24.8% | 30.2% | +5.4pp |
| **Mobile** | N/A | N/A | (excluded) |

The experiment lifted activation across all segments, with the largest gains in **paid ads** users (+6.9pp) — the segment that previously had the worst invite completion. Referral and enterprise users saw smaller lifts (they were already higher-intent).

---

## Revenue impact estimate

```
Baseline: 704 activations/week × 68% paid × $49/mo = $23,470/week
Treatment: 890 activations/week × 65.2% paid × $49/mo = $28,420/week
Net increase: +$4,950/week = +$257,400/year
```

**After 40% haircut** (winner's curse, metric translation, novelty): **+$154,440/year**

Note: this estimate uses the treatment's slightly lower paid conversion rate (65.2% vs 68.0%). If the lower team size at activation leads to further retention degradation, the actual revenue impact could be lower.

---

## Interpretation notes

1. **The hypothesis was right about the mechanism:** removing the gate let users reach value faster (time to activation dropped 33%). Users who want to invite still do — just later and with higher intent.

2. **The team size guardrail is a real concern.** Smaller teams at activation correlate with lower long-term retention in historical data. The experiment was too short to measure 90-day retention directly.

3. **The invite rate drop is expected and acceptable.** The goal was never more invites — it was more activations. Users who skip the invite and activate solo may invite later (the "progressive" bet), but we don't have enough data to confirm this yet.

4. **Segment analysis suggests the biggest winners are low-intent users** (paid ads, organic search) who were previously filtered out by the invite gate. High-intent users (referral, enterprise) were less affected because they were already getting through.

---

## Decision options

1. **Ship to 100%** — activation gain is clear, guardrails are within tolerance. Accept the team-size risk and monitor retention over 90 days.

2. **Ship with mitigations** — ship progressive onboarding but add a "smart nudge" to encourage invites at natural collaboration moments (the original plan). This could recover some of the invite-rate loss while keeping the activation gain.

3. **Extend the experiment** — run for 6 more weeks to get 90-day retention data before deciding. Risk: delays the activation improvement by 6 weeks.

4. **Kill** — the team-size concern is too risky. Revert and try a different approach (e.g. demo workspace to show collaboration value without removing the gate).

---

## Stakeholder communication draft

**For: Alex (Product Director)**

> **Onboarding experiment results — strong win with one caveat**
>
> The progressive onboarding experiment hit its target: activation rate moved from 22% to 28% (+5.7pp, 97% confidence). Time to activation dropped from 4.2 to 2.8 days. The biggest gains were in paid-ads users (+6.9pp) — previously our worst-converting segment.
>
> One concern: activated users have smaller teams (2.4 vs 3.2 members). This could affect long-term retention, but we won't know for 90 days. Paid conversion dipped slightly (65.2% vs 68.0%) but is within tolerance.
>
> **Recommendation:** Ship with mitigations — add smart invite nudges at natural collaboration moments to recover team size without re-introducing the gate. Monitor 90-day retention closely.

**For: Jordan (Analyst)**

jordan@example.com — please verify:
1. Activation rate calculation uses 14-day window from sign-up
2. Paid conversion denominator is activated users only (not all sign-ups)
3. Team size at activation = members active within 7 days of activation event
4. Confirm no overlap with the Growth squad's sign-up page test (ran weeks 2-3)
