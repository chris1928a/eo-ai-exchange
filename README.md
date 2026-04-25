# EO AI Productivity Exchange

> **The Open-Source AI Productivity Series for EO Operators.**
> Your Pain → Our Skill → 30-90 Days → Repeat.

A continuous, audience-driven series where EO members surface real AI-setup pains, and the community ships verified solutions every 30-90 days. Hosted by [Christoph Erler](https://erlerventures.org) and Dominik Raute (CTO JustWatch), EO Berlin.

---

## What this repo is

A living solution-pipeline for the AI-productivity pains that founders and operators actually face. Every event ends with a `git push`, not just „thanks for listening". Every audience pain becomes either a documented solution, a working skill, or both.

**Three pillars:**
1. **Audience-driven curriculum.** Pains come from Slido + registration data, not speaker egos.
2. **Open-source solutions.** Every challenge gets a skill / template / playbook here.
3. **Cadence-flexible.** 30-90 days between events, depending on market velocity.

---

## Repository structure

```
eo-ai-exchange/
├── README.md                    ← you are here
├── SOLUTIONS.md                 ← master index of all solutions, by pain cluster
├── CONTRIBUTING.md              ← how to PR your own skill or solution
│
├── events/                      ← one folder per event
│   └── 01-2026-05-11-setup-trap/
│
├── solutions/                   ← solutions grouped by pain cluster
│   ├── tool-overload/
│   ├── setup-itself/
│   ├── agents/
│   ├── team-adoption/
│   ├── integration-mcp/
│   ├── openclaw-honest/
│   ├── industry-healthcare/
│   ├── security-gdpr/
│   ├── pace-keeping-up/
│   └── time-learning/
│
├── skills/                      ← runnable Claude Code skills
│   └── (audience-driven, will grow)
│
└── speakers/                    ← speaker pipeline + alumni
```

---

## Cadence logic

Events fire on triggers, not on a calendar:

| Trigger | Frequency | Format |
|---|---|---|
| Major model release (new Claude / GPT / Gemini) | Within 30 days | Format A: „What changed?" |
| Major tool / MCP standard shift | Within 30 days | Format B: „What do we build with this?" |
| Audience pain cluster maturing (10+ Slido submissions on a new topic) | Within 60 days | Format C: „Industry / Vertical Spotlight" |
| Default cadence (no trigger) | Every 90 days | Format D: „Solution Review + new cycle" |

Hosts check triggers on the 1st of each month. If a trigger fires, an event is announced for the following 30 days.

---

## Event format types

- **Format A, Model Release Response (30 min):** New model released, what changed, 1 live skill update, 5 min Q&A.
- **Format B, Tool / MCP Build (60 min):** New standard, hosts show setup, audience pain collection, Q&A.
- **Format C, Industry Spotlight (60 min):** One vertical (Healthcare, Real Estate, Sales, Manufacturing), speaker from community, vertical-specific build.
- **Format D, Solution Review + New Cycle (90 min):** Status report, impact metrics, audience pain re-collection for next cycle, speaker hand-raise.

---

## Roadmap (next 12 months)

| # | Date | Format | Theme |
|---|---|---|---|
| #1 | 2026-05-11 | B (launch) | Setup Trap + Tool Overload Foundations |
| #2 | ~Mid-June 2026 | TBD | Likely „Agents in Production" or first Industry Spotlight |
| #3 | ~Mid-July 2026 | A | Likely Claude Sonnet 4.7 release migration |
| #4 | ~Mid-August 2026 | C | Industry Spotlight (Healthcare or Sales) |
| #5 | ~Mid-October 2026 | D | 90-day Solution Review |
| #6 | ~End-November 2026 | B | TBD |
| #7 | ~January 2027 | D | Year-1 Wrap |

---

## How to contribute

Three ways to contribute:

1. **Submit a pain.** Open an issue tagged `pain` describing what you are stuck on. We aggregate these for the next event.
2. **Submit a solution.** Open a PR with a markdown file or a runnable skill in the appropriate folder. See `CONTRIBUTING.md` for format.
3. **Apply to speak.** Fill the speaker application: [link to Tally form, populated after Event #1].

All contributors are credited in `speakers/alumni/`.

---

## Chatham House Rule

All event content is shared under Chatham House Rule: share the information, not the attribution. This applies to the GitHub repo too: if you reference a discussion from an event, do not cite specific speakers without their explicit permission.

---

## Hosts

- **Christoph Erler** (EO Berlin), former co-founder & COO of [ComX](https://practicalfounders.com/podcast/bootstrappers-sold-modern-digital-leadgen-conservative-german-businesses-chris-erler/) ($20M ARR, sold to Flex Capital). Founder of [Erler Ventures](https://erlerventures.org), building Best Guy.
- **Dominik Raute** (EO Berlin), CTO of JustWatch.

---

## License

All solutions in this repo are released under MIT License. Use, modify, share. Attribution appreciated, not required.

---

*Last updated: 2026-05-11 (after Event #1). Next event: TBD per cadence logic.*
