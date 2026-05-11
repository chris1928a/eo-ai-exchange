# EO AI Productivity Exchange

> **The Open-Source AI Productivity Series for EO Operators.**
> Your Pain → Our Skill → Continuous.

A continuous, audience-driven series where EO members surface real AI-setup pains, and the community ships verified solutions. Hosted by [Christoph Erler](https://erlerventures.org), Dominik Raute (CTO JustWatch), and Fabian Gless, EO Berlin.

---

## What this repo is

A living solution-pipeline for the AI-productivity pains that founders and operators actually face. Every event ends with a `git push`, not just „thanks for listening". Every audience pain becomes either a documented solution, a working skill, or both.

**Three pillars:**
1. **Audience-driven curriculum.** Pains come from registration data and live Slido, not speaker egos.
2. **Open-source solutions.** Every challenge gets a skill / template / playbook here.
3. **Continuous cadence.** 30-90 days between events, depending on market velocity and community demand.

---

## What shipped at Event #1 (2026-05-11)

11 in-depth solutions covering all 10 pain clusters identified from **118 audience registrations across 53 EO chapters and 4 continents**. See [SOLUTIONS.md](SOLUTIONS.md) for the full index and [AUDIENCE-ANALYSIS](events/01-2026-05-11-setup-trap/AUDIENCE-ANALYSIS.md) for the verified pain breakdown.

### Live decks

- **Joint deck** &middot; [chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html) (22 slides)
- **Chris's deep dive** &middot; [chris-demo.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides)
- **Q&A backup** &middot; [qa-deck.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/qa-deck.html) (15 slides, all 12 Slido questions with sources)

### Solution highlights

- [Setup Trap Diagnostic, 1-pager](solutions/setup-itself/setup-trap-diagnostic.md) &middot; the 3 questions to escape the trap
- [30-Min aiOS Blueprint](solutions/setup-itself/30-min-aios-blueprint.md) &middot; zero to working setup in 30 min
- [OpenClaw Honest Assessment](solutions/openclaw-honest/openclaw-honest-assessment.md) &middot; incl. CVE-2026-25253 + 5 alternatives
- [GDPR Claude Checklist DACH](solutions/security-gdpr/gdpr-claude-checklist-dach.md) &middot; incl. EU AI Act August 2026 deadline
- [MCP Cookbook](solutions/integration-mcp/mcp-cookbook.md) &middot; 10 essential MCP servers for founders
- [Team Rollout Playbook](solutions/team-adoption/team-rollout-playbook.md) &middot; 90-day plan with BBVA case study
- Plus 5 more, one per pain cluster, in [`solutions/`](solutions/)

---

## Referenced architectures

External open-source patterns we recommend forking, reading, or learning from.

### Daniel Miessler &middot; Personal AI Infrastructure (PAI)

[github.com/danielmiessler/Personal_AI_Infrastructure](https://github.com/danielmiessler/Personal_AI_Infrastructure) &middot; MIT &middot; 12.100+ stars

A Life Operating System for AI. PAI captures who you are, what you care about, and where you are trying to go, and then helps you move toward it. Three layers:

- **PAI** itself, the OS (skills, memory, the Algorithm, your Telos, identity files)
- **Pulse**, the Life Dashboard at `localhost:31337`
- **The DA** (Digital Assistant), the voice you talk to

v5.0.0 ships **45 skills, 171 workflows, 37 hooks**, Algorithm v6.3.0 (Current State → Ideal State across seven phases), the **ISA** primitive (universal "ideal state" articulation), and structural privacy via containment zones. macOS and Linux supported (Windows not yet). One-line install: `curl -sSL https://ourpai.ai/install.sh | bash`.

**Why we reference it:** PAI is the opinionated counterpoint to Chris's workspace-native setup and Dom's local-first memory. It is featured as **Demo 3 at Event #1**, presented by Fabian Gless. Companion deep dive: [events/01-2026-05-11-setup-trap/fabian-demo-pai.md](events/01-2026-05-11-setup-trap/fabian-demo-pai.md).

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
│       ├── README.md            ← event-specific intro
│       ├── slides.html          ← joint deck for the live event (22 slides)
│       ├── chris-demo.html      ← Chris's solo deep dive (44 slides)
│       ├── qa-deck.html         ← Q&A backup deck (15 slides)
│       ├── fabian-demo-pai.md   ← PAI demo companion (1200 words)
│       ├── QA-CHEATSHEET.md     ← panel cheatsheet, plain Markdown
│       └── AUDIENCE-ANALYSIS.md ← anonymized pain breakdown, 118 registrants
│
├── solutions/                   ← solutions grouped by pain cluster (10 clusters)
│   ├── tool-overload/           ← Tool Overload Diagnostic
│   ├── setup-itself/            ← Setup Trap Diagnostic + 30-Min aiOS Blueprint
│   ├── agents/                  ← Agent Reliability Checklist
│   ├── team-adoption/           ← Team Rollout Playbook (90-day)
│   ├── integration-mcp/         ← MCP Cookbook (10 essential servers)
│   ├── openclaw-honest/         ← OpenClaw Honest Assessment (incl CVE)
│   ├── industry-healthcare/     ← Healthcare Scheduling Stack
│   ├── security-gdpr/           ← GDPR Claude Checklist DACH
│   ├── pace-keeping-up/         ← Weekly AI Filter
│   └── time-learning/           ← 60-Day Founder Onboarding
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

- **Christoph Erler** (EO Berlin), former co-founder & COO of [ComX](https://practicalfounders.com/podcast/bootstrappers-sold-modern-digital-leadgen-conservative-german-businesses-chris-erler/) ($20M ARR, sold to Flex Capital). Founder of [Erler Ventures](https://erlerventures.org).
- **Dominik Raute** (EO Berlin), CTO of JustWatch.
- **Fabian Gless** (EO Berlin), operator and Personal AI Infrastructure (PAI) advocate.

---

## License

All solutions in this repo are released under MIT License. Use, modify, share. Attribution appreciated, not required.

---

*Last updated: 2026-05-11 (Event #1 shipped, 11 solutions live, 118 registrations across 53 EO chapters).*
