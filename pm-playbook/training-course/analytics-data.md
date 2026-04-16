# Analytics Data: Onboarding Funnel Deep Dive

*This is a fabricated scenario for training purposes. Numbers are illustrative, not real company data.*

---

## Funnel overview (last 8 weeks)

| Week | Sign-ups | Profile Setup | Invite Teammates | First Project | Activated | Paid |
|------|----------|--------------|-----------------|---------------|-----------|------|
| Wk 1 | 3,180 | 2,862 (90.0%) | 1,082 (37.8%) | 866 (80.0%) | 693 (80.0%) | 471 (68.0%) |
| Wk 2 | 3,220 | 2,898 (90.0%) | 1,101 (38.0%) | 881 (80.0%) | 705 (80.0%) | 479 (68.0%) |
| Wk 3 | 3,150 | 2,835 (90.0%) | 1,067 (37.6%) | 854 (80.0%) | 683 (80.0%) | 464 (68.0%) |
| Wk 4 | 3,280 | 2,952 (90.0%) | 1,122 (38.0%) | 898 (80.0%) | 718 (80.0%) | 488 (68.0%) |
| Wk 5 | 3,190 | 2,871 (90.0%) | 1,062 (37.0%) | 850 (80.0%) | 680 (80.0%) | 462 (68.0%) |
| Wk 6 | 3,210 | 2,889 (90.0%) | 1,069 (37.0%) | 855 (80.0%) | 684 (80.0%) | 465 (68.0%) |
| Wk 7 | 3,240 | 2,916 (90.0%) | 1,109 (38.0%) | 887 (80.0%) | 710 (80.0%) | 483 (68.0%) |
| Wk 8 | 3,200 | 2,880 (90.0%) | 1,094 (38.0%) | 877 (80.1%) | 704 (80.3%) | 479 (68.0%) |

## Step-by-step drop-off analysis

### Profile Setup (90% completion)
Relatively healthy. Users who sign up mostly complete their profile.
- Main drop-off reason: users who sign up but never return (bounce)
- Mobile vs desktop: desktop 92%, mobile 87%
- Time to complete: median 2.1 minutes

### Invite Teammates (38% completion — the problem step)
This is where the funnel breaks. 62% of users who complete profile setup never send a team invite.

**Micro-funnel within the invite step:**
| Sub-step | Completion | Drop-off |
|----------|-----------|----------|
| Viewed invite screen | 100% | — |
| Entered first email | 52% | 48% never start |
| Sent first invite | 38% | 14% start but don't send |
| Invited 2+ people | 24% | — |

**Key segment differences:**
| Segment | Invite completion rate | Notes |
|---------|----------------------|-------|
| Users who viewed pricing page first | 51% | Higher intent |
| Users from organic search | 34% | Lower intent, exploring |
| Users from paid ads | 29% | Often looking for solo tool |
| Users who signed up on mobile | 25% | Mobile invite flow is harder |
| Users who signed up on desktop | 43% | Better invite UX |
| Enterprise trial users | 62% | Usually told to evaluate by manager |

**Time-based patterns:**
- 70% of users who will ever invite do so within the first session
- Users who leave the invite step and return later: only 15% complete it
- Day-of-week effect: Tuesday and Wednesday sign-ups have highest invite rates (+5pp)

### First Project → Activated → Paid
Once users get past the invite step, the funnel is relatively healthy:
- First Project completion: 80% (stable)
- Activation: 80% of those who create a project (stable)
- Paid conversion: 68% of activated users (within 30 days)

## Cohort analysis: Does invite behaviour predict retention?

| Cohort | 30-day retention | 90-day retention | LTV |
|--------|-----------------|-----------------|-----|
| Invited 0 teammates | 12% | 4% | $82 |
| Invited 1 teammate | 58% | 41% | $490 |
| Invited 2-4 teammates | 74% | 62% | $840 |
| Invited 5+ teammates | 89% | 78% | $1,420 |

**The data is clear:** team invites are the strongest predictor of retention and LTV. Users who invite even one person are 5x more likely to retain at 30 days.

## Historical experiment results

| Experiment | Change | Impact on invite rate | Impact on activation | Decision |
|-----------|--------|----------------------|---------------------|----------|
| Skip option added | "Skip for now" button | -40% invite rate | +12% overall completion | Shipped (net positive) |
| Reminder emails | Day 3 + Day 7 nudges | +2% invite rate | Negligible | Shipped (low cost) |
| Shortened flow | 6 steps → 4 steps | No change | +15% completion | Shipped |
| Social proof | "87% of successful teams..." | +3% invite rate | +1% activation | Inconclusive (p=0.12) |
