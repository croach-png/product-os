# {agent-short-name} — State

<!-- This is the template format for persistent agent state files.
     Copy this structure when creating a new agent's state file.
     
     RULES:
     - 80-line budget (100 for product-manager)
     - Update Last refreshed on every refresh
     - Remove resolved items entirely (don't mark as done)
     - Watch list items older than 4 weeks: promote to Active or remove
     - Patterns older than 1 quarter: archive
     - Quarterly: archive entire state file and rebuild fresh -->

Last refreshed: YYYY-MM-DD HH:MM
Next due: YYYY-MM-DD
Refresh cadence: {daily|weekly (Day)|on-demand}

## Active items
<!-- Max 10. The most important operational items right now. -->
- {item description} — {owner} — {age/due date} — {status: open|chasing|overdue}

## Watch list
<!-- Max 10. Being monitored but not yet actionable. Promote to Active or remove after 4 weeks. -->
- {item} — first seen {date} — {signal or reason for watching}

## Patterns
<!-- Max 10. Recurring themes. Include week count so you know when to archive. -->
- {pattern description} — {week count} weeks — {observation or trend}

## Open requests
<!-- Max 5. Things this agent needs from the user or other agents. -->
- {request} — {context or blocker}
