<!-- owner: shared | audience: all-pms | last-updated: 2026-05 -->
<!-- purpose: Quarterly audit of AI adoption goals — combines a deterministic baseline script with Claude classification for the qualitative bits -->

# AI adoption audit

Produce a consolidated scorecard for the AI adoption goals defined in your team's strategy (e.g. `strategy/pe-ai-adoption.md`). Combines an automated baseline (deterministic) with Claude classification for metrics that need judgment (customer evidence, confidence quality).

**Important: Do NOT ask any clarifying questions. Run the entire audit in one pass.**

## Step 1: Run the baseline script

```bash
python3 scripts/ai-adoption-baseline.py
```

This writes `data/ai-adoption-scorecard-{today}.md` with deterministic metrics:

- Canonical doc coverage (every active project has a canonical.md)
- Experiment docs per PM
- Cycle time per project (canonical → first experiment doc)
- PM repo commit activity per PM
- Confidence flag coverage (pattern-matched)

Read the file back. If the script fails, run the audit manually using the same metric definitions.

> If your workspace doesn't have `scripts/ai-adoption-baseline.py` yet, define the metrics you want to track in your team's AI adoption strategy doc first, then write the baseline script to compute them. The script should read from `projects/`, `insights/`, and git history.

## Step 2: Customer evidence classification

For each experiment doc found in `projects/`, read the doc and classify:

- **Has primary customer evidence?** True if the doc references a specific customer interview, observation, or direct quant on the target behaviour (e.g. "10 customer interviews showed X", "watched 5 users complete the flow"). False if only secondary evidence (third-party reports, internal hunches, unsourced claims).
- **Which customer segment?** Tag each experiment with the audience the evidence relates to (relevant if your product has multiple sides — e.g. buyers vs sellers in a marketplace).

Output a table:

| Experiment doc | PM | Has primary customer evidence? | Segment | Notes |
|---|---|---|---|---|

Calculate:
- `% of experiments with primary customer evidence` (overall, target ≥80%)
- `% per segment` (track separately; flag gaps)

## Step 3: Validated impact roll-up

For each experiment writeup that includes a stated *actual* uplift (separate from prediction), capture:

- Metric moved
- Direction and magnitude
- Statistical significance flag (if reported)

Sum the validated incremental uplift per PM per quarter:

| PM | Experiments with validated positive impact | Cumulative uplift | Notes |
|---|---|---|---|

If most writeups lack a structured uplift number, flag this and recommend adding it to the experiment template.

## Step 4: Confidence quality (sample audit)

The baseline script counts pattern-matched confidence flags. Read 5 randomly selected artefacts from `insights/` and `projects/` and judge:

- Is the confidence flag present?
- Is it *meaningful* (i.e. tied to specific evidence) or boilerplate?

Output a short qualitative read on whether confidence flagging is being done well, not just done.

## Step 5: Compose the audit summary

Append to the scorecard file from Step 1:

```markdown
## Customer evidence on experiments (Claude classification)

[Table from Step 2]

**Overall:** X% of experiments have primary customer evidence (target ≥80%)
**By segment:** [breakdown]

## Validated impact delivered

[Table from Step 3]

## Confidence quality (sample read)

[Qualitative read from Step 4]
```

## Step 6: Post a one-paragraph summary

If a Slack webhook is configured (or via the Slack MCP), post a one-paragraph summary to your team channel:

> AI adoption audit — {date}: Canonical X% (target 100%), experiment docs Y per PM YTD (target ≥6/qtr), confidence Z%, primary customer evidence W%. Biggest gap: {largest delta from target}. Full scorecard: data/ai-adoption-scorecard-{date}.md

## Principles

- **Deterministic where possible.** The baseline script handles the auditable proxies; Claude only does what needs judgment.
- **No hallucinated numbers.** Every figure must come from the script or from a read of a specific file.
- **Flag missing data explicitly.** "We don't have a stated actual uplift in 4 of 5 writeups" is more useful than a fabricated number.
