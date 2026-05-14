# Sample — same intent, 4 channels, 4 different outputs

> Real shape of `/draft-by-channel` outputs across channels. Use to verify your voice rules + channel rules are loading correctly.

---

## Setup

- **Intent:** confirm Wednesday 14:00 meeting + ask for agenda
- **Recipient:** Anna Beispiel (Du-form, professional warm, German speaker)
- **User:** Chris (your fictional first name)
- **Voice rules:** banned (delve, leverage, harness, robust, seamless, em-dashes), required (German Umlaute, terse, direct)

---

## WhatsApp

**Command:** `/draft-by-channel Anna WhatsApp "Mittwoch 14h passt + bitte Agenda"`

**Output:**
```
Anna, Mittwoch 14h passt. Schick mir bitte die Agenda?
Bin gespannt auf deine zwei Punkte.
```

**Why this works:**
- 2 sentences (channel rule: max 3)
- No greeting, no sign-off (channel rule)
- Du-form (recipient memory)
- Action verb at start of each sentence

---

## Email — internal/warm

**Command:** `/draft-by-channel Anna Email-warm "Mittwoch 14h passt + bitte Agenda"`

**Output:**
```
Subject: Mittwoch 14h, ja

Hi Anna,

Mittwoch 14h passt bei mir. Kannst du mir vorab die Agenda schicken,
die zwei Themen die ich diskutieren möchte sind die Q3-Lieferung und
das Reporting-Setup für deinen Manager.

Bis Mittwoch,
Chris
```

**Why this works:**
- "Hi Anna," greeting (channel rule)
- "Chris" sign-off only, no full block (channel rule for warm)
- 3 sentences (channel rule: max 6)
- Subject line is decisive ("ja"), not ambiguous ("Re: Mittwoch")

---

## LinkedIn DM

**Command:** `/draft-by-channel Anna LinkedIn "Mittwoch 14h passt + bitte Agenda"`

**Output:**
```
Anna, Mittwoch 14h passt. Wenn du vorher die Agenda schickst, bin
ich vorbereitet. Meine zwei Themen: Q3-Lieferung und Reporting für
deinen Manager. Freue mich.
```

**Why this works:**
- 4 sentences (channel rule)
- No greeting, no sign-off (channel rule)
- Slightly more context than WhatsApp (LinkedIn carries more weight)
- Same intent, different register

---

## Slack

**Command:** `/draft-by-channel Anna Slack "Mittwoch 14h passt + bitte Agenda"`

**Output:**
```
Mi 14h passt. Agenda vorab?
```

**Why this works:**
- 2 sentences (channel rule: max 2)
- "Mi" abbreviation (Slack norm, not formal)
- Telegraphic — Slack rewards brevity

---

## What this proves

Same intent, four totally different outputs. The skill correctly:
- Applies channel rules (greeting/sign-off/length per channel)
- Maintains voice rules across all channels (banned words, terse, direct)
- Carries recipient register (Du-form) through all four
- Respects channel norms (formal level decreases from email → LinkedIn → WhatsApp → Slack)

If your skill produces the same draft regardless of channel, your channel rules aren't loading. Debug `memory/feedback_channel_rules.md` first.
