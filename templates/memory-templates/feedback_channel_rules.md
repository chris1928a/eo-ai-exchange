---
name: Channel rules
description: Per-channel formatting, greeting, sign-off, length defaults
type: feedback
---

# Channel rules

These defaults apply unless a person's `memory/people/{slug}.md` overrides.

| Channel | Greeting | Sign-off | Max length | Tone |
|---|---|---|---|---|
| **WhatsApp** | None | First name only | 3 sentences | Direct, informal |
| **Telegram** | None | None | 3 sentences | Direct, command-style |
| **iMessage / SMS** | None | None | 2 sentences | Direct, informal |
| **Email (internal team)** | "Hi {first}," | First name | 5 sentences | Friendly, direct |
| **Email (external warm)** | "Hi {first}," | First name | 6 sentences | Warm, direct |
| **Email (external formal)** | "Sehr geehrter Herr {last}," / "Dear {Title} {last}," | Full sign-off block | 8 sentences | Formal |
| **LinkedIn DM** | None | None | 4 sentences | Match recipient profile register |
| **Slack** | None | None | 2 sentences | Direct, no fluff |
| **Loom / async video script** | "Quick one for {first}." | None (video ends) | 90 seconds | Conversational |
| **Meeting note / Notion** | None | "{your initials}, {date}" | n/a | Bullets > prose |

## Hard rules

- **Never put greeting in Slack.** It's already async chat, no need.
- **Never sign WhatsApp with full name.** First name max.
- **Never send mega-paragraphs in DM.** If it would be more than 3 sentences, send an email or a Loom.
- **Channel-switch warning.** If a thread starts in WhatsApp and moves to email, regenerate the draft fresh, don't translate the WhatsApp version.

## Per-recipient overrides

If a person's memory file `memory/people/{slug}.md` specifies different rules (e.g. one stakeholder always uses Sie even in WhatsApp), those win over this file.
