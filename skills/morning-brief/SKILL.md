---
name: morning-brief
type: universal
load_when: morning brief, brief me, what's on today, daily standup, today's plan
---

# /morning-brief

> **Universal skill from Event #1, Demo 1 (Chris).**
> Daily 7am brief in Telegram (or terminal): inbox top 3, today's calendar, open threads. Tracked time saved: **2.25h/week** in Chris's setup.

---

## Purpose

Replace the 30-minute "what's going on today" morning routine with a 3-minute briefing pulled from your live data sources. Designed to be invoked on a daily cron OR ad-hoc when you say "brief me".

The pattern is: **pull from N live sources → score → output a fixed-shape brief**. Reusable for any "what's the state of X right now" use case.

---

## Inputs (4 sources)

1. **Calendar** (today, next 8 hours) — via your calendar MCP server
2. **Inbox top 3** — unread emails ranked by sender + recency, via Gmail MCP
3. **Open threads** — anything you flagged in `~/.claude/projects/<project>/memory/project_open_threads.md`
4. **Voice rules** — `~/.claude/projects/<project>/memory/feedback_voice.md` (so the brief sounds like you, not like an AI)

---

## Outputs

A 5-bullet brief, no fluff, in this exact shape:

```
1. [Most-decision-needing item from inbox]
2. [Second inbox item OR calendar conflict to resolve]
3. [Calendar: 1-line summary of next 8 hours, named conflicts only]
4. [Open thread that decays today if untouched]
5. [One thing you flagged yesterday and haven't done]

Top decision today: [single line, the one call you have to make today]
```

Total length: under 250 words. Posted to Telegram / Slack / terminal — wherever you set the output.

---

## Worked example — Tuesday morning, real data

**Input data Claude Code would see at 07:00:**
- Calendar: 09:00 board prep, 11:00 sales call (cold prospect), 14:00 client diagnostic, 16:00 partner sync, 18:00 family
- Gmail unread: 12 messages
- Open threads file: 3 items (Q3 plan response overdue 2 days, partner quote awaiting OK, dentist confirm)
- Voice rules: Du-Form internal, no AI-fluff, lead with decisions

**Output Claude Code produces:**

```
1. Q3 plan response is 2 days overdue. Partner needs your call by 12:00.
2. Cold prospect at 11:00 has not confirmed agenda — send 1-line ping by 09:00.
3. Today: 5 calls, longest gap 12:00-14:00 (use for Q3 plan).
4. Partner quote OK is decay-flagged — answer yes/no in 5 min.
5. Dentist confirm slipped from yesterday — 30 sec text.

Top decision today: Q3 plan yes/no by 12:00.
```

5 bullets, decision-ordered, no greeting, no sign-off. Posted to Telegram at 07:02.

---

## Non-negotiable rules

- **No "great question" / "happy to help" filler.** This is a brief, not a chat.
- **No AI-fluff words.** Avoid: delve, leverage, harness, robust, seamless, unlock, synergy, em-dashes.
- **Match your voice rules** from `feedback_voice.md`. If you have specific banned/required words, this skill loads them.
- **Decision-first ordering.** What needs your decision today goes to the top, not what arrived first.
- **No re-summarizing if I already saw it.** Use `morning_brief_log.md` to track what was in yesterday's brief — don't repeat unchanged items.

---

## The actual prompt under the hood

When `/morning-brief` triggers, Claude Code constructs this prompt:

```
SYSTEM: You are generating a 5-bullet morning brief for {user_name}.
Voice rules from feedback_voice.md: {voice_rules}.

INPUTS:
- Calendar today (next 8h): {calendar_data}
- Gmail unread top 5 by sender priority: {inbox_data}
- Open threads from memory/project_open_threads.md: {threads_data}
- Yesterday's brief (from morning_brief_log.md): {yesterday_brief}

RULES:
- Output exactly 5 bullets, ordered by decision urgency
- Final line: "Top decision today: [single sentence]"
- Total length under 250 words
- Apply voice rules above strictly (banned words + required style)
- Do NOT repeat any item that appeared in yesterday's brief unchanged

OUTPUT: just the 5 bullets + final line. No preamble. No closing.
```

Full prompt template forkable from [`prompts/morning-brief-prompt.md`](prompts/morning-brief-prompt.md).

---

## Setup (5 minutes)

1. Drop this file at `~/.claude/skills/morning-brief/SKILL.md`
2. Copy [`prompts/morning-brief-prompt.md`](prompts/morning-brief-prompt.md) alongside it
3. Make sure your Gmail and Calendar MCP servers are connected (`/mcp` in Claude Code)
4. Create the empty file: `~/.claude/projects/<project>/memory/project_open_threads.md` (Claude will populate it as you flag things)
5. (Optional) Create `feedback_voice.md` with your tone rules — see [templates/memory-templates/feedback_voice.md](../../templates/memory-templates/feedback_voice.md)
6. Test: type `/morning-brief` in Claude Code. Compare the output to the worked example above.

---

## Make it daily (cron / Telegram bot)

If you have a Telegram bot running on a VM (see [`setups/chris-claude-code.md`](../../setups/chris-claude-code.md)), schedule:

```cron
0 7 * * * cd /path/to/project && claude --skill morning-brief --output telegram
```

Fires daily 07:00. The bot pushes the brief to your Telegram chat.

Full cron-setup snippet at [`scripts/cron-setup.sh`](scripts/cron-setup.sh).

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~1.500-3.000 (depends on inbox + calendar volume) |
| Model | Claude Sonnet 4.6 (cheaper, fast enough) |
| Cost per invocation | **~$0.01-0.03** |
| Latency | 3-8 seconds (mostly waiting on Gmail/Calendar API responses) |
| Monthly cost (daily cron) | **~$0.30-0.90** |

Switch to Opus 4.7 if you want better prioritization on a noisy inbox — adds ~$0.10/run = $3/mo. Not usually worth it for this skill.

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/weekly-brief` | Pulls 7-day window instead of 8-hour, daily summary becomes weekly recap | Friday afternoon mode |
| `/quarterly-brief` | 90-day window, focused on patterns + decay | First-of-quarter planning |
| `/team-brief` | Pulls from team Slack + shared Notion + team calendar | If you run a team |
| `/family-brief` | Family calendar + family WhatsApp group + household memory | Personal life ops |
| `/morning-brief --voice` | Outputs as a 30-second audio clip via TTS | Morning walks |

Same pattern (pull → score → fixed-shape output), different N + sources.

---

## Common modifications

**1. Add a 4th data source.** Open `SKILL.md`, add to the Inputs list, update the prompt template. Most common addition: WhatsApp unread (via WhatsApp MCP).

**2. Change the output shape.** Want 3 bullets instead of 5? Want sections (Inbox / Calendar / Threads) instead of unified bullets? Edit the OUTPUT block in `prompts/morning-brief-prompt.md`. The skill picks up the new shape on next invocation.

**3. Add a "yesterday review" sub-section.** Append to the prompt: "After the 5 bullets, add 2 bullets summarizing what got done yesterday vs what didn't." Increases token cost ~30%.

**4. Route output by day-of-week.** Make Mon-Wed go to Telegram, Thu-Fri go to email, weekends skip. Edit cron command + add a small bash wrapper.

**5. Multi-language.** Add `language: de` to the SKILL.md frontmatter. The skill switches output to German. For mixed inboxes, the skill keeps the original language of each item.

---

## Migration playbook (manual → automated)

Don't switch from manual to fully-automated overnight. Real ramp:

| Day | What you do | Why |
|---|---|---|
| 1-3 | Run `/morning-brief` manually each morning. Compare to your normal routine. | Build trust + tune prompt |
| 4-7 | Same, but also send the brief to a private Telegram channel. Don't act on it yet. | Learn what it gets wrong |
| 8-14 | Add the cron, but ALSO keep doing your manual routine in parallel. | Verify the cron-fired brief matches what you'd produce |
| 15-21 | Drop manual routine. Use the brief as primary input each morning. | Real adoption |
| 22+ | Audit weekly: is the brief still accurate? Do you skip it? Why? | Maintenance |

Skipping this ramp = brief gets ignored within 2 weeks because you don't trust it.

---

## What this won't do (failure modes)

- **Will not flag emails from senders not in your contact graph.** If a critical email comes from someone Claude has no context on, it gets ranked low. Mitigation: keep a `memory/important_senders.md` list.
- **Will not understand calendar item importance from titles alone.** "Sync" means very different things across teams. Mitigation: prefix critical events ("[CRITICAL] board sync").
- **Will not catch items in a 4th channel you forgot to wire up** (Slack, WhatsApp, LinkedIn, etc). Add them deliberately.
- **Will not summarize attachments.** A PDF in your inbox will not be opened. Mitigation: use a separate `/process-attachments` skill weekly.
- **Will silently degrade if memory files go stale.** This is the #1 reason briefs get bad over time. Run `/memory-curator` weekly to prevent.

---

## When to delete this skill

If you find yourself ignoring the morning brief for >2 weeks, **delete it**, do not let it sit unused. Reasons it might not work for you:
- Your work is async, no fixed-time briefing makes sense
- Your inbox is too noisy for ranking to mean anything
- You already have a strong manual ritual that beats this

Skills should earn their slot. If this one doesn't, fork a different one.

---

## Why this is universal

Every operator has a morning. Every morning needs prioritization. The pattern (pull from N live sources → score → output a fixed-shape brief) is reusable for any "what's the state of X right now" use case. This skill is the highest-leverage one in the whole 8-skill set because it is the one you use every single day.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Tracked saved time: 2.25h/week (Chris's 8-week sample). The first skill most operators should fork.*
