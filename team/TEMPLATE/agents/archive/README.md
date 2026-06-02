# Agent state archive

Quarterly archives of agent state files. The Engineer agent runs at the start of each quarter, copies all current state files into a dated subfolder here (e.g. `2026-q2/`), then resets the live state files so agents rebuild fresh on their next run.

This keeps state files focused on what's happening now, while preserving history for trend analysis and audit. Permanent learnings should have been moved to memory before archiving — the archive is a snapshot, not a working file.

## Structure

```
archive/
├── 2026-q1/
│   ├── cos.md
│   ├── analyst.md
│   └── ...
├── 2026-q2/
│   └── ...
```
