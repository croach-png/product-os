# Build & Launch

**Objectives:**

- Build and set up experiment alongside tracking and dashboards
- Launch with appropriate monitoring

**Steps**:

1. Scoping and breakdown
2. Build
3. QA
4. Tracking
5. Dashboards
6. Eval setup
7. your experiment platform set up
8. Checks
9. Launch
10. Comms
11. Monitoring

| **Stage** | **Objective** | **Lead & Involved** | **Output(s)** | **Actions** |
| --- | --- | --- | --- | --- |
| **1. Scoping & breakdown** | Work planned, identified risks & estimated | Engineering - Lead, Design / PM support | Jira tickets, Estimate | 1. Use prototype to breakdown work and create tickets 2. Identify risks / spikes required 3. Estimate work 4. Update ROTI (revisit scope if needed) |
| **2. Build** | Experiment build | Engineering and TL Leading, Product Manager | Able to end to end test the full experiment | 1. Build experiment with regular updates on progress vs schedule |
| **3. Tracking** | Tracking firing correctly | PM & BI ID events, Engineering build and test | Tracking firing | 1. [Identify tracking events (using tracking template)](../templates/event-tracking-template.md) 2. Engineering check experiment flow and ensure events are fired and recorded correctly. |
| **4. Dashboards** | Working dashboards | BI leading, PM supporting | Dashboard(s) | 1. Set up the dashboard(s) 2. Align on set up with team |
| **5. Eval setup** | Eval criteria configured and baselined | PM & Engineering | Evals running in Logfire (or equivalent) | 1. Configure eval criteria in Logfire based on evaluation plan. 2. Run evals against staging to verify they work correctly. 3. Capture baseline scores before launch. |
| **6. your experiment platform set up** | your experiment platform set up | Engineering & analytics | Ready experiment tooling | 1. Set up the experiment in your experiment platform. |
| **7. Checks** | Confident experiment will launch successfully | TL leading, PM and rest of team involved | Completed launch checklist | 1. [Complete experiment launch checklist](../templates/launch-checklist.md) 2. Team to write a list of use cases to test for. |
| **8. Launch** | Experiment live | Engineering | Live experiment | 1. Experiment is launched to prod and tested by the team using the use case sheet. 2. Experiment is tested in prod that it's working as expected 3. Experiment is rolled out according to launch plan |
| **9. Comms** | Relevant teams aware of experiment | Product Manager | Experiment comms | 1. Inform relevant parties that the experiment has been launched. |
| **10. Monitoring** | Experiment running successfully | Team lead | N/A | 1. Monitor for 1-3 days (minimum) 2. Take corrective action if any issues. |

**Templates:**
- [Launch checklist](../templates/launch-checklist.md)
- [Event tracking template](../templates/event-tracking-template.md)
