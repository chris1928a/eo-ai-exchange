# Demo 3: Personal AI Infrastructure (PAI), Fabian Gless's pick

**Pain cluster cross-reference:** Setup Itself + Tool Overload + Agents
**Status:** Released, Event #1, 2026-05-11
**Time to read:** 8 min
**Companion to:** [slides.html](slides.html) slides 16 + 17

> The third stack of the night. Where Chris shows Workspace-native and Dom shows local-first memory, Fabian shows a fully opinionated **Life Operating System** built by Daniel Miessler. 12.100 GitHub stars, MIT license, free to fork.

---

## What PAI is

**Personal AI Infrastructure** is Daniel Miessler's open-source agentic AI infrastructure designed to capture who you are, what you care about, and where you are trying to go, and then move you toward it using AI that knows you.

**Three layers stack on top of each other:**

1. **PAI** itself, the OS. Skills, memory, the Algorithm, your Telos, identity files.
2. **Pulse**, the Life Dashboard at `localhost:31337`. Where you see your state, goals, and active work.
3. **The DA** (Digital Assistant). The voice and personality you talk to.

Built for individuals first, but the same architecture works for teams, companies, or any entity that wants to articulate what it is trying to be and move toward it.

---

## v5.0.0 in numbers (verified from repo, 2026-05-11)

| Metric | Value |
|---|---|
| GitHub stars | 12.132 |
| Forks | 1.675 |
| License | MIT |
| Last updated | 2026-05-11 (active development) |
| Skills | 45 |
| Workflows | 171 |
| Hooks (event-driven triggers) | 37 |
| Algorithm version | v6.3.0 |
| Algorithm phases | 7 (Current State → Ideal State) |
| Platform support | macOS, Linux fully supported. Windows not supported. |

One-line install:
```bash
curl -sSL https://ourpai.ai/install.sh | bash
```

---

## What makes PAI different from the other two demos tonight

**vs Chris's Workspace-native setup:**
- Chris orchestrates 39 Workspace tools on top of Gmail, Calendar, Notion, Drive. PAI replaces the Workspace-native layer with its own dashboard and identity model.
- Chris's brain is private and bespoke. PAI is **open source and shared**, you fork it and inherit the conventions.
- Chris's setup costs 150 EUR/month subscriptions. PAI is free to run, you pay your compute and your model APIs.

**vs Dom's local-first memory:**
- Dom built a 5-tier memory layer from scratch with local models and zero API cost. PAI is also local-first but **comes opinionated**: 45 skills, 171 workflows, 37 hooks already shipped.
- Dom's setup is invisible to anyone but Dom. PAI ships **Pulse**, a Life Dashboard at a fixed local port, so you can actually see your own state.
- Dom optimizes for sovereignty. PAI optimizes for **completeness out of the box**.

**The trade:** opinionated framework with prebuilt opinionated skills + workflows, vs a blank slate where you decide every convention.

---

## Core PAI concepts that the audience needs to know

### Ideal State (Telos)

The biggest unsolved problem with AI is that nobody can define what "good" or "done" actually means for a given task. PAI is built around the concept of **Ideal State**, the transition from your current state to your ideal state, and it is woven through every layer.

### ISA (Ideal State Artifact)

The primary expression of Ideal State. Similar to a software PRD: it captures what done looks like so you can build toward it. The difference is that an ISA is general, it works for any creative task, from design to art to philosophy to engineering to strategy.

The system decomposes the ideal state into discrete **ISCs** (Ideal State Criteria), which populate the document and double as verification items. That is how PAI hill-climbs toward Ideal State on any kind of work.

### TRIOT (The Real Internet of Things)

Daniel Miessler's 2016 framing that PAI is built on:

- **Digital Assistants**, one DA per person, your primary interface to all AI
- **Everything gets an API**, every product, service, person, and place becomes addressable
- **Your DA dynamically creates your interfaces**, no more apps and dashboards, the DA assembles whatever you need in the moment
- **You define your ideal state, AI helps you get there**, the whole system points at your Telos

### Containment zones

Structural privacy primitive in v5. Different parts of your life live in different zones with explicit boundaries. The DA can read across zones but writes are scoped.

---

## Packs (modular extensions)

PAI ships with Packs, modular extensions you can mix and match:

- **Agents** Pack: agent personalities, custom agent templates, parallel agent spawning
- **ApertureOscillation** Pack
- **Aphorisms** Pack: database of aphorisms for tone and voice
- **Apify** Pack: scraping actors for business, ecommerce, social media, web
- **ArXiv** Pack: research paper access and summarization
- **Art** Pack: design and visual tooling with examples and tools
- Plus ~30+ more packs in the repo

The Packs system is what makes PAI extensible without forking the core.

---

## Honest struggles with PAI (what Fabian should mention live)

1. **Opinionated.** You either buy the Telos plus ISA plus DA framing, or you do not. There is no middle ground. The system is built around Miessler's worldview.
2. **Windows not supported.** Only macOS and Linux. If you are on Windows, this is not your path tonight.
3. **Pulse is another local process.** Adds a daemon to your machine that runs alongside your other tooling. Worth it for the dashboard, but worth knowing.
4. **Community-driven.** Stars are 12k but issues, PRs, and breaking changes happen. If you fork v5.0.0 today, expect v5.1 to land in 30-60 days.

> **Note on the Algorithm:** v6.3.0 is a standardized approach to any problem with different intensity levels. Works out of the box, and the code decides itself how intensively it gets applied per task. Not a learning-curve item, contrary to first impression.

---

## When you should fork PAI

**Pick PAI if:**
- You want a Life OS, not just an AI tool
- You believe AI should magnify everyone, not just the top 1%
- You like opinionated systems with prebuilt skills and workflows
- You are on macOS or Linux
- You can invest 1-2 days getting it dialed in

**Skip PAI if:**
- You want minimal scope, just a few skills
- You are on Windows
- You do not want to buy into TRIOT framing
- You prefer a blank-slate brain you fully control (Dom's path)
- You live inside Workspace and want everything there (Chris's path)

---

## Sources

- Repo: https://github.com/danielmiessler/Personal_AI_Infrastructure
- Daniel Miessler blog, *The Real Internet of Things*: https://danielmiessler.com/blog/the-real-internet-of-things
- PAI walkthrough video: https://youtu.be/Le0DLrn7ta0
- One-line install: https://ourpai.ai/install.sh
- v5.0.0 release notes: https://github.com/danielmiessler/Personal_AI_Infrastructure/blob/main/Releases/v5.0.0/README.md
- Community: https://danielmiessler.com/upgrade

---

*Companion document to slides 16-17 of [slides.html](slides.html). Speaker notes for Fabian's 10-minute demo at Event #1.*
