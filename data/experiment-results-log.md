# Experiment Results Log

Running log of experiment results. Updated weekly by the analyst agent or manually after experiment conclusions.

## How to read this log

- **Status**: running, concluded, rolled out, rolled back
- **Source**: Where the authoritative result lives (experiment platform, analytics, local doc)
- **Primary metric**: The metric that determines the experiment decision
- **Result**: Uplift %, statistical significance status, and sample size
- **Notes**: Caveats, discrepancies between sources, decision taken

## Format

Each entry follows this structure:
```
### {Experiment name}
- **ID:** {experiment platform ID} | **Platform:** {web/mobile/api}
- **Status:** {status} | **Last checked:** {date}
- **Authoritative source:** {platform name}
- **Primary metric:** {metric name}
- **Result:** Control {x}% → Test {y}% | {uplift} | {stat sig} (n={samples})
- **Decision:** {ship / kill / extend / pending}
- **Notes:** {any caveats, source discrepancies, or context}
```

---

## Running experiments

<!-- Add your running experiments here -->

---

## Concluded experiments

<!-- Add your concluded experiments here. Keep the most recent 10-15;
archive older entries to a quarterly file. -->
