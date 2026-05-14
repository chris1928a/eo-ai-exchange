# Prompt template — /morning-brief

> The actual LLM prompt sent when `/morning-brief` triggers. Fork + customize. Variables in `{curly_braces}` get filled by Claude Code from your memory files + MCP server data.

---

## System prompt

```
You are generating a 5-bullet morning brief for {user_name}.

CONTEXT (loaded from memory):
- About me: {user_about_md_contents}
- Voice rules: {feedback_voice_md_contents}
- Channel rules (output is going to {output_channel}): {feedback_channel_rules_md_contents}

LIVE DATA (loaded from MCP at invocation time):
- Calendar today (next 8h):
{calendar_data}

- Gmail unread top 5 by sender priority:
{inbox_data}

- Open threads from memory/project_open_threads.md:
{threads_data}

- Yesterday's brief (from morning_brief_log.md):
{yesterday_brief}

RULES:
1. Output exactly 5 bullets, ordered by decision urgency (NOT by arrival time).
2. Final line: "Top decision today: [single sentence]" — the ONE call I have to make today.
3. Total length under 250 words.
4. Apply voice rules above strictly (banned words + required style).
5. Do NOT repeat any item that appeared in yesterday's brief unchanged.
6. If a calendar event has no obvious importance, omit it from the bullets.
7. If inbox top-5 is all low-priority, say so on bullet 1 and use the bullets for calendar + threads.
8. Output format must be Telegram-friendly (no markdown headings, plain text bullets only).

OUTPUT: just the 5 bullets + final line. No preamble. No closing. No "great question". No "I hope this helps".
```

---

## How variables get filled

| Variable | Source |
|---|---|
| `{user_name}` | `memory/user_about.md` frontmatter `name:` field |
| `{user_about_md_contents}` | Full `memory/user_about.md` body |
| `{feedback_voice_md_contents}` | Full `memory/feedback_voice.md` body |
| `{feedback_channel_rules_md_contents}` | Full `memory/feedback_channel_rules.md` body |
| `{output_channel}` | Set by the cron command via `--output {channel}` flag |
| `{calendar_data}` | Calendar MCP server query for next 8 hours, formatted as a list |
| `{inbox_data}` | Gmail MCP server query for top 5 unread, ranked by sender + recency |
| `{threads_data}` | Full contents of `memory/project_open_threads.md` |
| `{yesterday_brief}` | Last entry in `memory/morning_brief_log.md` |

---

## Customization tips

- **Banned words list growing.** Add to `feedback_voice.md`, this prompt picks them up automatically (no need to edit the prompt).
- **Output too long.** Change "under 250 words" to "under 150 words" — Claude respects hard limits.
- **Output too terse.** Change "exactly 5 bullets" to "5 to 7 bullets, prefer 5".
- **Want sections instead of flat bullets?** Replace the OUTPUT format block with `### Inbox\n- ...\n### Calendar\n- ...\n### Threads\n- ...`.
- **Multi-language.** Add a line: "Output language: {language}." Then set `language: de` in your `user_about.md` frontmatter.

---

## Performance notes

- Token count per fill: ~1.500-3.000 input + ~200-400 output
- Sonnet 4.6 is the right model for this skill (Opus is overkill, Haiku misses prioritization nuance)
- Latency dominated by MCP server response time, not Claude's generation
