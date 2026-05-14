---
name: diarize-person
type: universal
load_when: diarize, dossier, prep for meeting, meeting prep, who is, brief me on
---

# /diarize-person

> **Universal skill from Event #1, Demo 1 (Chris).**
> 1-page stakeholder dossier with full interaction history. Use before every meeting. Part of the ~5.7h/week meeting-prep saving in Chris's setup.

---

## Purpose

Before any meeting, generate a 1-page brief on who you are about to talk to: who they are, the last 5 things you said to each other, open threads, decision style, any flagged sensitivities. Output is a single screen — never longer, never shorter.

---

## Inputs

1. **Person identifier** — name, email, or "the guy from [company]" (skill resolves to a person)
2. **Email history** — last 90 days via Gmail MCP, threaded
3. **Calendar history** — last 12 months of meetings with this person via Calendar MCP
4. **Memory file** — `~/.claude/projects/<project>/memory/people/{slug}.md` if you have one (auto-created on first use)
5. **Linked sources** — Notion / CRM / WhatsApp transcripts if MCPs are connected
6. **Voice rules** — for tone of the dossier itself

---

## Outputs

A 1-page Markdown dossier in this fixed structure:

```markdown
# {Name} · {Role @ Company}

## Who they are
[2-3 sentences: role, what they care about, what they avoid]

## Last 5 interactions (newest first)
1. [Date] [Channel] [1-line summary, with decision/promise]
2. ...

## Open threads (your move | their move)
- [Thread, who is on the hook]

## Communication style
- Channel preference: [WhatsApp / Email / Phone]
- Tone: [Du / Sie, formal / casual]
- Decision style: [analytical / gut / committee]
- Sensitivities: [topics to handle carefully]

## Open questions for this meeting
1. ...
2. ...

## Last-touch context
[The exact phrasing of the last message, so you can pick up the thread mid-sentence]
```

---

## Non-negotiable rules

- **One page. Always.** If it would not print on one A4, cut.
- **Newest first.** No history-from-the-beginning narratives.
- **Open threads need an owner.** Each one tagged "your move" or "their move".
- **Decision style requires evidence.** Don't guess "analytical" — cite a specific email where they showed it.
- **Sensitivities require evidence.** Don't fabricate emotional context — only what they flagged or showed.
- **No AI-fluff.** Avoid: delve, leverage, harness, robust, seamless, em-dashes.

---

## Setup (10 minutes)

1. Drop this file at `~/.claude/skills/diarize-person/SKILL.md`
2. Make sure Gmail + Calendar MCPs are connected
3. Create the directory: `~/.claude/projects/<project>/memory/people/`
4. (Optional) Connect WhatsApp / CRM MCPs if you use them
5. Test: `/diarize-person Sandra Müller`

---

## How memory persists

After each invocation, the skill writes back to `memory/people/{slug}.md` with:
- Today's interaction summary appended
- Updated "open threads"
- Any new sensitivities you flagged in chat ("don't bring up the M&A topic")

So the dossier gets richer with every meeting, automatically.

---

## Honest caveats

- **First-time dossier on a new person is shallow** (no memory file yet). Plan to manually flag context after the first meeting.
- **Email-only contacts have richer dossiers than phone/in-person contacts.** If you do a lot of in-person work, log meetings to a memory file via `/memory-curator` to compensate.
- **GDPR considerations** for storing personal interaction history — see [`solutions/security-gdpr/gdpr-claude-checklist-dach.md`](../../solutions/security-gdpr/gdpr-claude-checklist-dach.md).

---

## Why this is universal

Every operator has stakeholders. Every meeting needs prep. The pattern (pull cross-channel history on a person → output fixed-shape brief → write back to memory) reduces context-switching cost and prevents the "wait, what did we last decide?" moment.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Part of Chris's 5.7h/week meeting-prep saving.*
