# Setup 3 — Fabian's Personal AI Infrastructure (PAI) Fork

> **The 30-second pitch.** Daniel Miessler's open-source PAI v5.0.0. A complete, opinionated Life OS shipped with 45 skills, 171 workflows, 37 hooks. Free to fork. macOS or Linux. The "complete out of the box" path.

**Maintained by upstream:** Daniel Miessler — [github.com/danielmiessler/Personal_AI_Infrastructure](https://github.com/danielmiessler/Personal_AI_Infrastructure) (12.100+ stars, MIT)
**EO speaker who runs this in production:** Fabian Gless, founder of [Die Tierversicherer](https://digital-verkaufen-lernen.de) (AI-enabled insurance broker)
**Pain clusters this addresses:** Setup Itself, Tool Overload, Agents, Team Adoption
**Live demo:** Demo 3 at [Event #1](../events/01-2026-05-11-setup-trap/README.md), see slides 16-17 of [slides.html](../events/01-2026-05-11-setup-trap/slides.html)
**Companion deep-dive:** [`events/01-2026-05-11-setup-trap/fabian-demo-pai.md`](../events/01-2026-05-11-setup-trap/fabian-demo-pai.md) (1200 words)

---

## Who this is for

- You want a **complete Life OS**, not a starter kit
- You are on macOS or Linux (Windows is not supported)
- You can invest 1-2 days reading and configuring before getting value
- You are comfortable buying into Daniel Miessler's worldview (Telos, ISA, TRIOT)
- You want a dashboard, not just a CLI — PAI ships with `Pulse` at `localhost:31337`

If you want a from-scratch personal setup with no opinionated framework, look at [Chris's](chris-claude-code.md) (Workspace-native) or [Dom's](dom-rolodex.md) (local-first) instead.

---

## What you get out of the box (v5.0.0)

| Component | Count |
|---|---|
| Skills | 45 |
| Workflows | 171 |
| Hooks (event-driven triggers) | 37 |
| Algorithm version | v6.3.0 |
| Algorithm phases (Current State → Ideal State) | 7 |
| Modular Packs (Agents, Aphorisms, Apify, ArXiv, Art, etc.) | 30+ |
| GitHub stars | 12.132 (as of 2026-05-11) |
| License | MIT |

**Three layers stacked:**
1. **PAI** — the OS itself: skills, memory, the Algorithm, your Telos, identity files
2. **Pulse** — a Life Dashboard at `localhost:31337` showing your state, goals, active work
3. **The DA** (Digital Assistant) — the voice and personality you talk to

---

## Cost (honest, not just "free + your API")

PAI itself is free under MIT. The "+ your API spend" disclaimer hides what most operators actually pay once it's running.

### Steady-state monthly

| Item | Real cost |
|---|---|
| PAI itself | Free, MIT |
| Cloud model API spend (PAI escalates frequently — 45 skills × 171 workflows means lots of LLM calls) | **$20-100/month** depending on usage intensity |
| Compute (your machine running Pulse + the daemon 24/7) | $0 software + electricity (~$5-15/mo) |
| Optional managed hosting | Skip unless you need it |
| **Real steady-state total** | **~$25-115/month** (not "free") |

### Up-front hardware (the hidden cost most setups quote)

| Item | Real cost |
|---|---|
| Mac M-series (recommended for running Pulse + local model + workflows smoothly) | **~3-5k EUR once** if you don't already have one |
| Linux box alternative | Whatever you already have or build |

If you already own a capable Mac, this is $0 incremental.

### Up-front time

- **30 minutes:** install + first browse to Pulse at `localhost:31337`
- **1-2 days:** define your Telos, fill in the ISA, activate first Pack — this is where most of the value compounds
- **Ongoing:** community-driven repo, expect breaking changes between versions (v5.x → v5.x+1 takes ~30-60 days)

### 3-year TCO honest comparison

| Scenario | Total |
|---|---|
| You already have a capable Mac | ~$900-4.140 over 3 years |
| You buy a Mac M-series (~$4k) | ~$4.900-8.140 over 3 years |

For comparison, [Chris's Workspace-Native](chris-claude-code.md) is ~5.4k EUR (~$5.800) over 3 years assuming you already have any laptop, and [Dom's Local-First](dom-rolodex.md) is ~$360-6.340 depending on hardware. **All three setups land in the same TCO ballpark once you account for hardware and steady-state API spend.** The real choice is about *which trade-off you prefer*: convenience (Chris), sovereignty (Dom), or out-of-box completeness (Fabian).

---

## Step-by-step to your first win

### 1. Install (literally one line)

```bash
curl -sSL https://ourpai.ai/install.sh | bash
```

This is the fastest install of the three setups in this repo. It pulls the OS, installs dependencies, and configures the dashboard.

> ⚠️ Read the install script before running it. This is a curl-pipe-bash, which is fast but trust-heavy. The script is open at [github.com/danielmiessler/Personal_AI_Infrastructure](https://github.com/danielmiessler/Personal_AI_Infrastructure). Audit it for ~5 minutes before you commit.

### 2. Open Pulse

After install, browse to [http://localhost:31337](http://localhost:31337). That is your Life Dashboard. State, goals, active work, all visible.

### 3. Define your Telos (the 30-min step that matters)

The biggest single decision in PAI is filling in your **Ideal State** — what "good" looks like for you across life and work. PAI calls this your **Telos**, expressed via an **ISA** (Ideal State Artifact).

This is closer to a coaching exercise than a config step. Plan 30-60 minutes for it. The output is the spec PAI uses to evaluate everything from "should I take this meeting" to "is this draft good enough".

PAI ships templates. Use them.

### 4. Activate your first Pack

PAI ships with 30+ Packs (modular skill bundles). Start with one that matches your work:

- **Agents Pack** — agent personalities, parallel agents
- **ArXiv Pack** — research paper ingest
- **Apify Pack** — scrape ecommerce, social, web
- **Art Pack** — design and visual tooling

Activating a pack takes one CLI command. Read the Pack README before activating, every Pack has its own opinions.

### 5. Talk to the DA

Your Digital Assistant is the conversational interface to all of the above. Default voice and personality are configurable. Once your Telos is set and a Pack is active, the DA can do meaningful work for you.

---

## What hurts (honest struggles, from Fabian's live use)

These are the four Fabian flags from the [demo companion doc](../events/01-2026-05-11-setup-trap/fabian-demo-pai.md):

1. **Opinionated framework.** You either buy the Telos + ISA + DA framing, or you do not. There is no middle ground. The system is built around Miessler's worldview.
2. **Windows not supported.** Only macOS and Linux. If you are on Windows, this is not your path.
3. **Pulse is another local process.** Adds a daemon to your machine that runs alongside your other tooling. Worth it for the dashboard, but worth knowing.
4. **Community-driven.** Stars are 12k but issues, PRs, and breaking changes happen. If you fork v5.0.0 today, expect v5.1 to land in 30-60 days. Pin a version if you cannot tolerate that.

> **Note on the Algorithm:** v6.3.0 is a standardized approach to any problem with different intensity levels. It works out of the box and the code decides itself how intensively it gets applied per task. No learning curve to flag here, contrary to first impression.

---

## When PAI is the right choice (and when it is not)

**Pick PAI if:**
- You want a Life OS, not just an AI tool
- You believe AI should magnify everyone, not just the top 1%
- You like opinionated systems with prebuilt skills and workflows
- You are on macOS or Linux
- You can invest 1-2 days getting it dialed in

**Skip PAI if:**
- You want minimal scope, just a few skills (build your own — see [Chris's setup](chris-claude-code.md))
- You are on Windows
- You do not want to buy into the TRIOT framing
- You prefer a blank-slate brain you fully control ([Dom's path](dom-rolodex.md))
- You live inside Workspace and want everything there ([Chris's path](chris-claude-code.md))

---

## Why this matters as a reference architecture

PAI is the **opinionated counterpoint** to building your own. Even if you never fork it, reading Miessler's Telos and ISA primitives sharpens how you think about your own setup:

- *What does "done" mean for any task I delegate to AI?*
- *What is my Ideal State, and how does today's work move me toward it?*
- *Where is my single source of identity that AI should respect?*

These questions are useful regardless of which setup you adopt.

---

## Sources and where to read more

- **Upstream repo:** [github.com/danielmiessler/Personal_AI_Infrastructure](https://github.com/danielmiessler/Personal_AI_Infrastructure)
- **One-line install script:** [ourpai.ai/install.sh](https://ourpai.ai/install.sh) (audit before running)
- **TRIOT essay (the philosophical foundation):** [danielmiessler.com/blog/the-real-internet-of-things](https://danielmiessler.com/blog/the-real-internet-of-things)
- **PAI walkthrough video:** [youtu.be/Le0DLrn7ta0](https://youtu.be/Le0DLrn7ta0)
- **v5.0.0 release notes:** [github.com/.../Releases/v5.0.0/README.md](https://github.com/danielmiessler/Personal_AI_Infrastructure/blob/main/Releases/v5.0.0/README.md)
- **Companion talk doc:** [`events/01-2026-05-11-setup-trap/fabian-demo-pai.md`](../events/01-2026-05-11-setup-trap/fabian-demo-pai.md)

---

*If you fork PAI and hit something the upstream README doesn't cover, [open an issue here](https://github.com/chris1928a/eo-ai-exchange/issues) — Fabian or another community member who runs PAI may answer.*
