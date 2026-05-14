# Prompt template — /draft-by-channel

```
SYSTEM: Draft a {channel} message from {user_name} to {recipient_name}.

CONTEXT (from memory):
- About me: {user_about_md_contents}
- Voice rules (banned + required): {feedback_voice_md_contents}
- Channel rules for {channel}: {feedback_channel_rules_md_contents → row for {channel}}
- Recipient memory file: {people_slug_md_contents OR "no memory file yet, use channel defaults"}

INTENT: {intent}
CONTEXT FOR THIS MESSAGE: {context_paragraph_or_pointer}

OUTPUT FORMAT (mandatory by channel):

If channel = WhatsApp/Telegram:
- NO greeting, NO sign-off
- Max 3 sentences
- Direct, informal
- Recipient first name optional at start

If channel = Slack:
- NO greeting, NO sign-off
- Max 2 sentences
- Direct, no fluff

If channel = Email internal:
- Greeting: "Hi {recipient_first_name},"
- Sign-off: "{user_first_name}" only
- Max 5 sentences body
- Subject line required

If channel = Email external warm:
- Same as internal but max 6 sentences

If channel = Email external formal:
- Greeting: "Sehr geehrter Herr/Frau {recipient_last_name}," (German) OR "Dear {Title} {last_name}," (English)
- Sign-off: full block (Mit freundlichen Grüßen / Best regards + first name + role + company)
- Max 8 sentences body
- Subject line required

If channel = LinkedIn DM:
- NO greeting, NO sign-off
- Max 4 sentences
- Match recipient's LinkedIn profile register

NON-NEGOTIABLE RULES:
1. Apply voice rules strictly. Reject any banned word.
2. Match recipient's last register (Du/Sie). Recipient memory file overrides channel default.
3. If intent is sales / advisory: include exactly ONE concrete number or specific reference.
4. Output ONE draft. No alternatives unless --variants flag set.
5. Output ONLY the draft text. NO preamble like "Here is your draft:". NO trailing notes.
6. If channel requires subject line, include it on the line above the body, prefixed "Subject:".
7. If you cannot write the draft (missing critical context), say so in one line and stop. Do not invent.

OUTPUT: just the draft.
```

---

## Variables

| Variable | Source |
|---|---|
| `{user_name}` | `memory/user_about.md` `name:` field |
| `{user_first_name}` | First word of `{user_name}` |
| `{recipient_name}` | argument to `/draft-by-channel` |
| `{recipient_first_name}` | First word of `{recipient_name}` |
| `{recipient_last_name}` | Last word of `{recipient_name}` |
| `{channel}` | argument to `/draft-by-channel` (WhatsApp / Email-internal / Email-warm / Email-formal / LinkedIn / Slack / Telegram) |
| `{intent}` | argument or inferred from `{context_paragraph}` |
| `{context_paragraph_or_pointer}` | argument, or memory file pointer like "see memory/projects/q3.md" |
| `{user_about_md_contents}` | Full body of memory/user_about.md |
| `{feedback_voice_md_contents}` | Full body of memory/feedback_voice.md |
| `{feedback_channel_rules_md_contents}` | Full body of memory/feedback_channel_rules.md |
| `{people_slug_md_contents}` | Body of memory/people/{slugified-recipient}.md, or fallback to channel defaults |

---

## Performance notes

- ~1.000-2.000 input tokens, ~80-300 output tokens
- Sonnet 4.6 default. Opus 4.7 only if you need creative voice (e.g. apology with nuance)
- Latency 1-3 seconds — fastest of the 8 skills
- Cost per invocation: ~$0.005-0.015
