<!-- owner: shared | audience: all-pms | last-updated: 2026-05 -->
<!-- purpose: Generate a complete Optimizely Web Experimentation setup from an experiment doc or /experiment-setup output, ready to POST to the API -->

# Create Optimizely Experiment

Takes an experiment doc (`experiment.md`) or the output of `/experiment-setup` and produces a complete Optimizely Web Experimentation payload — variation JS, activation code, and API-ready JSON — then optionally creates the experiment directly.

> **Prerequisites.** This command assumes you use Optimizely Web Experimentation as your A/B testing platform, and that you have a helper script at `scripts/optimizely.py` (or the Optimizely MCP connector) that wraps the Optimizely REST API. You'll also need `OPTIMIZELY_API_TOKEN` set in your environment. If you use a different platform (LaunchDarkly, Statsig, VWO), adapt the payload structure but keep the phase-by-phase flow.

## Arguments

One of:
- A file path to an `experiment.md` doc (e.g. `projects/{squad}/{project}/experiment.md`)
- Pasted output from `/experiment-setup`
- A plain-English description of the experiment if no doc exists yet

## Instructions

### Phase 1: Read the input

If the user provided a file path, read the file. If they pasted content, use it directly.

Extract:
- **Hypothesis** — the "if X then Y because Z" statement
- **Primary metric** — including any Optimizely event ID already annotated in the doc
- **Secondary metrics** — including event IDs
- **Guardrail metrics** — including event IDs
- **Audience** — who the experiment targets (e.g. "all users on {page}", "authenticated users only")
- **Traffic split** — default 50/50 unless stated otherwise
- **Confidence level** — default 80% unless stated otherwise
- **URL/page** — e.g. "checkout page", "/signup"
- **What the variation does** — the UI change described in the Solution section
- **Status of design** — is the variation design confirmed or TBC?

### Phase 2: Fetch Optimizely context

Run in parallel:

```bash
# List running and recently concluded experiments (for numbering + calibration)
python3 scripts/optimizely.py list --status running --project web --limit 100 --ab-only
python3 scripts/optimizely.py list --status concluded --project web --limit 20 --ab-only
```

From these results, find the highest experiment number and suggest the next one (e.g. if `{PREFIX} 30.0` is highest, suggest `{PREFIX} 31.0`). Replace `{PREFIX}` with your team's naming prefix (e.g. `MW`, `ACME`).

Then fetch known events and audiences:

```bash
python3 scripts/optimizely.py events
python3 scripts/optimizely.py audiences
```

### Phase 3: Map fields to Optimizely API

Build a mapping table of what you know vs what's missing. Every field must either be resolved or flagged:

| Optimizely field | Source | Status |
|-----------------|--------|--------|
| `project_id` | From your Optimizely account (store in env or config) | ✅ Auto |
| `name` | `PROD \| {DOMAIN} \| {squad} \| {PREFIX} {number} {short title}` | ✅ Auto (pending number confirmation) |
| `type` | `"a/b"` | ✅ Auto |
| `status` | `"not_started"` | ✅ Auto |
| `traffic_allocation` | 10000 (100%) unless doc specifies otherwise | ✅ Auto |
| `holdback` | 0 | ✅ Auto |
| `audience_conditions` | Map from doc audience description to Optimizely audience ID | ✅/❓ |
| `metrics` | Map from doc metrics to canonical event IDs | ✅/❓ |
| `url_targeting.conditions` | URL path where experiment runs | ❓ Needs input |
| `url_targeting.activation_code` | Generated from URL path + DOM selector | ❓ Needs DOM selector |
| Variation JS (`changes`) | Generated from the UI change description | ✅/❓ (if design TBC) |
| Variation CSS (`changes`) | Generated if styling is needed | ✅/❓ |

**Metric mapping rules.** Maintain a lookup of your canonical funnel event IDs in a config file (e.g. `data/optimizely-events.md` or fetched from `python3 scripts/optimizely.py events`). Use consistent event variants across experiments — do not mix event ID families. If the doc references a metric name that isn't in your lookup, flag it and ask.

**Audience mapping rules.** Maintain a lookup of common audience IDs (all users, authenticated, unauthenticated, mobile-only, desktop-only, key segments). Map plain-English audience descriptions from the doc to those IDs. Anything unfamiliar → flag as needing a custom audience or ask the user.

**Guardrail metric direction.** Use `winning_direction: "decreasing"` for anti-metrics (cancellations, drop-off, error rate); `"increasing"` for all others.

**Metric order matters.** Put the primary metric first in the array — Optimizely treats the first entry as the primary.

### Phase 4: Interactive gap-filling

Present a clear summary of what's resolved and what's missing. Ask the user for each missing input in a **single message** — do not ask one question at a time.

Always ask:
1. **Experiment number** — confirm the suggested next number (e.g. "I'll use `{PREFIX} 31.0` — does that look right, or is there already a number allocated?")
2. **Squad label** — for the experiment name. Check the experiment doc's team folder as a guide.
3. **Target URL path** — the specific URL path where the experiment should activate. Almost never in the doc explicitly — always ask unless unambiguous.
4. **DOM selector** — the CSS selector for the element being modified. If design is TBC, note that a placeholder will be used. Ask: "What's the CSS class or element ID for the thing being changed? If you're not sure, I can use a placeholder."
5. **Variation description** — if the doc says "Design: TBC", ask for a brief description so a placeholder JS can be generated.

If the doc already has Optimizely event IDs annotated (in the format `event_name` (`ID`)), use those directly and do not re-map.

### Phase 5: Generate variation code

Use your team's established Optimizely patterns. If your product is a single-page app (React, Vue, etc.), use a `callbackFn` + `waitUntil` pattern so activation handles SPA navigation.

#### Activation code

The activation code is a `callbackFn` that:
- Waits for the target URL path to be active (handles SPA navigation)
- Waits for the target DOM element to be present
- Then calls `activate()`
- Re-runs on `location:change` events (or your SPA's navigation event)

Template (fill in `EXPERIMENT_ID`, `TARGET_PATH`, `TARGET_SELECTOR`, `CLIENT_ID`):

```javascript
function callbackFn(activate, options) {
  try {
    const CLIENT_ID = '{PREFIX}';
    const EXPERIMENT_ID = '{XX.0}';
    const LOG_PREFIX = `${CLIENT_ID} ${EXPERIMENT_ID} - `;
    const isQA = document.cookie.includes('cfQA=true');

    window.optimizely = window.optimizely || [];

    const utilities = {
      log: (...args) => { if (isQA) console.log(LOG_PREFIX, ...args); },
      waitUntil: (condition, wait = 5000) => new Promise((resolve, reject) => {
        const interval = setInterval(() => {
          try { if (condition()) { clearInterval(interval); resolve(); } }
          catch (e) { utilities.log('waitUntil error:', e); }
        }, 16.667);
        if (wait) setTimeout(() => { clearInterval(interval); reject(new Error('timeout')); }, wait);
      })
    };

    const check = () => {
      utilities.waitUntil(() =>
        location.pathname.includes('{TARGET_PATH}') &&
        !!document.querySelector('{TARGET_SELECTOR}')
      ).then(() => {
        setTimeout(activate, 0);
      }).catch(err => utilities.log('Conditions not met for activation.', err));
    };

    check();
    window.addEventListener('location:change', check);
  } catch (e) {
    console.error('Activation error:', e);
  }
}
```

#### Variation JS

The variation code is an IIFE that:
- Uses `waitUntil` to wait for the target element
- Applies the UI change
- Includes a QA/debugging cookie check
- Re-runs on `location:change`

```javascript
((w) => {
  'use strict';
  const CLIENT_ID = '{PREFIX}';
  const EXPERIMENT_ID = '{XX.0}';
  const VARIANT_ID = '1';
  const window = typeof unsafeWindow !== 'undefined' ? unsafeWindow : w;

  const LOG_PREFIX = `${CLIENT_ID} ${EXPERIMENT_ID}.${VARIANT_ID} - `;
  const SELECTOR_PREFIX = `${CLIENT_ID.toLowerCase()}-${EXPERIMENT_ID.replace('.', '-')}`;

  const DEBUGGING_ENABLED =
    document.cookie.includes('PREVIEW=ENABLED') ||
    document.cookie.includes('DEBUGGING=ENABLED');

  const utilities = {
    log: (...args) => { if (DEBUGGING_ENABLED) console.log(LOG_PREFIX, ...args); },
    waitUntil: (condition, wait = 10000) => new Promise((resolve, reject) => {
      const interval = setInterval(() => {
        try { if (condition()) { clearInterval(interval); resolve(); } }
        catch (e) { utilities.log('waitUntil error:', e); }
      }, 16.667);
      if (wait) setTimeout(() => { clearInterval(interval); reject(new Error('timeout')); }, wait);
    })
  };

  const run = () => {
    utilities.waitUntil(() => !!document.querySelector('{TARGET_SELECTOR}'))
      .then(() => {
        utilities.log('Running variation');
        // --- VARIATION CODE ---
        // {DESCRIPTION OF CHANGE}
        // ---------------------
      })
      .catch(err => utilities.log('Failed to apply variation:', err));
  };

  run();
  window.addEventListener('location:change', run);
})(window);
```

If the design is confirmed, generate the actual DOM manipulation code. If TBC, keep the placeholder with a clear `{DESCRIPTION OF CHANGE}` comment.

### Phase 6: Assemble the full payload

```json
{
  "project_id": {your_project_id},
  "name": "PROD | {DOMAIN} | {squad} | {PREFIX} {XX.0} {title}",
  "description": "{hypothesis from doc}",
  "type": "a/b",
  "status": "not_started",
  "traffic_allocation": 10000,
  "holdback": 0,
  "audience_conditions": "{everyone or audience ID}",
  "metrics": [
    { "event_id": {primary_id}, "aggregator": "unique", "scope": "visitor", "winning_direction": "increasing" },
    { "event_id": {secondary_id}, "aggregator": "unique", "scope": "visitor", "winning_direction": "increasing" },
    { "event_id": {guardrail_id}, "aggregator": "unique", "scope": "visitor", "winning_direction": "decreasing" }
  ],
  "url_targeting": {
    "activation_type": "callback",
    "conditions": "[\"and\", [\"or\", {\"match_type\": \"substring\", \"type\": \"url\", \"value\": \"{target_url_path}\"}]]",
    "activation_code": "{activation_code_as_string}"
  },
  "variations": [
    { "name": "{XX.0}.0", "status": "active", "weight": 5000, "actions": [] },
    {
      "name": "{XX.0}.1",
      "status": "active",
      "weight": 5000,
      "actions": [
        {
          "changes": [
            { "type": "custom_code", "value": "{variation_js_as_string}", "async": false, "dependencies": [] }
          ]
        }
      ]
    }
  ]
}
```

Add a `custom_css` change entry if CSS is needed alongside the JS.

Present the payload in a clearly formatted code block. Also show the variation JS and activation code separately so they can be pasted into the Optimizely UI manually if preferred.

### Phase 7: Confirm and create

Ask: "Do you want me to create this experiment in Optimizely now? It will be created in `not_started` state — nothing goes live until you start it in the Optimizely UI."

If yes:

```bash
python3 scripts/optimizely.py create --payload '{json_payload}'
```

This POSTs the experiment to Optimizely, returns the experiment ID and a direct link, and prints the share/preview link for QA.

If no, output the payload as a markdown code block so it can be saved or used elsewhere.

### Phase 8: QA checklist

```
Before starting the experiment:
☐ Open the preview link in the Optimizely UI and verify the variation renders correctly
☐ Check the activation fires on the correct page (use cfQA=true cookie to enable logging)
☐ Confirm the primary metric event fires on test conversions (check Optimizely debugger)
☐ Verify control shows the original experience
☐ Confirm no console errors in either variant
☐ Get EM sign-off on the variation code if design was TBC
```

## Important rules

- Use one canonical event ID family across all experiments — mixing families breaks cross-experiment comparability. Pick a convention and stick to it.
- Always create experiments in `not_started` state — never `running`.
- Always follow the naming convention: `PROD | {DOMAIN} | {squad} | {PREFIX} {XX.0} {title}`.
- For SPAs (React/Vue/etc.), the activation code must use the `callbackFn` + `waitUntil` pattern — simple URL matching without a callback causes timing issues.
- If design is TBC, generate placeholder code with clear comments — do not block on design; the engineer can fill in the actual manipulation before launch.
- The `url_targeting.conditions` value must be a JSON string (escaped), not a raw object.
- Use `url_targeting` (not `page_ids`) — it's the more portable approach.
