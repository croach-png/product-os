# Evidence Audit Criteria

Reference material for the `/verify-source` command. This file contains the detailed evaluation criteria used when auditing evidence, data, and insights.

## 2a. Source verification

- **What source was cited?** Name the specific file, dataset, research session, or document
- **Is it the right source for this question?** Flag if the source might not be the best fit (e.g. using overall funnel data when the question is about a specific segment, or using one segment to answer a user question)
- **Is the source current?** Note if the data is from a previous quarter or period that may no longer reflect reality
- **Can you verify the claim in the source?** Re-read the cited source and confirm the statement accurately reflects what's there. Flag any misrepresentation, even subtle ones (e.g. "users said X" when actually one user said X)

## 2b. Confidence assessment

Rate each statement as **High**, **Medium**, or **Low** confidence:

| Rating | Criteria |
|--------|----------|
| **High** | Multiple independent sources (qual + quant), adequate sample size, directly measured, current data |
| **Medium** | Single credible source, reasonable sample, some inference required, or data is slightly dated |
| **Low** | Single user quote, very small sample, significant inference, proxy metric, stale data, or uncertain source |

## 2c. Bias check

For each statement, consider:

- **Confirmation bias** — Does this conveniently support a hypothesis we already hold? Did we look for disconfirming evidence?
- **Survivorship bias** — Are we only looking at users who completed something, ignoring those who dropped off or never started?
- **Selection bias** — Is the sample representative, or skewed towards a particular segment (e.g. only power users, only recent joiners)?
- **Anchoring** — Are we over-weighting the first piece of evidence we found?
- **Correlation vs causation** — Are we implying a causal relationship from correlational data?

## 2d. dbt layer verification

For any statement that references a metric, data point, or quantitative claim, check the underlying dbt model to verify that the data means what we think it means. Use the dbt Cloud MCP tools:

1. **Identify the model.** Work out which dbt model likely produces the metric being cited. Use `get_all_models` or `get_mart_models` to search if the model name isn't obvious
2. **Check the definition.** Use `get_model_details` to read the model description, compiled SQL, and column definitions. Verify that:
   - The metric being cited actually maps to a column or calculation in this model
   - Filters, joins, and business logic match what's being claimed (e.g. "active users" — check what the model considers "active")
   - The granularity is correct (e.g. daily vs weekly vs lifetime)
3. **Check model health.** Use `get_model_health` to confirm the model is healthy — last run succeeded, tests passed, upstream sources are fresh. Flag if:
   - The last run errored or tests failed (data may be stale or incorrect)
   - Source freshness is failing or unknown (upstream data may be lagging)
4. **Check upstream lineage.** Use `get_model_parents` to understand where the data originates. Flag if:
   - The model depends on a source with no freshness checks
   - There are intermediate models that apply filters or transformations that could affect the metric (e.g. excluding certain statuses, deduplicating records)
5. **Check semantic layer (if applicable).** If the metric is defined in the semantic layer, use `get_semantic_model_details` to verify the metric definition, dimensions, and entities match the claim

### Common dbt issues to look for

- **Definition mismatch** — the metric name suggests one thing but the SQL calculates another (e.g. "conversion rate" that's actually a count, or "users" that includes inactive accounts)
- **Stale data** — model hasn't run recently or source freshness is failing
- **Hidden filters** — the model excludes records (test accounts, certain statuses, date ranges) that the claim doesn't mention
- **Aggregation mismatch** — claiming a "per user" metric from a model that aggregates at a different level

## 2e. Gaps and assumptions

- **What's missing?** What evidence would we need to be fully confident, but don't have?
- **What assumptions are we making?** Are there unstated assumptions bridging the gap between evidence and conclusion?
- **What counter-evidence exists?** Actively search the workspace for data or insights that contradict the findings. Report what you find, even if it's nothing

## Root cause checklist (for Step 4 — pattern check)

When a significant proportion of statements are low-confidence or corrected, diagnose *why* using this checklist:

- **Stale documents** — source files haven't been updated and now misrepresent reality. *Fix: flag specific files that need refreshing, and who should own that*
- **Missing primary sources** — conclusions were drawn from summaries or second-hand references rather than raw data. *Fix: identify which primary data sources should be pulled in or linked*
- **Ambiguous definitions** — metrics or terms were used without clear definitions, leading to misinterpretation. *Fix: note which definitions need clarifying in `data/funnel-context.md` or the relevant strategy doc*
- **Single-source reliance** — too many claims rested on one document, one user, or one dataset. *Fix: identify where triangulation is needed and what additional sources to consult*
- **Over-extrapolation from qual** — small-sample qualitative findings were treated as representative. *Fix: flag where quant validation is needed*
- **No counter-evidence sought at source** — the original analysis didn't look for disconfirming data. *Fix: recommend adding a "what could disprove this?" step to the relevant workflow*
