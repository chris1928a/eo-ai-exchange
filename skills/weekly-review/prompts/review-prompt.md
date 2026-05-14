# Prompt template — /weekly-review

```
SYSTEM: Generate the Friday weekly review for {user_name}, week of {iso_week_monday}.

CONTEXT (from memory):
- About me + hats list: {user_about_md_contents}
- Voice rules: {feedback_voice_md_contents}
- All hat memory files: {hats_dir_contents}
- Open threads: {project_open_threads_md_contents}
- Last 4 weekly reviews (for trend detection): {last_4_reviews_concatenated}
- Structural issues file (recurring decay flags): {structural_issues_md_contents}

LIVE DATA (last 7 days):
- Calendar (what actually happened, with attendees + duration): {calendar_data}
- Email summary (sent + received counts + flagged threads): {email_summary_data}
- Memory file additions this week (which files grew, which were created): {memory_diff_data}
- Skills invoked this week (skill log): {skill_log_data}

OUTPUT STRUCTURE (mandatory, do not deviate):

# Weekly Review · Week of {iso_week_monday}

## Wins (3 max)
- [Concrete win with evidence] — [date]
- ...

## Decisions made
- [Decision] ({YYYY-MM-DD})
- ...

## Decay flags (things you said you'd do, didn't)
- [Item]: [N days late], [your move | their move]
- ...

## Domain pulse
- **{Hat 1}:** [1-2 sentences]
- **{Hat 2}:** [1-2 sentences]
- **{Hat 3}:** [1-2 sentences]
- ... (one per hat in user_about hats list)

## Top 3 for next week
1. [Specific commitment with verifiable outcome]
2. ...
3. ...

## Single decision to make over the weekend
[One sentence, the call that sets up Monday — OR write "no major call"]

RULES:
1. ~600 words total, hard limit.
2. Wins MUST cite specific evidence (revenue number, contract signed, deliverable shipped). NO vague "made progress".
3. Decisions MUST have dates in (YYYY-MM-DD) format.
4. Decay flags MUST have days-late count.
5. Top 3 for next week are real commitments. If the same item appears in 3+ consecutive reviews → STRUCTURAL ISSUE, flag it.
6. Apply voice rules strictly.
7. Do NOT pad. If a section is empty: write "nothing notable this week".
8. Domain pulse: skip hats with no activity, do not invent.
9. If trend detection finds something noteworthy across the last 4 reviews, add a "Trend" line at the very end (e.g. "Trend: 3rd week with 'dentist' on decay list — book the appointment now or admit it's not happening").

SIDE EFFECTS (after generating output):
1. Save the review verbatim to weekly-reviews/{iso_date}.md
2. If any decay flag is in 3+ consecutive reviews, append the item + dates to memory/structural_issues.md
3. Update memory/project_open_threads.md: replace the "open threads" with the "Top 3 for next week" items
4. Log invocation to memory/_meta/skill_log.md

OUTPUT: just the review. No preamble. No closing.
```

---

## Variables

| Variable | Source |
|---|---|
| `{user_name}` | memory/user_about.md |
| `{iso_week_monday}` | Monday of the current ISO week, YYYY-MM-DD |
| `{user_about_md_contents}` | Full body |
| `{feedback_voice_md_contents}` | Full body |
| `{hats_dir_contents}` | Concatenated contents of all files in memory/hats/ |
| `{project_open_threads_md_contents}` | Full body |
| `{last_4_reviews_concatenated}` | Last 4 files in weekly-reviews/, concatenated |
| `{structural_issues_md_contents}` | Full body, may be empty |
| `{calendar_data}` | Calendar MCP query: all events in last 7 days with attendees + duration |
| `{email_summary_data}` | Gmail MCP query: count of sent + received, flagged thread subjects |
| `{memory_diff_data}` | git diff of memory/ folder over last 7 days |
| `{skill_log_data}` | tail of memory/_meta/skill_log.md for last 7 days |

---

## Performance notes

- ~8.000-15.000 input tokens (largest of the 8 skills due to 4-week look-back)
- Opus 4.7 for trend detection (Sonnet works but trend insight gets shallower)
- ~$0.40-0.80 per invocation, 4x/month = ~$1.60-3.20/mo
- Latency 15-30 seconds
