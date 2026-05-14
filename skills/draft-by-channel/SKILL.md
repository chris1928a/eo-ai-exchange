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

Generate drafts that match (a) your voice, (b) the channel's conventions, and (c) the recipient's preferred style. The same message to a recipient on WhatsApp ≠ that message to them by email. Skill never confuses them.

The pattern is: **resolve recipient + channel + intent → load voice rules + channel rules + recipient overrides → output one draft in the right format**. Reusable for any "I need to communicate X to Y on Z" use case.

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
{Name}, Termin Mittwoch 14h passt. Schick die Agenda?
```

**Example shape, Email:**
```
Subject: Mittwoch 14h, ja

Hi {Name},

Mittwoch 14h passt. Kannst du mir vorab die Agenda schicken, die zwei
Themen die ich diskutieren möchte sind X und Y.

Bis Mittwoch,
{Your first name}
```

Same intent, completely different surface.

---

## Worked example — same intent, 4 channels, 4 outputs

**Intent:** confirm a Wednesday 14:00 meeting + ask for the agenda
**Recipient:** Anna Beispiel (Du-form, professional but warm, German)
**Context:** scheduled last week, she promised to send agenda

### Output 1 — WhatsApp (3 sentences max, no greeting/sign-off)

```
Anna, Mittwoch 14h passt. Schick mir bitte die Agenda?
Bin gespannt auf deine zwei Punkte.
```

### Output 2 — Email internal (Hi + first name sign-off, 5 sentences max)

```
Subject: Mittwoch 14h, ja

Hi Anna,

Mittwoch 14h passt bei mir. Kannst du mir vorab die Agenda schicken,
die zwei Themen die ich diskutieren möchte sind die Q3-Lieferung und
das Reporting-Setup für deinen Manager.

Bis Mittwoch,
Chris
```

### Output 3 — LinkedIn DM (no greeting, no sign-off, 4 sentences max)

```
Anna, Mittwoch 14h passt. Wenn du vorher die Agenda schickst, bin
ich vorbereitet. Meine zwei Themen: Q3-Lieferung und Reporting für
deinen Manager. Freue mich.
```

### Output 4 — Slack (no greeting, no sign-off, 2 sentences max)

```
Mi 14h passt. Agenda vorab?
```

Same intent. Four totally different outputs. Skill never accidentally puts a sign-off in Slack or skips a greeting in email.

---

## Non-negotiable rules

- **No AI-fluff.** Banned: delve, leverage, harness, robust, seamless, em-dashes, "I hope this finds you well".
- **Channel discipline.** WhatsApp drafts have no greeting / no sign-off. Email drafts always have both.
- **Du/Sie consistency.** Skill never switches mid-message. Default per recipient is in their memory file.
- **One concrete number per outreach** if it's a sales / advisory message (e.g. "in 6 to 9 months" not "fairly quickly").
- **Sign-off is first name only in DMs**, full sign-off block only in formal emails.
- **Match your voice exactly.** If your `feedback_voice.md` says "always German Umlaute", skill enforces.

---

## The actual prompt under the hood

```
SYSTEM: Draft a {channel} message from {user_name} to {recipient}.

CONTEXT (from memory):
- About me: {user_about_md_contents}
- Voice rules: {feedback_voice_md_contents}
- Channel rules for {channel}: {feedback_channel_rules_md_contents → row for {channel}}
- Recipient memory file: {people_slug_md_contents OR "no memory file yet, use channel defaults"}

INTENT: {intent}
CONTEXT FOR THIS MESSAGE: {context_paragraph}

OUTPUT FORMAT (mandatory, do not deviate):
- Channel = WhatsApp/Telegram/Slack: NO greeting, NO sign-off, max 3 sentences (max 2 for Slack)
- Channel = Email internal: "Hi {recipient_first_name}," greeting, "{user_first_name}" sign-off, max 5 sentences
- Channel = Email external warm: same as internal, max 6 sentences
- Channel = Email external formal: "Sehr geehrter Herr/Frau {last_name}," greeting, full sign-off block, max 8 sentences
- Channel = LinkedIn DM: NO greeting, NO sign-off, max 4 sentences

RULES:
1. Apply voice rules strictly (banned words list).
2. Match recipient's last register (Du/Sie). If unknown, default per memory file or channel rules.
3. ONE concrete number/specific reference per message if intent is sales/advisory.
4. Output ONE draft. No alternatives unless asked.
5. Output ONLY the draft text. No "Here is your draft:" preamble.
```

Full template at [`prompts/draft-prompt.md`](prompts/draft-prompt.md).

---

## Setup (10 minutes)

1. Drop this file at `~/.claude/skills/draft-by-channel/SKILL.md`
2. Copy [`prompts/draft-prompt.md`](prompts/draft-prompt.md) alongside
3. Create the channel rules file `~/.claude/projects/<project>/memory/feedback_channel_rules.md` from the template at [`templates/memory-templates/feedback_channel_rules.md`](../../templates/memory-templates/feedback_channel_rules.md)
4. Create voice rules at `feedback_voice.md` from the template
5. Make sure `/diarize-person` exists so recipient memory files get auto-created
6. Test: `/draft-by-channel {recipient name} WhatsApp "Mittwoch 14h passt"`
7. Verify: output respects channel rules (no greeting in WhatsApp, etc.)
8. Test on email: `/draft-by-channel {recipient name} Email-internal "same intent"`
9. Compare the two outputs — same intent, different surfaces

---

## Channel rules: defaults to start with

| Channel | Greeting | Sign-off | Max length | Tone |
|---|---|---|---|---|
| WhatsApp | None | First name only (or none) | 3 sentences | Direct, informal |
| Email (internal) | "Hi {first}," | First name | 5 sentences | Friendly, direct |
| Email (external warm) | "Hi {first}," | First name | 6 sentences | Warm, direct |
| Email (external formal) | "Sehr geehrter Herr/Frau {last}," | Full sign-off block | 8 sentences | Formal |
| LinkedIn DM | None | None | 4 sentences | Match recipient's profile register |
| Slack | None | None | 2 sentences | Direct, no fluff |

Override per recipient in their `memory/people/{slug}.md`.

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~1.000-2.000 (small, voice rules are the bulk) |
| Model | Claude Sonnet 4.6 (Haiku is too rigid on voice matching) |
| Cost per invocation | **~$0.005-0.015** |
| Latency | 1-3 seconds |
| Monthly cost (~8 drafts/day = 240/mo) | **~$1.50-4** |

Cheapest skill in the set on a per-invocation basis. The quality cliff is at the voice-rules size — bigger voice file = more tokens, more cost, but better matching.

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/draft-by-channel --variants 3` | Output 3 versions (terse / standard / warm) | When stakes are high |
| `/draft-by-channel --tone {tone}` | Override default tone (e.g. "apologetic", "firm") | Damage-control moments |
| `/draft-reply-by-channel` | Reads the inbound message + drafts a reply matching tone | Reduces "what register did they use" lookup |
| `/draft-cold-outreach` | Specific subset for first-touch sales/intro messages | Sales workflows |
| `/draft-rejection` | Specific tone-aware "no" drafts (firm + kind + brief) | Saying no without burning relationships |

---

## Common modifications

**1. Add a "tone" field to recipient memory.** In `memory/people/{slug}.md`, add a `tone:` field. The skill respects it on every draft to that person.

**2. Add per-channel character limits override.** Some clients have stricter limits. Per-recipient override in memory file: `whatsapp_max_chars: 100`.

**3. Output to clipboard automatically.** Pipe through `pbcopy` (Mac) or `xclip` (Linux) so the draft is ready to paste.

**4. Compare to last sent.** Add to the prompt: "Compare to the last 3 messages sent to this person — flag if voice drifted." Catches your own register slipping.

**5. Multi-language switching.** If recipient memory has `language: en` and your default is `de`, the skill switches to English automatically for this person.

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1-3 | Use `/draft-by-channel` for 5-10 messages per day. Compare drafts to what you would have written. Edit the differences. |
| 4-7 | Continue, but track which edits you make. Most edits = a missing rule. Add to `feedback_voice.md`. |
| 8-14 | After 2 weeks, your voice rules should be tight. Drafts need <10% editing. |
| 15-21 | Drop manual drafting for low-stakes messages. Use the skill for everything except critical/sensitive ones. |
| 22+ | Audit weekly: did your voice change in the last week? Update `feedback_voice.md`. |

---

## What this won't do (failure modes)

- **Will not match a voice you haven't defined.** If `feedback_voice.md` is sparse, drafts feel generic. The fix is more voice rules + more examples in the file.
- **Will not handle threaded replies well without context.** If you reply to a 5-email thread without pasting the prior context, the draft may miss what the reply is actually about.
- **Will not invent personal news.** If you ask it to "wish them happy birthday", it doesn't know it's their birthday. Pass that as context.
- **Will sometimes default to over-formal in ambiguous cases.** If a person is mixed Du/Sie history, skill defaults to Sie. Override per recipient.
- **Will not catch tone-shifts mid-relationship.** If you and a recipient moved from formal to casual over months, but your memory file still says "Sie", the skill keeps using Sie. Update the memory file.

---

## When to delete this skill

If you find yourself rewriting most drafts substantially, **delete it** — your voice rules aren't tight enough yet. Reasons it might not work:
- Your communication is highly contextual and rule-defying
- You communicate in too many languages with no per-recipient overrides
- You don't have time to maintain `feedback_voice.md` (the skill quality is downstream of that file)

---

## Why this is universal

Every operator drafts dozens of messages per week across channels. Each channel has rules. Each recipient has preferences. Without a skill enforcing both, you spend 5 minutes per message on "how should I phrase this." With a skill, 1 minute, and consistency improves.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Tracked saved time: 2.7h/week (Chris's 8-week sample, ~8 drafts/day).*
