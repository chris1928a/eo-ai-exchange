---
name: weekly-review
type: universal
load_when: weekly review, friday review, week recap, what happened this week, weekly summary
---

# /weekly-review

> **Universal skill from Event #1, Demo 1 (Chris).**
> Friday 17:00 cron across all your "hats" / domains. **90 min → 10 min** in Chris's setup. Tracked saved time: ~1.3h/week.

---

## Purpose

The Friday weekly review compressed from a 90-minute manual exercise to a 10-minute automated pass. Outputs a 7-day summary across every domain you operate in (advisory, ventures, content, ops, personal), flags decay (things you said you'd do but didn't), surfaces priorities for next week.

---

## Inputs

1. **Calendar last 7 days** — what actually happened (vs what was planned)
2. **Email sent + received** — flagged threads, important responses you owe
3. **Memory file changes** — what you added to memory this week (proxy for "what mattered")
4. **Skills invoked** — which skills you actually used (proxy for which workflows are alive)
5. **Open threads file** — `memory/project_open_threads.md` (decay-flagged items)
6. **Per-domain memory** — your "hat" files (e.g. `memory/hats/advisory.md`, `memory/hats/ventures.md`)
7. **Voice rules** — for the tone of the review itself

---

## Outputs

A Friday note, ~600 words, in this exact shape:

```markdown
# Weekly Review · Week of {YYYY-MM-DD}

## Wins (3 max)
- [Concrete win, with evidence]
- ...

## Decisions made
- [Decision, by you, with date]
- ...

## Decay flags (things you said you'd do, didn't)
- [Item, days late, ownership]
- ...

## Domain pulse (1-2 lines per hat)
- **Advisory:** ...
- **Ventures:** ...
- **Content:** ...
- **Ops:** ...
- **Personal:** ...

## Top 3 for next week
1. ...
2. ...
3. ...

## Single decision to make over the weekend
[One line, the call that sets up Monday]
```

Posted to: Telegram, your weekly-review.md archive, optionally a shared Notion page.

---

## Non-negotiable rules

- **3 wins max.** "5 wins" is just bragging; 3 forces ranking.
- **Decay flags by name, not by category.** "{stakeholder} dossier overdue 4 days" not "stakeholder follow-ups slipping".
- **Top 3 next week, not top 10.** If you have 10 priorities, you have none.
- **Single weekend decision.** Forces Monday clarity. If there is no decision, write "no major call".
- **No AI-fluff.** Banned: delve, leverage, harness, robust, seamless.

---

## Setup (15 minutes)

1. Drop this file at `~/.claude/skills/weekly-review/SKILL.md`
2. Create your "hats" memory files: one per domain you operate in. Template at [`templates/memory-templates/hat_template.md`](../../templates/memory-templates/hat_template.md)
3. Make sure Calendar + Gmail MCPs are connected
4. Create the archive directory: `~/.claude/projects/<project>/weekly-reviews/`
5. Test: `/weekly-review` (will pull last 7 days and generate one)

---

## Make it Friday cron

```cron
0 17 * * FRI cd /path/to/project && claude --skill weekly-review --output telegram --archive
```

Fires Fri 17:00. Posts to Telegram, archives to `weekly-reviews/{YYYY-MM-DD}.md`.

---

## Honest caveats

- **First weekly review is shallow.** Without 4-6 weeks of memory file changes to look back on, the "domain pulse" is thin. Plan to write your first 2-3 reviews semi-manually before automating.
- **Decay flags need ownership.** If everything is "your move", you have a prioritization problem the skill cannot fix.
- **Monthly trends are not weekly.** This skill is intentionally 7-day. For monthly trends, run a separate `/monthly-review` skill on the 1st.
- **The "top 3 for next week" is a commitment**, not a wish list. If you don't deliver them, decay flag them next Friday.

---

## Why this is universal

Every operator has a Friday. Most do an unstructured "what did this week feel like" reflection. This skill replaces unstructured reflection with structured recall + forward planning, in 1/9th the time. The pattern (pull 7 days from N live sources → score → output fixed-shape note) reuses for monthly / quarterly reviews with minor changes.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Compressed 90min → 10min, 1.3h/week saved.*
