---
name: draft-by-channel
type: universal
load_when: draft to, draft for, write to, message to, email to, whatsapp to
---

# /draft-by-channel

> **Universal skill from Event #1, Demo 1 (Chris).**
> Voice-locked drafts per person + channel. WhatsApp tone ≠ email tone. No leakage. Tracked saved time: **2.7h/week** in Chris's setup (~8 messages/day, 5min → 1min each).

---

## Purpose

Generate drafts that match (a) your voice, (b) the channel's conventions, and (c) the recipient's preferred style. The same message to Sandra on WhatsApp ≠ that message to Sandra by email. Skill never confuses them.

---

## Inputs

1. **Recipient** — name, resolved to memory file `memory/people/{slug}.md` (see [`/diarize-person`](../diarize-person/SKILL.md))
2. **Channel** — WhatsApp / Email / LinkedIn DM / Slack / Telegram
3. **Intent** — what you want the message to do (info / ask / decline / follow up / thank)
4. **Context** — paste-in or memory pointer (e.g. "the proposal we sent yesterday")
5. **Voice rules** — `memory/feedback_voice.md` (banned words, required style, Du/Sie default)
6. **Channel rules** — `memory/feedback_channel_rules.md` (e.g. WhatsApp = max 3 sentences, no greetings; Email = greeting + sign-off mandatory)

---

## Outputs

A single draft in the right format for the channel. No alternatives offered (you can ask for one if you want a second pass — but the default is decisive).

**Example shape, WhatsApp:**
```
Sandra, Termin Mittwoch 14h passt. Schick die Agenda?
```

**Example shape, Email:**
```
Subject: Mittwoch 14h, ja

Hi Sandra,

Mittwoch 14h passt. Kannst du mir vorab die Agenda schicken — die zwei
Themen die ich diskutieren möchte sind X und Y.

Bis Mittwoch,
Chris
```

Same intent, completely different surface.

---

## Non-negotiable rules

- **No AI-fluff.** Banned: delve, leverage, harness, robust, seamless, em-dashes, "I hope this finds you well".
- **Channel discipline.** WhatsApp drafts have no greeting / no sign-off. Email drafts always have both.
- **Du/Sie consistency.** Skill never switches mid-message. Default per recipient is in their memory file.
- **One concrete number per outreach** if it's a sales / advisory message (e.g. "in 6 to 9 months" not "fairly quickly").
- **Sign-off is first name only in DMs**, full sign-off block only in formal emails.
- **Match your voice exactly.** If your `feedback_voice.md` says "always German Umlaute", skill enforces.

---

## Setup (10 minutes)

1. Drop this file at `~/.claude/skills/draft-by-channel/SKILL.md`
2. Create the channel rules file `~/.claude/projects/<project>/memory/feedback_channel_rules.md` — see template at [`templates/memory-templates/feedback_channel_rules.md`](../../templates/memory-templates/feedback_channel_rules.md)
3. Create voice rules at `feedback_voice.md` — see template at [`templates/memory-templates/feedback_voice.md`](../../templates/memory-templates/feedback_voice.md)
4. Make sure `/diarize-person` exists so recipient memory files get auto-created
5. Test: `/draft-by-channel Sandra WhatsApp "Mittwoch 14h passt"`

---

## Channel rules: defaults to start with

| Channel | Greeting | Sign-off | Max length | Tone |
|---|---|---|---|---|
| WhatsApp | None | First name only | 3 sentences | Direct, informal |
| Email (internal) | "Hi {first}," | First name | 5 sentences | Friendly, direct |
| Email (external) | "Hi {first}," / "Sehr geehrter Herr {last}," | Full sign-off block | 6 sentences | Match recipient's last register |
| LinkedIn DM | None | None | 4 sentences | Same register as recipient's profile |
| Slack | None | None | 2 sentences | Direct, no fluff |

Override per recipient in their `memory/people/{slug}.md`.

---

## Honest caveats

- **First-time recipient = shallow draft.** Without a memory file, the skill defaults to neutral register. Run `/diarize-person` first if it's an important message.
- **Channel switching mid-thread is dangerous.** If you're in WhatsApp and then move to email, run the skill fresh — don't try to "translate" the WhatsApp draft.
- **Voice drift over time.** If your voice changes (e.g. you decide you want to be less formal), update `feedback_voice.md` immediately or the skill perpetuates the old voice.

---

## Why this is universal

Every operator drafts dozens of messages per week across channels. Each channel has rules. Each recipient has preferences. Without a skill enforcing both, you spend 5 minutes per message on "how should I phrase this." With a skill, 1 minute, and consistency improves.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Tracked saved time: 2.7h/week (Chris's 8-week sample, ~8 drafts/day).*
