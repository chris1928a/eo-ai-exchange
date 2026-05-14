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

The pattern is: **pull 7 days from N live sources → score across hats → output a fixed-shape note → archive for trend tracking**. Reusable for monthly / quarterly review with minor changes.

---

## Inputs

1. **Calendar last 7 days**, what actually happened (vs what was planned)
2. **Email sent + received**, flagged threads, important responses you owe
3. **Memory file changes**, what you added to memory this week (proxy for "what mattered")
4. **Skills invoked**, which skills you actually used (proxy for which workflows are alive)
5. **Open threads file**, `memory/project_open_threads.md` (decay-flagged items)
6. **Per-domain memory**, your "hat" files (e.g. `memory/hats/advisory.md`, `memory/hats/ventures.md`)
7. **Last 4 weekly reviews**, `weekly-reviews/` archive for trend detection
8. **Voice rules**, for the tone of the review itself

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

Posted to: Telegram, your `weekly-reviews/{YYYY-MM-DD}.md` archive, optionally a shared Notion page.

---

## Worked example, Friday after a productive week

**Context:** Friday 2026-05-16, 17:00. Chris's brain has been logging to memory all week.

**Output:**

```markdown
# Weekly Review · Week of 2026-05-12

## Wins (3 max)
- Q3 plan signed by Anna Beispiel, partnership locked (was top item Tue)
- 3 forkable skills shipped to public repo (eo-ai-exchange)
- Deffingen revenue +18% week-over-week from new pricing skill

## Decisions made
- Pricing rules: tightened floor +5% across all 6 units (2026-05-13)
- Hiring: paused EA search, doubled-down on AI-as-infrastructure thesis (2026-05-14)
- Q3 partnership: yes, with integration-timing carveout (2026-05-15)

## Decay flags (things you said you'd do, didn't)
- Dentist follow-up: 8 days overdue, your move
- Hölderlin financing: 4 days late, partner waiting on you
- Q2 retro: pushed 2 weeks now, needs deletion or block-time

## Domain pulse
- **Advisory:** strong week, 1 new diagnostic booked
- **Ventures:** flat, no new pipeline movement
- **Content:** weekly post shipped, 3.2k impressions on LinkedIn
- **Real Estate:** Deffingen pricing skill paying back already
- **Personal:** wedding planning behind, family time good

## Top 3 for next week
1. Q3 partnership integration kickoff (Tue 14:00 with Anna)
2. Q2 retro: do it Mon morning or kill it
3. Dentist follow-up by EOD Mon (no excuses, 30 sec text)

## Single decision to make over the weekend
Whether to attend the Berlin operator event Sat OR finish the founders deck, pick one.
```

That shape compresses 90 minutes of "what happened this week" reflection into 10 minutes of focused planning.

---

## Non-negotiable rules

- **3 wins max.** "5 wins" is just bragging; 3 forces ranking.
- **Decay flags by name, not by category.** "{stakeholder} dossier overdue 4 days" not "stakeholder follow-ups slipping".
- **Top 3 next week, not top 10.** If you have 10 priorities, you have none.
- **Single weekend decision.** Forces Monday clarity. If there is no decision, write "no major call".
- **Decisions need dates.** "Decided X" is incomplete. "Decided X on 2026-05-13" is auditable.
- **No AI-fluff.** Banned: delve, leverage, harness, robust, seamless.

---

## The actual prompt under the hood

```
SYSTEM: Generate the Friday weekly review for {user_name}, week of {iso_week_monday}.

CONTEXT (from memory):
- About me: {user_about_md_contents}
- Voice rules: {feedback_voice_md_contents}
- All hat memory files: {hats_dir_contents}
- Open threads: {project_open_threads_md_contents}
- Last 4 weekly reviews (for trend detection): {last_4_reviews}

LIVE DATA:
- Calendar last 7 days (what happened): {calendar_data}
- Email sent + received last 7 days: {email_summary_data}
- Memory file additions this week: {memory_diff_data}
- Skills invoked this week (skill log): {skill_log_data}

OUTPUT STRUCTURE (mandatory):
# Weekly Review · Week of {iso_week_monday}
## Wins (3 max, with evidence)
## Decisions made (each with date)
## Decay flags (each with days-late + ownership)
## Domain pulse (1-2 lines per hat in {user_about hats list})
## Top 3 for next week (each actionable)
## Single decision to make over the weekend (or "no major call")

RULES:
1. ~600 words total, hard limit.
2. Wins MUST cite specific evidence (not vague "made progress").
3. Decisions MUST have dates.
4. Decay flags MUST have days-late count.
5. Top 3 next week are commitments, same items appearing 3+ weeks running = a structural problem, flag it.
6. Apply voice rules.
7. Do NOT pad, if a section is empty, say "nothing notable".

SIDE EFFECT (after generating):
- Save to weekly-reviews/{iso_date}.md
- If any decay flag is in 3+ consecutive reviews, append to memory/structural_issues.md
- Update memory/project_open_threads.md with new commitments from "Top 3 for next week"
```

Full template at [`prompts/review-prompt.md`](prompts/review-prompt.md).

---

## Setup (15 minutes)

1. Drop SKILL.md + prompt template at `~/.claude/skills/weekly-review/`
2. Create your "hats" memory files: one per domain you operate in. Template at [`templates/memory-templates/hat_template.md`](../../templates/memory-templates/hat_template.md)
3. Make sure Calendar + Gmail MCPs are connected
4. Create the archive directory: `~/.claude/projects/<project>/weekly-reviews/`
5. Test: `/weekly-review` (will pull last 7 days and generate one)
6. Verify: a `weekly-reviews/{YYYY-MM-DD}.md` file got written

---

## Make it Friday cron

```cron
0 17 * * FRI cd /path/to/project && claude --skill weekly-review --output telegram --archive
```

Fires Fri 17:00. Posts to Telegram, archives to `weekly-reviews/{YYYY-MM-DD}.md`. Full setup snippet in [`scripts/cron-friday.sh`](scripts/cron-friday.sh).

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~8.000-15.000 (largest of the 8 skills, lots of context) |
| Model | Claude Opus 4.7 (the trend detection + structural pattern finding benefits from depth) |
| Cost per invocation | **~$0.40-0.80** |
| Latency | 15-30 seconds |
| Monthly cost (4 reviews/mo) | **~$1.60-3.20** |

If you cap to Sonnet 4.6, drops to ~$0.10/run but trend detection across the last 4 weeks gets shallower. Worth Opus for this one.

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/monthly-review` | 30-day window, focus on patterns + decay across multiple weeks | First-of-month |
| `/quarterly-review` | 90-day window, focus on strategic shifts + headcount + revenue | Quarterly board prep |
| `/team-weekly-review` | Pulls team Slack + team calendar + team hat files | Running a team |
| `/family-weekly-review` | Family calendar + household memory + spouse sync notes | Personal life ops |
| `/board-prep-review` | Subset focused on portfolio updates, KPIs, asks | Board meetings |

Same pattern (pull → score across hats → fixed-shape note → archive for trend), different cadence + scope.

---

## Common modifications

**1. Add a "Killed" section.** Things you decided NOT to do this week. Useful for psychological clarity. Append to the prompt.

**2. Track skill usage explicitly.** Add a "Skills invoked" line: which of your 19 skills fired this week. Pinpoints unused skills (delete candidates).

**3. Add a mood/energy 1-10 score.** Self-tracked. Becomes useful at quarterly review for spotting burnout patterns.

**4. Pull from a specific Notion page** for shared accountability. Add Notion MCP and modify the prompt to also read from a specific Notion database.

**5. Auto-share to a coach.** If you have an executive coach, route the weekly review to a shared Notion page they can review before your bi-weekly session.

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1 | Run `/weekly-review` manually for the first time. Compare to your normal Friday routine. |
| 2-7 | Use the skill as the starting point. Edit it to match how you'd write it. Track your edits. |
| 8-14 | Add the cron. Keep editing post-generation each Friday. |
| 15-28 | After 4 weekly reviews accumulated, the trend-detection part starts to work. |
| 29+ | Trust the output. Light edits only. The skill replaces the manual routine. |

The 4-week ramp matters, without trend detection on past reviews, the output is shallow.

---

## What this won't do (failure modes)

- **Will not understand strategic shifts you didn't write down.** If you decided something major in your head and never logged it, the review can't surface it. Use `/memory-curator` or just write it down.
- **Will not catch silent decay across hats you didn't define.** If you operate in 5 domains but only have 3 hat files, the other 2 are invisible to this skill.
- **Will silently degrade if memory files go stale.** Same lesson as `/morning-brief`. Run `/memory-curator` weekly.
- **First review is always shallow.** Without 4-6 weeks of memory file changes to look back on, "domain pulse" is thin. Plan to write your first 2-3 reviews semi-manually before automating.
- **Top-3 next week is a commitment, not a wish list.** If you don't deliver them, decay-flag them next Friday.

---

## When to delete this skill

If you've ignored 3 weekly reviews in a row, **delete it**. Reasons it might not work:
- You don't actually do weekly reviews (be honest)
- Your work is too unstructured to summarize weekly
- You already have a tight Friday ritual that beats this

---

## Why this is universal

Every operator has a Friday. Most do an unstructured "what did this week feel like" reflection. This skill replaces unstructured reflection with structured recall + forward planning, in 1/9th the time. The pattern (pull 7 days from N live sources → score → output fixed-shape note → archive for trend) reuses for monthly / quarterly reviews with minor changes.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Compressed 90min → 10min, 1.3h/week saved.*
