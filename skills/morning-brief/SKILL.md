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

## Non-negotiable rules

- **No "great question" / "happy to help" filler.** This is a brief, not a chat.
- **No AI-fluff words.** Avoid: delve, leverage, harness, robust, seamless, unlock, synergy, em-dashes.
- **Match your voice rules** from `feedback_voice.md`. If you have specific banned/required words, this skill loads them.
- **Decision-first ordering.** What needs your decision today goes to the top, not what arrived first.
- **No re-summarizing if I already saw it.** Use `morning_brief_log.md` to track what was in yesterday's brief — don't repeat unchanged items.

---

## Setup (5 minutes)

1. Drop this file at `~/.claude/skills/morning-brief/SKILL.md`
2. Make sure your Gmail and Calendar MCP servers are connected (`/mcp` in Claude Code)
3. Create the empty file: `~/.claude/projects/<project>/memory/project_open_threads.md` (Claude will populate it as you flag things)
4. (Optional) Create `feedback_voice.md` with your tone rules
5. Test: type `/morning-brief` in Claude Code

---

## Make it daily (cron / Telegram bot)

If you have a Telegram bot running on a VM (see [`setups/chris-claude-code.md`](../../setups/chris-claude-code.md)), schedule:

```cron
0 7 * * * cd /path/to/project && claude --skill morning-brief --output telegram
```

Fires daily 07:00. The bot pushes the brief to your Telegram chat.

---

## Honest caveats

- **Inbox prioritization is heuristic.** Skill ranks by sender importance + recency. Will get it wrong sometimes — flag corrections in your voice rules.
- **Open threads need maintenance.** Without `/memory-curator` running weekly, this list goes stale fast.
- **Calendar dependency.** If your calendar is empty (e.g. Monday after a holiday), the brief gets thin. Add a fallback section in the prompt for "no calendar today".

---

## Why this is universal

Every operator has a morning. Every morning needs prioritization. The pattern (pull from N live sources → score → output a fixed-shape brief) is reusable for any "what's the state of X right now" use case.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Tracked saved time: 2.25h/week (Chris's 8-week sample).*
