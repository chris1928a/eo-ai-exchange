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

Before any meeting, generate a 1-page brief on who you are about to talk to: who they are, the last 5 things you said to each other, open threads, decision style, any flagged sensitivities. Output is a single screen, never longer, never shorter.

The pattern is: **resolve identity → pull cross-channel history → score recency + relevance → output fixed-shape dossier → write back to memory**. Reusable for any "who is X and where do we stand" use case.

---

## Inputs

1. **Person identifier**, name, email, or "the guy from [company]" (skill resolves to a person)
2. **Email history**, last 90 days via Gmail MCP, threaded
3. **Calendar history**, last 12 months of meetings with this person via Calendar MCP
4. **Memory file**, `~/.claude/projects/<project>/memory/people/{slug}.md` if you have one (auto-created on first use)
5. **Linked sources**, Notion / CRM / WhatsApp transcripts if MCPs are connected
6. **Voice rules**, for tone of the dossier itself

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

Total length: under 400 words. Fits on one screen. Posted to Telegram or shown inline in Claude Code.

---

## Worked example, meeting prep, second meeting with a partner

**Input:** `/diarize-person Anna Beispiel` (a real partner you've met once before)

**What Claude pulls (anonymized):**
- Email history: 8 emails over 60 days, last 14 days ago, thread about Q3 partnership
- Calendar: 1 prior meeting (4 weeks ago, 60min)
- Memory file: exists, written after the first meeting
- WhatsApp: 3 messages, last 2 days ago confirming today's slot

**Output dossier:**

```markdown
# Anna Beispiel · Head of Partnerships @ ExampleCorp

## Who they are
Head of Partnerships at ExampleCorp (B2B SaaS, Series-B, ~80 employees).
Cares about retention metrics + clean integration stories. Avoids
multi-vendor messes. Got burned by a previous partner who over-promised.

## Last 5 interactions (newest first)
1. 2026-05-12 WhatsApp, confirmed today 14:00, asked for 1-pager pre-read
2. 2026-04-28 Email, sent Q3 partnership outline, no response yet
3. 2026-04-21 Email, recapped first meeting, suggested next steps
4. 2026-04-15 Calendar, first 60min meeting, at her office
5. 2026-04-01 Email, initial intro from common contact

## Open threads
- Q3 partnership outline: your move (she expects answer to integration timing)
- 1-pager pre-read for today: your move (promised by 13:00)
- Reference call with their CTO: their move (waiting on her to schedule)

## Communication style
- Channel preference: Email primary, WhatsApp for confirmations
- Tone: Sie-Form, professional but warm, German-speaking
- Decision style: analytical, wants data + references before signing
- Sensitivities: avoid bringing up the previous partner who burned them

## Open questions for this meeting
1. Did she review the Q3 partnership outline?
2. Who else internally needs to bless the integration timing?
3. Realistic decision timeline, Q3 sign or push to Q4?

## Last-touch context
"Bis morgen 14h, freue mich. Schick mir bitte ein 1-pager-Vorab, dann
bin ich vorbereitet.", Anna, WhatsApp 2 days ago
```

That's the shape. Decision-actionable in 30 seconds before the meeting.

---

## Non-negotiable rules

- **One page. Always.** If it would not print on one A4, cut.
- **Newest first.** No history-from-the-beginning narratives.
- **Open threads need an owner.** Each one tagged "your move" or "their move".
- **Decision style requires evidence.** Don't guess "analytical", cite a specific email where they showed it.
- **Sensitivities require evidence.** Don't fabricate emotional context, only what they flagged or showed.
- **No AI-fluff.** Avoid: delve, leverage, harness, robust, seamless, em-dashes.

---

## The actual prompt under the hood

```
SYSTEM: Generate a 1-page stakeholder dossier on {person_name} for {user_name}.

CONTEXT (from memory):
- About me: {user_about_md_contents}
- Voice rules: {feedback_voice_md_contents}
- Existing memory file for this person (if any): {people_slug_md_contents OR "none, first dossier"}

LIVE DATA (from MCP):
- Gmail threads with this person, last 90 days: {email_data}
- Calendar history with this person, last 12 months: {calendar_data}
- WhatsApp messages (if WhatsApp MCP connected): {whatsapp_data OR "not available"}
- Notion mentions (if Notion MCP connected): {notion_data OR "not available"}

OUTPUT STRUCTURE (mandatory, do not change):
# {Name} · {Role @ Company}
## Who they are (2-3 sentences)
## Last 5 interactions (newest first, dated)
## Open threads (your move | their move tagged)
## Communication style (channel, tone, decision style, sensitivities)
## Open questions for this meeting (3 max)
## Last-touch context (exact verbatim quote of last message)

RULES:
1. Total length under 400 words.
2. Decision style and sensitivities MUST cite evidence from the data, no guessing.
3. Open threads MUST have ownership tag (your move / their move).
4. If first dossier (no memory file): skip the "Open questions" section, instead add "First-touch notes" with what to learn.
5. Apply voice rules strictly.

SIDE EFFECT (after generating output):
- Append today's interaction to memory/people/{slug}.md
- Update the "open threads" line in the same file
- If new sensitivities emerged, add them to the file with date
```

Full template at [`prompts/diarize-prompt.md`](prompts/diarize-prompt.md).

---

## Setup (10 minutes)

1. Drop this file at `~/.claude/skills/diarize-person/SKILL.md`
2. Copy the prompt template alongside
3. Make sure Gmail + Calendar MCPs are connected
4. Create the directory: `~/.claude/projects/<project>/memory/people/`
5. (Optional) Connect WhatsApp / Notion / CRM MCPs if you use them
6. Test: `/diarize-person {name of someone you have email + calendar history with}`
7. Verify: a `memory/people/{slug}.md` file got created
8. Run a SECOND time with the same person, verify the file got appended, not overwritten

---

## How memory persists

After each invocation, the skill writes back to `memory/people/{slug}.md`:
- Today's interaction summary appended (newest first)
- Updated "open threads" with current ownership
- Any new sensitivities you flagged in chat ("don't bring up the M&A topic" → adds to sensitivities list)
- Decision-style observations refined as more interactions accumulate

So the dossier gets richer with every meeting, automatically.

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~3.000-8.000 (depends on email volume) |
| Model | Claude Sonnet 4.6 (Opus only if you need deeper inference on sparse data) |
| Cost per invocation | **~$0.05-0.15** |
| Latency | 5-12 seconds (mostly waiting on Gmail thread fetches) |
| Monthly cost (4 calls/day = ~80 dossiers/mo) | **~$4-12** |

If you have 200+ dossiers per month, switch to caching: the static parts of the prompt (voice rules, user_about) get cached, dropping cost ~40%.

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/diarize-company` | Aggregates dossiers across all people at one company | Pre-board meeting, multi-stakeholder accounts |
| `/diarize-deal` | Pulls a CRM deal record + all linked people + Slack thread | Pre-renewal call, complex sales |
| `/diarize-thread` | One-email-thread deep dive instead of full person history | Long-running negotiation thread |
| `/diarize-team` | Internal team dossier (ICs, last 1-1, current goals) | Pre-1-1 prep |
| `/diarize-investor` | Pulls cap table + investor updates + last sync notes | Pre-board meeting with VC |

Same pattern (resolve → pull cross-source → score → fixed-shape output → write back), different scope of identity.

---

## Common modifications

**1. Add a 4th field "Risk" or "Opportunity" assessment.** Append to the prompt: "After the dossier, add a 'Risk' line and 'Opportunity' line with one sentence each." Useful for sales contexts.

**2. Multi-language dossiers.** Add `language: de` to the SKILL.md frontmatter, OR add per-person language to memory file. Skill produces German dossier for German-speaking contacts.

**3. Sensitivity blacklist.** If your dossier ever needs to skip topics (e.g. legal, M&A), add a `sensitivities_global.md` memory file. The prompt picks it up.

**4. Output to Notion.** Instead of stdout, push the dossier to a "People" Notion database. Use the Notion MCP. Useful for shared visibility with assistants.

**5. Auto-trigger on calendar event.** Wire a calendar webhook → 1 hour before any meeting, the skill fires automatically and posts the dossier to Telegram. Pre-meeting prep without you remembering.

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1-2 | Run `/diarize-person` manually before 3-5 meetings. Compare to your normal prep. |
| 3-7 | Use it before every meeting, but keep your manual notes as a backup. |
| 8-14 | Drop the manual notes. Trust the dossier as primary prep. |
| 15-21 | Wire the calendar auto-trigger so dossiers fire 1 hour before meetings. |
| 22+ | Audit weekly: which dossiers were wrong? Add the missing context to person memory files. |

---

## What this won't do (failure modes)

- **Will not catch context outside your wired-up MCP servers.** If you discussed the topic on a phone call with no transcript, the dossier won't know.
- **Will not understand company politics from email tone alone.** If a stakeholder is being undermined by an internal rival, the dossier may not surface that, you have to flag it manually in the memory file.
- **Will hallucinate sensitivities if you don't anchor with evidence.** That's why the rule is "must cite a specific email." Without that, it makes things up.
- **Will not handle aliases automatically.** If someone shows up as "Anna B." in WhatsApp and "Anna Beispiel" in Gmail, the skill may produce two dossiers. Add an aliases line to the memory file.
- **Will silently degrade if the email retention window is too short.** Default is 90 days. For long-running relationships, increase to 180 or 365.

---

## When to delete this skill

If you find yourself bypassing the dossier and going to email directly, **delete it**. Reasons it might not work for you:
- Your meetings are mostly with strangers (no history to pull)
- You meet the same 5 people every day (you don't need a dossier, you need a relationship)
- Your inbox isn't your primary channel (the dossier misses 80% of your interactions)

---

## Why this is universal

Every operator has stakeholders. Every meeting needs prep. The pattern (pull cross-channel history on a person → output fixed-shape brief → write back to memory) reduces context-switching cost and prevents the "wait, what did we last decide?" moment that wastes the first 5 minutes of every second meeting.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Part of Chris's 5.7h/week meeting-prep saving.*
