---
name: Memory curator rules
description: Pruning, promotion, and audit rules for /memory-curator
type: reference
---

# Memory curator rules

These rules govern the `/memory-curator` skill. Adjust to your context.

## Stale-entry rules

Mark a memory file as stale if:
- **type=feedback** and no reference in 90+ days → flag for review (not auto-prune)
- **type=project** and the project shipped 30+ days ago → suggest archive to `memory/_archive/`
- **type=reference** and source URL is dead → flag for re-source
- **type=user** — never marked stale (these are foundational)

## Duplicate detection

Two files are candidates for merge if:
- Names are within 2 edit-distance OR
- Frontmatter `description` overlaps >70% OR
- File contents share >50% identical lines

When merging:
- Keep the longer name as the canonical
- Concatenate body content (don't lose information)
- Flag for human review before final merge

## Promotion rules (chat → memory)

Promote a chat moment to a memory file when:
- The user explicitly says "remember this", "save this", "for the record"
- The user gives a correction in feedback form ("don't do X", "always do Y")
- A factual answer is referenced in 3+ subsequent conversations
- A decision is made that has long-term implications (>30 days impact)

When promoting:
- Write to existing memory file if scope matches
- Create new file `memory/<type>_<topic>.md` if new scope
- Always update `MEMORY.md` index pointer

## Index integrity

`MEMORY.md` must always reflect the current state of `memory/`:
- One-line pointer per file: `- [Title](filename.md) — one-line hook`
- Pruned files are removed from index immediately
- Archived files are removed from index, kept on disk in `_archive/`

## Audit cadence

- **Sunday 14:00 cron** — full audit, dry-run, report to Telegram
- **First-of-month cron** — deep audit including stale-entry promotion to `_archive/`
- **On-demand** — `/memory-curator` invoked manually when something feels off

## Never

- **Never** hard-delete memory files. Always move to `_archive/`.
- **Never** auto-resolve a contradiction between two files. Always surface for human decision.
- **Never** auto-merge files without human approval (default behavior).
- **Never** re-flag an item that was previously dismissed (track dismissals in `_meta/dismissed.md`).

## Auto-mode (advanced, opt-in)

If you trust the curator, run with `--auto`. In auto-mode the skill will:
- Apply index updates without asking
- Prune truly empty files (<50 chars body)
- Archive files older than 1 year with no references

It will still NOT:
- Merge files
- Resolve contradictions
- Promote chat → memory without confirmation
