---
name: memory-curator
type: universal
load_when: audit memory, curate memory, memory hygiene, prune memory, what's in my memory
---

# /memory-curator

> **Universal skill from Event #1, Demo 1 (Chris).**
> Weekly memory hygiene cron. Decides what stays in chat vs becomes durable memory, prunes drift, flags stale entries. The skill that keeps the brain from running on lies.

---

## Purpose

Memory files go stale within weeks if no one audits them. This skill runs once a week (or on demand) and:
1. **Audits** — checks every memory file for staleness, contradictions, drift
2. **Curates** — promotes valuable chat moments to durable memory
3. **Prunes** — removes / merges duplicates and obsolete entries
4. **Reports** — outputs a 1-page audit so you stay aware

Without this skill, the rest of the brain degrades silently.

---

## Inputs

1. **Memory directory** — `~/.claude/projects/<project>/memory/` (recursive)
2. **MEMORY.md index** — the top-level index file
3. **Recent chat sessions** (last 7 days) — for "what should have been a memory but wasn't"
4. **Last audit log** — `memory/_meta/last_audit.md` so we know what changed since
5. **Pruning rules** — `memory/_meta/curator_rules.md` (e.g. "feedback memories with no use in 90 days = stale", "project memories whose project shipped 30 days ago = archive")

---

## Outputs

### A. Audit report (each run)

```markdown
# Memory Audit · {YYYY-MM-DD}

## Health
- Total files: 125 (+3 since last audit)
- Stale (no reference in 90+ days): 8
- Contradictions detected: 2 (see below)
- Duplicates suggested for merge: 4

## Contradictions
1. user_voice.md says "always Du form" / people/{stakeholder}.md says "Sie with this person"
   → Suggest: scope user_voice rule with "default Du, see person-specific overrides"

## Stale entries (90+ days untouched, no recent invocation)
- project_q1_launch.md — project shipped 2026-02-01, archive?
- ...

## Promotions from chat → memory (5 candidates)
1. Conversation 2026-05-12 14:33: you flagged "never CC {colleague} on financial docs"
   → Suggest: add to feedback_{colleague}.md
- ...

## What I changed automatically
- Removed 3 truly-empty files
- Updated MEMORY.md index with 3 new entries
```

### B. Side-effect file changes

- New entries appended to existing memory files (after your approval, unless you ran with `--auto`)
- Pruned files moved to `memory/_archive/{YYYY-MM-DD}/`
- MEMORY.md index updated

---

## Non-negotiable rules

- **Never delete without archiving.** Pruned files go to `_archive/`, never get hard-deleted.
- **Contradictions are flagged, not auto-resolved.** Skill suggests, you decide.
- **Promotions need your sign-off** unless you explicitly opted into `--auto` mode.
- **Index integrity.** `MEMORY.md` always reflects the current state of `memory/` after a run.
- **No lossy summaries.** When merging two memory files, the merged version contains *everything* from both — pruning happens at the next audit, not during merge.

---

## Setup (10 minutes)

1. Drop this file at `~/.claude/skills/memory-curator/SKILL.md`
2. Create `~/.claude/projects/<project>/memory/_meta/` directory
3. Create `_meta/curator_rules.md` from the template at [`templates/memory-templates/curator_rules.md`](../../templates/memory-templates/curator_rules.md)
4. Create `_meta/last_audit.md` (skill will populate)
5. Test: `/memory-curator` (will run a dry-run audit on first invocation)

---

## Make it Sunday cron

```cron
0 14 * * SUN cd /path/to/project && claude --skill memory-curator --report telegram
```

Fires Sun 14:00. Outputs audit to Telegram. Auto-applies safe changes (index updates, empty-file pruning). Flags promotions and contradictions for your review Monday morning.

---

## Honest caveats

- **First audit will be noisy.** If you have months of memory files with no curation, the first audit produces dozens of suggestions. Plan 30 min to triage. After that, weekly audits are <5 min.
- **The skill cannot detect "wrong but plausible" facts.** It detects contradictions between memory files but cannot verify against ground truth (the world). For factual accuracy, you still need to spot-check.
- **Promotions from chat depend on chat history retention.** If Claude Code does not retain your last N sessions, this input is empty. Configure session retention.
- **Auto mode is dangerous early.** Run dry-run for the first 4-6 audits before turning on `--auto`.

---

## Why this is universal

Memory is the single highest-leverage thing in any AI brain (see [`setups/chris-claude-code.md`](../../setups/chris-claude-code.md)). Memory without curation degrades faster than tools without maintenance. Every operator who runs a memory-driven AI brain needs this skill running on a cron, or the brain runs on lies.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Maintenance skill — saves time by preventing future losses (silent failures, stale brain), not by replacing a current task.*
