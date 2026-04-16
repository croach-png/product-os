# Design

**Objective:**

Design an experience — not just a screen — that directly tests the hypothesis and is ready for engineering.

**Stages:**

1. Creative exploration
2. Design review & user testing
3. Solution design

---

## Principles

Before getting into the stages, these principles should guide how we approach design at {Your Company}. They apply to PMs reviewing designs as much as designers creating them.

### Design experiences, not screens

The most common trap in product design is optimising a screen rather than designing an experience. Adding a card with copy and a CTA to an existing page is screen optimisation. Thinking about what psych levers could drive the behaviour, how the experience (not just the text) lands the message, and how it ties to what the user really cares about — that's experience design.

**The test:** If a user never reads a single line of body copy, would they still understand what this feature does and why it matters from the design alone? If the answer is no, the design is relying on words to do what the experience should do.

### Match the change to the expected uplift

Small design changes produce small results. If the hypothesis is ambitious (e.g. "this will increase conversion by 20%" or "this will change user behaviour"), the design change needs to be proportionate. A text prompt added to a waiting screen is unlikely to produce a meaningful shift in downstream sale outcomes. A structural change to the journey — embedding a new step, changing what the user sees and feels — might.

Before committing to a direction, ask: **is the size of this change proportionate to the size of the expected uplift?**

### Show, don't tell

Telling users about a benefit through body copy is the weakest form of communication. Showing them — through visual comparison, progress indicators, before/after states, or unlocking visible rewards — is far more effective. The Reforge psych framework is clear: positive psych comes from the user seeing and feeling value, not being told about it.

### Check hypothesis-design alignment

Every design should be evaluated against the hypothesis it's testing. For each screen or state, ask:
- Does this directly serve the stated hypothesis?
- Would a user experiencing this design understand the value proposition without needing it explained?
- Are there elements that are unrelated to or contradicting the hypothesis?
- Is the hypothesis actually testable from what's been designed?

If there's a gap between what the hypothesis claims and what the design communicates, the design needs to go further — not the hypothesis needs to be softened.

---

## Stages

| **Stage** | **Objective(s)** | **Lead & Involved** | **Output(s)** | **Actions** |
| --- | --- | --- | --- | --- |
| **1. Creative exploration** | Explore multiple structurally different approaches to solving the problem | Design - Lead, PM - Involved | 2-3 distinct design directions (not just copy variants of the same layout) | 1. Review the hypothesis and success metrics together — what behaviour are we trying to drive? 2. Explore at least 2-3 fundamentally different design approaches — different structures, different psych levers, not just different words on the same card. 3. For each direction, articulate: what psych lever does this use? How does the experience (not just the text) communicate the value? 4. Include the current control experience alongside new directions so the team can assess the magnitude of change. |
| **2. Design review & user testing** | Validate that the design serves the hypothesis, the right personas, and is proportionate to the expected outcome | PM - Lead, Design - Involved, TL - Involved | Psych audit, persona evaluation, assumption map, and structured feedback | 1. Run a design review using the `/review-design` command or the structured framework: hypothesis alignment, psych audit, persona check, activation fit, design best practice, assumption mapping. 2. Check the design against priority personas (your priority personas from context/personas/). 3. Assess: is the change big enough for the expected uplift? 4. User test with 3-5 real users before committing to engineering — even lightweight unmoderated testing surfaces whether the message lands. 5. Iterate based on feedback and testing results. |
| **3. Solution design** | Completed design for the experiment, ready for engineering | Design - Lead, TL / PM - Involved | Completed design — eng ready, including edge states | 1. Design the full solution including error states, empty states, edge cases, and the post-action reward state (what does the user see after they take the desired action?). 2. Update with PM and TL weekly to stay aligned on progress and assumptions (viability / feasibility). 3. Ensure the design covers both desktop and mobile (most users are on mobile). |

---

## PM's Role in Design

The PM's job in design is not to critique aesthetics or dictate solutions. It's to:

1. **Check hypothesis-design alignment** — does this design actually test what we think it tests?
2. **Advocate for the user** — evaluate from the persona's perspective, not your own
3. **Challenge the approach** — are we designing an experience or optimising a screen? Is there a more creative way to achieve this outcome?
4. **Ground feedback in evidence** — reference frameworks, personas, data, or research. Not "I think it would look better if..."
5. **Push for creative exploration** — if only one direction is presented, ask for alternatives. Different structural approaches, not just different copy on the same layout.
6. **Insist on user testing** — even lightweight testing before engineering saves significant rework

### Questions to ask in every design review

- What is the hypothesis and does this design directly test it?
- If the user never reads the body copy, would they still understand the value from the design alone?
- Is the size of this change proportionate to the expected uplift?
- What does the control look like? How different is this?
- How would your priority personas experience this?
- What psych levers is this design using? Are there stronger ones we haven't explored?
- What happens after the user takes the desired action? Is there a visible reward?
- Have we explored fundamentally different approaches, or just different treatments of the same idea?
- Has this been tested with real users?
