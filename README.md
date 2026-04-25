# EO AI Productivity Exchange

> **The Open-Source AI Productivity Series for EO Operators.**
> Your Pain → Our Skill → Continuous.

A continuous, audience-driven series where EO members surface real AI-setup pains, and the community ships verified solutions. Hosted by [Christoph Erler](https://erlerventures.org) and Dominik Raute (CTO JustWatch), EO Berlin.

---

## What this repo is

A living solution-pipeline for the AI-productivity pains that founders and operators actually face. Every event ends with a `git push`, not just „thanks for listening". Every audience pain becomes either a documented solution, a working skill, or both.

**Three pillars:**
1. **Audience-driven curriculum.** Pains come from registration data and live Slido, not speaker egos.
2. **Open-source solutions.** Every challenge gets a skill / template / playbook here.
3. **Continuous cadence.** 30-90 days between events, depending on market velocity and community demand.

---

## What shipped at Event #1 (2026-05-11)

11 in-depth solutions covering all 10 pain clusters identified from the 85 audience registrations. See [SOLUTIONS.md](SOLUTIONS.md) for the full index.

Highlights:
- [Setup Trap Diagnostic, 1-pager](solutions/setup-itself/setup-trap-diagnostic.md), the 3 questions to escape the trap
- [30-Min aiOS Blueprint](solutions/setup-itself/30-min-aios-blueprint.md), zero to working setup in 30 min
- [OpenClaw Honest Assessment](solutions/openclaw-honest/openclaw-honest-assessment.md), incl. CVE-2026-25253 + 5 alternatives
- [GDPR Claude Checklist DACH](solutions/security-gdpr/gdpr-claude-checklist-dach.md), incl. EU AI Act August 2026 deadline
- [MCP Cookbook](solutions/integration-mcp/mcp-cookbook.md), 10 essential MCP servers for founders
- Plus 6 more, one per pain cluster

Event #1 deck: [HTML slides](events/01-2026-05-11-setup-trap/slides.html) (Erler Ventures branding, click or arrow keys to navigate).

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
│       ├── README.md
│       └── slides.html          ← live HTML deck
│
├── solutions/                   ← solutions grouped by pain cluster (10 clusters)
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
├── skills/                      ← runnable Claude Code skills (community contributions)
│
└── speakers/                    ← speaker pipeline + alumni
```

---

## Cadence philosophy

**Cadence over Quarterly. Solutions over Slides.**

Events fire on triggers, not on a calendar:
- Major model release → next event in 30 days, focused on what changed
- Major tool / MCP standard shift → next event in 30 days, focused on what to build
- Audience pain cluster maturing (10+ submissions on a new topic) → next event in 60 days, industry/vertical spotlight
- Default cadence (no trigger) → every 90 days, solution review + new cycle

Hosts check triggers monthly. The next event is announced when there is something genuinely worth meeting for.

---

## How to contribute

Three ways to contribute:

1. **Submit a pain.** Open an issue tagged `pain` describing what you are stuck on. We aggregate these for the next event.
2. **Submit a solution.** Open a PR with a markdown file or a runnable skill in the appropriate folder. See [CONTRIBUTING.md](CONTRIBUTING.md) for format.
3. **Apply to speak at the next event.** See [speakers/README.md](speakers/README.md).

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

*Last updated: 2026-05-11 (Event #1 shipped, 11 solutions live).*
