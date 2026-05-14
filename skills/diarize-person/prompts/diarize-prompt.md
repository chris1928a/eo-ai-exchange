# Prompt template — /diarize-person

```
SYSTEM: Generate a 1-page stakeholder dossier on {person_name} for {user_name}.

CONTEXT (from memory):
- About me: {user_about_md_contents}
- Voice rules: {feedback_voice_md_contents}
- Existing memory file for this person: {people_slug_md_contents OR "none, this is the first dossier"}

LIVE DATA (from MCP servers):
- Gmail threads with {person_name}, last 90 days: {email_data}
- Calendar history with {person_name}, last 12 months: {calendar_data}
- WhatsApp messages (if WhatsApp MCP connected): {whatsapp_data OR "not available"}
- Notion mentions (if Notion MCP connected): {notion_data OR "not available"}
- LinkedIn profile (if scraped within 90 days): {linkedin_data OR "not available"}

OUTPUT STRUCTURE (mandatory, do not change):

# {Name} · {Role @ Company}

## Who they are
[2-3 sentences. Role + company size + what they care about + what they avoid. Cite evidence from email/calendar — do not guess.]

## Last 5 interactions (newest first)
1. [YYYY-MM-DD] [Channel] [1-line summary with decision or promise made]
2. ...

## Open threads (your move | their move)
- [Thread name]: [your move | their move] — [1-line context]
- ...

## Communication style
- Channel preference: [WhatsApp / Email / Phone / In-person] — based on which channel they initiate from
- Tone: [Du / Sie] [formal / casual]
- Decision style: [analytical / gut / committee] — cite a specific email as evidence
- Sensitivities: [topics they flagged or showed they avoid] — cite evidence

## Open questions for this meeting
1. ...
2. ...
3. ...
(MAX 3, ordered by what shifts the meeting outcome)

## Last-touch context
"[Exact verbatim quote of their last message to you, in original language]" — [Their first name], [Channel] [date]

RULES:
1. Total length under 400 words. Hard limit.
2. Decision style + sensitivities MUST cite evidence from the data. No guessing.
3. Open threads MUST have ownership tag (your move / their move).
4. If first dossier (no memory file exists): skip "Open questions for this meeting", instead add "First-touch notes" with 3 things to learn during the meeting.
5. Apply voice rules above strictly (banned words + required style).
6. Do NOT include any speculation about their feelings or motivations beyond what the data shows.
7. Do NOT pad. If a section has no data, write "No signal yet."

SIDE EFFECT (after generating output, write back to memory):
1. Append today's interaction to memory/people/{slug}.md (newest at top)
2. Update the "open threads" section to reflect current state
3. If new sensitivities surfaced in chat, add them to memory file with date
4. If aliases mismatch (e.g. "Anna B." in WhatsApp, "Anna Beispiel" in Gmail), flag for manual reconciliation

OUTPUT: just the dossier. No preamble. No closing.
```

---

## Variables

| Variable | Source |
|---|---|
| `{user_name}` | `memory/user_about.md` frontmatter `name:` field |
| `{person_name}` | The argument you passed to `/diarize-person` |
| `{user_about_md_contents}` | Full `memory/user_about.md` body |
| `{feedback_voice_md_contents}` | Full `memory/feedback_voice.md` body |
| `{people_slug_md_contents}` | Body of `memory/people/{slugified-name}.md`, or "none, this is the first dossier" |
| `{email_data}` | Gmail MCP query: all threads in last 90 days where {person_name} is sender or recipient |
| `{calendar_data}` | Calendar MCP query: all events in last 12 months with {person_name} as attendee |
| `{whatsapp_data}` | WhatsApp MCP query (if connected): messages with {person_name} |
| `{notion_data}` | Notion MCP query: pages mentioning {person_name} |
| `{linkedin_data}` | LinkedIn scrape (if available): role, company, recent posts |

---

## Performance notes

- ~3.000-8.000 input tokens, ~600-1.200 output tokens per invocation
- Sonnet 4.6 default. Opus 4.7 if first dossier on a sparse-data person.
- Latency dominated by Gmail thread fetch (5-10s for 90 days of history)
- Cache the static parts (user_about, voice rules) for 40% cost reduction at scale
