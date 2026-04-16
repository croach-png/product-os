# Verify Source — Output Template

Use this template when presenting the results of a `/verify-source` audit.

```
## Verify Source: [Brief topic description]

**Date:** [YYYY-MM-DD]
**Statements audited:** [Number]

### Summary

[2-3 sentence overview: overall confidence level, key concerns, whether the evidence holds up]

### Statement-Level Audit

| # | Statement | Source | Confidence | Bias Risk | Issue |
|---|-----------|--------|:----------:|-----------|-------|
| 1 | [Statement] | [Source file/doc] | High/Med/Low | [Any bias flags] | [Issue or "None"] |
| ... | ... | ... | ... | ... | ... |

### Corrections or Clarifications

[List any statements that need rewording, reattribution, or caveating. If none, say "None required."]

### Counter-Evidence Found

[List any contradictory or complicating evidence found in the workspace. If none, explain why — is it well-tested or just untested?]

### dbt Layer Verification

[For each data-related statement, report what was checked in dbt. If no statements referenced data/metrics, write "No quantitative claims to verify."]

| # | Metric/Claim | dbt Model | Definition Match | Model Health | Issues |
|---|-------------|-----------|:----------------:|:------------:|--------|
| 1 | [Claim] | [model name] | Yes/No/Partial | Healthy/Unhealthy/Unknown | [e.g. "Hidden filter excludes test accounts" or "None"] |
| ... | ... | ... | ... | ... | ... |

[Note any models that couldn't be found in dbt, or any metrics with no clear model — these are themselves evidence gaps worth flagging.]

### Evidence Gaps

[What would we need to know to be more confident? What data don't we have?]

### Upstream Reliability Issues

[If a third or more of statements were low-confidence, corrected, or misleading, include this section. Otherwise, write "No systemic issues — isolated corrections only."]

**Root cause(s):** [e.g. stale source documents, single-source reliance, missing definitions]

**Specific actions to prevent recurrence:**
- [Concrete action 1 — e.g. "Refresh `insights/user-research-q4.md` with current quarter data"]
- [Concrete action 2 — e.g. "Add quant validation for the claim that users prefer X — pull from analytics"]
- ...

### Recommendation

[One of: **Proceed with confidence** / **Proceed with caveats** (list them) / **Gather more evidence before acting** (specify what)]
```
