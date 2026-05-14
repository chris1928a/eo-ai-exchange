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

Without this skill, the rest of the brain degrades silently. This is the most important *invisible* skill — it doesn't save time directly, it prevents future lost time.

---

## Inputs

1. **Memory directory** — `~/.claude/projects/<project>/memory/` (recursive)
2. **MEMORY.md index** — the top-level index file
3. **Recent chat sessions** (last 7 days) — for "what should have been a memory but wasn't"
4. **Last audit log** — `memory/_meta/last_audit.md` so we know what changed since
5. **Pruning rules** — `memory/_meta/curator_rules.md` (e.g. "feedback memories with no use in 90 days = stale", "project memories whose project shipped 30 days ago = archive")
6. **Skill invocation log** — `memory/_meta/skill_log.md` (which memory files actually got loaded recently)

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

## Worked example — Sunday audit, 4-week-old brain

**Context:** Sun 14:00 cron. Brain has been in use for 4 weeks. Memory has accumulated 87 files.

**Output:**

```markdown
# Memory Audit · 2026-05-17

## Health
- Total files: 87 (+12 since last audit 2026-05-10)
- Stale (no reference in 90+ days): 0 (brain too young)
- Contradictions detected: 1
- Duplicates suggested for merge: 2
- Empty files auto-pruned: 1
- Promotions from chat → memory: 3 candidates

## Contradictions found
1. feedback_voice.md says "always Du form for founders"
   feedback_voice.md ALSO says "Sie form for first contact via LinkedIn"
   → These can both be true. Suggest scoping: "Du after the first reply, Sie on first cold contact"

## Duplicates suggested for merge
1. feedback_email_tone.md + feedback_email_style.md
   → 70% overlap on email-specific rules
   → Suggest: merge into feedback_email.md, keep both for 1 audit cycle
2. people/anna_beispiel.md + people/anna_b.md
   → Same person, different slugs
   → Suggest: merge to people/anna_beispiel.md, redirect anna_b.md

## Stale entries
None yet (brain only 4 weeks old). First stale candidates expected ~week 12.

## Promotions from chat → memory (3 candidates)
1. Conversation 2026-05-15 09:14: you flagged "never CC {colleague} on financial docs"
   → Suggest: create feedback_{colleague}.md OR add to people/{colleague}.md
2. Conversation 2026-05-16 16:42: you said "for any pricing decision, ALWAYS check competitor floor first"
   → Suggest: add to memory/hats/real-estate.md as a non-negotiable rule
3. Conversation 2026-05-17 11:08: you said "Q3 plan top priority for next 4 weeks"
   → Suggest: create memory/projects/q3-plan.md OR add to top of memory/user_about.md

## What I changed automatically (--auto mode)
- Removed 1 empty file (feedback_temp.md, 0 bytes)
- Updated MEMORY.md index: added 12 new entries, sorted by category
- Created memory/_archive/2026-05-17/ folder for future archival use

## Recommendations for human review
- Review the 1 contradiction (5 min)
- Approve / reject the 2 merge suggestions (5 min)
- Decide on the 3 chat-promotion candidates (5 min)
- Total review time: ~15 min, run weekly
```

That's the real output. 5 sections, ~15 min review time, prevents weeks of brain drift.

---

## Non-negotiable rules

- **Never delete without archiving.** Pruned files go to `_archive/`, never get hard-deleted.
- **Contradictions are flagged, not auto-resolved.** Skill suggests, you decide.
- **Promotions need your sign-off** unless you explicitly opted into `--auto` mode.
- **Index integrity.** `MEMORY.md` always reflects the current state of `memory/` after a run.
- **No lossy summaries.** When merging two memory files, the merged version contains *everything* from both — pruning happens at the next audit, not during merge.
- **Audit log is append-only.** `memory/_meta/last_audit.md` keeps the history of every audit. You can always see what was changed when.

---

## The actual prompt under the hood

```
SYSTEM: Audit and curate {user_name}'s memory directory.

CONTEXT:
- Memory directory contents (file paths + sizes + last-modified dates): {memory_tree}
- MEMORY.md index: {memory_index_md_contents}
- Curator rules: {curator_rules_md_contents}
- Last audit log (what was changed last time): {last_audit_md_contents}
- Skill invocation log last 7 days (which memory files were actually loaded): {skill_log_recent}
- Recent chat sessions (last 7 days, for promotion candidates): {chat_sessions_summary}

AUDIT TASKS (do all of these):

1. Health snapshot:
   - Total file count, change since last audit
   - Stale files (no recent invocation, last-modified > 90 days OR per curator_rules.md threshold)
   - Empty files (< 50 chars body, after stripping frontmatter)

2. Contradiction detection:
   - Cross-reference all feedback_*.md files for contradictory statements
   - Cross-reference user_*.md vs people/*.md for tone-rule conflicts
   - Flag any internal inconsistencies in single files

3. Duplicate detection:
   - File names within edit-distance 2
   - Frontmatter description >70% overlap
   - File contents >50% identical lines

4. Promotion candidates (from chat → memory):
   - Direct promotion triggers ("remember this", "save this", "for the record")
   - Behavioral corrections ("don't do X", "always Y") — promote to feedback_*.md
   - Factual answers referenced in 3+ subsequent conversations — promote to reference_*.md

5. Auto-actions (per curator_rules.md):
   - Remove truly empty files (< 50 chars), move to _archive/
   - Update MEMORY.md index to reflect current state
   - Log everything to memory/_meta/last_audit.md

OUTPUT STRUCTURE:
# Memory Audit · {YYYY-MM-DD}
## Health (counts + deltas)
## Contradictions found (with suggested resolution)
## Duplicates suggested for merge (with reasoning)
## Stale entries (with archive recommendation)
## Promotions from chat → memory (with target file suggestion)
## What I changed automatically (in --auto mode)
## Recommendations for human review (with time estimate)

RULES:
1. Surface ALL contradictions, never auto-resolve.
2. Suggest merges, never auto-merge.
3. Suggest promotions, never auto-promote (unless --auto flag).
4. Empty file pruning is the ONLY auto-action by default.
5. Archive, never hard-delete.
6. End with a "time to review" estimate so the human knows what they're committing to.

SIDE EFFECT: write the audit verbatim to memory/_meta/last_audit.md (append, not overwrite).
```

Full template at [`prompts/curator-prompt.md`](prompts/curator-prompt.md).

---

## Setup (10 minutes)

1. Drop SKILL.md + prompt template at `~/.claude/skills/memory-curator/`
2. Create `~/.claude/projects/<project>/memory/_meta/` directory
3. Create `_meta/curator_rules.md` from the template at [`templates/memory-templates/curator_rules.md`](../../templates/memory-templates/curator_rules.md)
4. Create empty `_meta/last_audit.md` (skill will populate)
5. Create empty `_meta/skill_log.md` (other skills will append to this)
6. Test: `/memory-curator --dry-run` (will run a dry-run audit on first invocation)
7. Verify: audit report makes sense, no false-positive contradictions
8. After 4 audits, switch to `--auto` mode if you trust the suggestions

---

## Make it Sunday cron

```cron
0 14 * * SUN cd /path/to/project && claude --skill memory-curator --report telegram
```

Fires Sun 14:00. Outputs audit to Telegram. Auto-applies safe changes (index updates, empty-file pruning). Flags promotions and contradictions for your review Monday morning. Full setup in [`scripts/cron-sunday.sh`](scripts/cron-sunday.sh).

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~10.000-25.000 (reads ALL memory files for cross-reference) |
| Model | Claude Opus 4.7 (the contradiction + duplicate detection benefits from Opus reasoning) |
| Cost per invocation | **~$0.50-1.20** |
| Latency | 30-60 seconds (large reading workload) |
| Monthly cost (4-5 audits/mo) | **~$2-6** |

The most expensive of the 8 skills per-run, but lowest frequency (weekly). Net monthly cost is reasonable. Skip Sonnet — it misses subtle contradictions across files.

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/memory-curator --aggressive` | Lower threshold for stale (60 days vs 90), more aggressive auto-pruning | Mature brain (>6 months) with bloat |
| `/memory-curator --conservative` | Higher threshold, never auto-anything, more flags | Sensitive contexts (legal, medical) |
| `/memory-curator --hat {name}` | Audit just one hat's memory files | After a project shipped, archive that hat's memory |
| `/memory-deep-curator` | Quarterly full reorg — re-categorize, restructure folders | First Sunday of each quarter |
| `/memory-curator --diff-only` | Show only what's changed since last audit | Daily snapshot if paranoid |

---

## Common modifications

**1. Add custom contradiction rules.** In `curator_rules.md`, add domain-specific contradictions (e.g. "if any file says 'send via email' AND another says 'avoid email', flag").

**2. Per-type pruning rules.** Default is "feedback stale at 90 days". You may want "project stale at 30 days after ship" or "reference never stale". Edit curator_rules.md.

**3. Whitelist files from auto-actions.** Add a `protected:` list in curator_rules.md. The skill never touches those files even in --auto mode.

**4. Notification on critical findings.** Add to the prompt: "If contradictions exceed 5 OR stale files exceed 20% of total, send a Telegram alert immediately, do not wait for the weekly audit."

**5. Multi-project support.** If you run multiple Claude projects, run the curator per-project on different days (Sun for project A, Wed for project B).

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1 | Run `/memory-curator --dry-run` for the first time. Will produce 30+ suggestions if you have any history. |
| 2-7 | Triage the 30+ suggestions over a week. Approve / reject each one. This is real work but only happens once. |
| 8 | Run again after triage. Should produce <10 suggestions now. |
| 9-14 | Add the Sunday cron. Keep reviewing the audit each Mon morning. |
| 15-30 | After 4 audits, the steady-state should be ~5-10 review items per audit, ~15 min total review time. |
| 30+ | Switch to `--auto` mode if confident. Continue reviewing the report weekly. |

---

## What this won't do (failure modes)

- **Will not detect "subtly wrong" facts.** It detects contradictions BETWEEN memory files but cannot verify against ground truth. For factual accuracy, spot-check key files.
- **Cannot promote what was never logged.** If a critical decision was made in your head and never written, the curator can't surface it. The morning-brief and weekly-review skills feed it raw material.
- **Promotions from chat depend on chat history retention.** If Claude Code's session retention is 7 days, the curator only sees that window. Configure session retention longer if needed.
- **Auto mode is dangerous early.** Run dry-run for the first 4-6 audits before turning on `--auto`.
- **Will silently miss memory files outside the configured directory.** If you have memory in 2 different folders, point the curator at both or expect drift.

---

## When to delete this skill

You almost never should. This skill is the maintenance backbone for everything else. Reasons it might not work:
- Your brain is too small (<20 files) — manual review is faster
- You don't actually use the rest of the skill set, so memory doesn't accumulate
- You're using a different curation system (PAI's Telos primitive, etc.)

If you delete this, plan to do manual memory audits monthly OR your other skills degrade in 2-3 months silently.

---

## Why this is universal

Memory is the single highest-leverage thing in any AI brain (see [`setups/chris-claude-code.md`](../../setups/chris-claude-code.md)). Memory without curation degrades faster than tools without maintenance. Every operator who runs a memory-driven AI brain needs this skill running on a cron, or the brain runs on lies.

This is the skill that keeps the rest working. Hidden value, but the only way to make a memory-driven setup last beyond 6 months without rotting.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Maintenance skill — saves time by preventing future losses (silent failures, stale brain), not by replacing a current task.*
