# Setup 1 — Chris's Workspace-Native Claude Code

> **The 30-second pitch.** [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) wired into Google Workspace via 31 MCP servers (~39 total Workspace adapters), 19 reusable Skills, 125 memory files, 7 cron jobs, and a Telegram bot for mobile. ~150 EUR/month all-in. ~23 hours per week saved on a tracked sample. Replaces ~1.5 FTE that would have cost 80-110k EUR/year — a 45-60x cost ratio.

**Maintained by:** Christoph Erler ([erlerventures.org](https://erlerventures.org))
**Companion deck:** [chris-demo.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides, body-mapped tool snapshots)
**Pain clusters this addresses:** Setup Itself, Tool Overload, Integration, Pace
**Live demo:** Demo 1 at [Event #1](../events/01-2026-05-11-setup-trap/README.md), see slides 1-11 of [`slides.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html)
**Cost:** ~150 EUR/mo all-in
**License of this spec:** MIT

---

## Origin — the bet behind the architecture

*"After ComX, I had the option to hire and rebuild what I already knew. Instead I bet that **AI as infrastructure can replace the team I would have hired**. Three years later, that bet is still the strategy."*

Three founding rules:
1. **Every workflow I touch becomes a skill.**
2. **Every meeting I have becomes a memory.**
3. **Every recurring task lands on a cron.**

**Result:** zero employees. A brain that is version-controlled and queryable. Runs at ~150 EUR/month. Replaces ~1.5 FTE.

---

## Who this is for

- You live inside Google Workspace (Gmail, Calendar, Drive, Docs, Sheets, Meet)
- You operate across multiple domains (advisory, real estate, ventures, content, etc.) and need one brain that understands all of them
- You want AI everywhere — including on mobile — not just at your desk
- You are fine paying ~150 EUR/month for the convenience
- You are willing to invest 30-60 hours up-front to get the foundation right
- You want to *own* the setup and iterate on it for years, not buy a SaaS

If you want a complete opinionated Life OS out of the box, see [Fabian's PAI setup](fabian-personal-ai.md).
If you want zero ongoing cost and full sovereignty, see Dom's local-first path — full doc refreshing, [slides 13-15](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13) cover the architecture.

---

## What you get out of the box

### The 4-Layer Brain Architecture

This is the core mental model. Each layer has a clear job and lives in a specific place.

| Layer | Job | Where it lives |
|---|---|---|
| **1. Long-term Memory** | Everything retained, version-controlled, source of truth | GitHub (code/skills), Notion (shared prose), Google Drive (originals) |
| **2. Short-term Memory** | Loaded on-demand per task, routed by context | 125 `.md` files in `~/.claude/projects/erler-brain/memory/` (mirrored to GitHub), routed by a ~50-line `CLAUDE.md` |
| **3. Working Memory** | Active reasoning, where Claude actually thinks | [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) on AWS Lightsail Frankfurt (EU residency, audit-logged, read-only by default) |
| **4. Body** | Execution, the tools the brain can touch | Telegram bot (mobile), 31 MCP servers (~39 Workspace adapters incl. Computer-Use / Chrome / Telegram), 7 cron jobs (daily / weekly / monthly) |

### The numbers

| Component | Count |
|---|---|
| MCP servers wired in | 31 |
| Total Workspace adapters (incl. Computer-Use, Chrome, Telegram) | ~39 |
| Skills | 19 |
| Memory files | 125 (`.md`, ~1-page profiles each) |
| Cron jobs | 7 (daily / weekly / monthly) |
| Search backend | `ripgrep` + glob — **no vector DB** (threshold is ~10k files; this brain is at ~200) |
| Mobile | Telegram bot on AWS Lightsail Frankfurt (~20 EUR/mo VM) |
| EU residency | Yes — all reasoning happens on AWS Frankfurt |
| Hours saved per week (8-week tracked sample) | ~23h |
| Total monthly cost | ~150 EUR all-in |

### Memory file structure (the 125 files, by category)

| Category | Files | Examples |
|---|---|---|
| Schreibregeln (voice rules) | 12 | tone-by-channel, written-vs-spoken style |
| Brain Architecture | 5 | conventions, routing, audit cadence |
| Real Estate | 15 | properties, pricing rules, partner contacts |
| Aviation | 10 | aircraft specs, maintenance cadence, dispatch |
| Erler Ventures | 8 | thesis, pipeline, advisory engagements |
| Personal & Family | 8 | calendar rules, family ops, domestic ops |
| Content & Sales | 10 | content pillars, ICP, sales cadence |
| Diverses | 7 | catch-all |

Each file: 1 page max, frontmatter (`name`, `description`, `type` ∈ {reference, project, feedback, user}, `originSessionId`).

---

## Cost — the honest breakdown

| Item | Cost |
|---|---|
| Claude Pro subscription | ~20 EUR/mo |
| AWS Lightsail Frankfurt VM (Telegram bot + Claude Code daemon) | ~20 EUR/mo |
| Misc API spend across MCP servers (Holidu, Close, etc.) | ~110 EUR/mo |
| **Total** | **~150 EUR/mo** |

**The comparison:**

| What this replaces | Cost/year |
|---|---|
| 0.5 EA + 0.5 Junior Analyst + 0.5 Content Manager (~1.5 FTE in DACH) | 80-110k EUR/yr |
| This setup | ~1.8k EUR/yr |
| **Cost ratio** | **~45-60x cheaper** |

Hidden costs the table does not show: ~200h setup time up-front (4-5 month payback), and ~2h/month maintenance tax. Real, not zero.

---

## The 8 forkable skills shown at Event #1

> The 8 skills below were demoed live. **Five are universal** for any operator. **Three are domain examples** — the structure is forkable, the specifics need to be adapted to your vertical.

### Universal (fork as-is, just edit personal data)

| Skill | What it does | Tracked time saved |
|---|---|---|
| `/morning-brief` | Daily 7am brief on inbox + calendar + open threads, posted to Telegram | 2.25h/week |
| `/diarize-person` | Generates a 1-page stakeholder dossier with full interaction history before any meeting | included in 5.7h meeting prep |
| `/draft-by-channel` | Voice-locked drafts per person + channel (WhatsApp ≠ email tone, no leakage) | 2.7h/week |
| `/weekly-review` | Friday 17:00 cron across all "hats" / domains | 1.3h/week (90 min → 10 min) |
| `/memory-curator` | Weekly memory hygiene — what stays in chat vs lands in durable storage | maintenance, prevents drift |

### Domain examples (show the pattern, adapt to your own vertical)

| Skill | What it does | Pattern to copy |
|---|---|---|
| `/audit-process` | Internal process diagnostic, ranks fixes on Impact-Effort matrix | "Diagnostic + scoring" pattern for any consulting / advisory work |
| `/sales-script-rewriter` | Scores sales call transcripts on 6 dimensions (talk ratio, monologue length, objection handling, etc.); used live with the sales floor | "Transcript-in, scored-recommendation-out" pattern |
| `/property-pricing` | Daily revenue management cron via Holidu API at 06:00, sets prices for short-term rental units | "API-in, decision-out, daily cron" pattern for any daily-priced asset |

> **Status:** files are documented in this setup spec but the skill files themselves still need to be committed to [`/skills/`](../skills/). [Open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) if you want one of them prioritized.

---

## What you need installed

| Tool | Why | Cost |
|---|---|---|
| [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) | The CLI that runs the whole thing | Free |
| Claude Pro or API access | The model | ~20 EUR/mo (Pro) or pay-per-token (API) |
| Google Workspace account | The data layer | What you already pay |
| A Mac, Linux box, or Windows + WSL | Where Claude Code runs | Hardware you have |
| (Optional) AWS Lightsail Frankfurt VM | For Telegram bot + always-on cron jobs + EU residency | ~20 EUR/mo |
| (Optional) [Deepgram](https://deepgram.com) for transcription | Voice-to-Markdown notes from calls (Fathom / Granola integration) | Pay-per-minute |
| (Optional) Holidu / Close / domain-specific APIs | Whatever your vertical needs | Varies |

---

## Step-by-step to your first win (60 minutes)

### 1. Install Claude Code

```bash
# Mac / Linux
curl -fsSL https://claude.ai/install.sh | bash

# Windows: install WSL first, then run the same command inside WSL
```

Verify: `claude --version`. Reference: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview).

### 2. Write your first memory files

Create the directory + the index:

```bash
mkdir -p ~/.claude/projects/<your-project>/memory/
```

Create `~/.claude/projects/<your-project>/memory/MEMORY.md`:

```markdown
- [About me](user_about.md) — name, role, what I'm working on this quarter
- [Voice rules](feedback_voice.md) — tone, things I never want AI to say
```

Create `~/.claude/projects/<your-project>/memory/user_about.md`:

```markdown
---
name: About me
description: Who I am and what I'm working on right now
type: user
---

I am [name]. I run [company]. My current focus is [thing].
My goals this quarter are: [3 bullets].
I hate when AI tools [specific dislike].
```

Claude reads this every conversation in that project. **This is the highest-leverage 5 minutes you will spend.**

### 3. Connect Gmail as your first MCP server

From Claude Code:

```
/mcp
```

Pick **Gmail**, follow the OAuth flow. Verify: ask Claude *"List my unread emails from today."*

> **Discipline:** start with 3-5 MCP servers max. Gmail, Calendar, Drive, Notion. Stop. Add more only when a real need surfaces. The 31-server count is what 3 years of additions look like — it is not a starting point.

### 4. Write your first skill — `/morning-brief`

Create `~/.claude/skills/morning-brief/SKILL.md`:

```markdown
---
name: morning-brief
description: Give me a 5-bullet brief on today — calendar, top emails, open threads. Trigger when I say "morning brief", "what's on today", or "brief me".
---

Pull from:
1. Calendar today (next 8 hours)
2. Gmail unread top 5
3. Any open threads I flagged in /memory/project_open_threads.md

Output: 5 bullets max. No fluff. Lead with what needs my decision today.
End with one line: "Top decision today: [...]".
```

Type `/morning-brief` in Claude Code. You have a working personal AI.

### 5. (Optional) Mobile via Telegram + always-on cron

Spin up an AWS Lightsail VM in Frankfurt (~20 EUR/mo). Install Claude Code on it, register a Telegram bot via BotFather, run a small Node bot that listens to Telegram messages, forwards them to a `claude` session over HMAC-verified webhook, posts replies back. Schedule cron jobs for `/morning-brief` (07:00 daily) and `/weekly-review` (Fri 17:00).

Detailed playbook: [`solutions/setup-itself/30-min-aios-blueprint.md`](../solutions/setup-itself/30-min-aios-blueprint.md).

---

## What hurts (honest struggles)

1. **Memory drift.** Memory files go stale within weeks if you do not audit them. Run a weekly `/memory-curator` skill on a cron or the brain runs on lies.
2. **MCP server count.** 31 is too many. Most are quiet for weeks. Start with 5 and earn the rest. The combinatorics of integration testing across all of them get nasty fast.
3. **Skill description quality.** A skill with a bad `description` field never triggers. The trigger sentence is 80% of the work — invest 10 minutes per skill on it.
4. **Cost spikes during build-up.** Real number: ~$50/day Opus burn for 2-4 weeks while iterating. Steady state is much lower (~150 EUR/mo) but plan for the burn.
5. **Vendor roadmap risk.** Anthropic changes the CLI quarterly. In 2026 my `settings.json` broke on three releases. Pin a Claude Code version if you cannot tolerate that.
6. **Migration drag.** I wasted 30 days mid-2026 on a half-finished Drive sync (race condition with OneDrive). Lesson: 1-day audit, 1-day migration, 1-day docs. Don't drag.

---

## When this is the right choice (and when it is not)

**Pick this if:**
- You live in Google Workspace and want everything there
- You operate across multiple domains (≥3) and need a single brain that understands all of them
- You need mobile from day one
- You can pay ~150 EUR/mo for convenience
- You want to *own* the setup and iterate forever, not buy a SaaS

**Skip this if:**
- You handle data that cannot leave your machine (Dom's local-first path — doc refreshing, see [slides 13-15](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13))
- You want a complete Life OS out of the box ([Fabian's PAI setup](fabian-personal-ai.md))
- You operate in a single domain and 5 skills would cover you (this is overkill)
- You are not willing to maintain a personal stack on an ongoing basis

---

## Why this matters as a reference architecture

The same 4-Layer Brain pattern scales across very different "bodies." Demo'd at Event #1 across three:

| Body | Skills | Working Memory | Body / Tools |
|---|---|---|---|
| **Personal** (this file) | 19 | Claude Code on Lightsail Frankfurt | Telegram bot + 39 Workspace adapters |
| **12-person Agency** | 10 | Claude Code Bypass mode | GitHub + Notion + Dropbox |
| **B2B Sales Org** | 8 | AWS Lambda harness | Close + Sheets + Slack + EventBridge |

Same architecture, different surface area. The number that matters is not the count of skills — it is the count of *workflows you do not have to do anymore*.

---

## Tracked results — the 9-row "Day in the Life" table

| Task | Frequency | Without brain | With brain | Saved/week |
|---|---|---|---|---|
| Morning briefing | Daily 7:00 | 30 min | 3 min | 2.25h |
| Meeting prep | ~4 calls/day | 20 min × 4 | 3 min × 4 | 5.7h |
| Email + WhatsApp drafts | ~8/day | 5 min × 8 | 1 min × 8 | 2.7h |
| Real estate pricing | Daily auto | 60 min/day | 0 min | 5.0h |
| Stakeholder updates | ~5/week | 20 min × 5 | 5 min × 5 | 1.25h |
| Friday weekly review | Fri 17:00 | 90 min | 10 min | 1.3h |
| Invoices + DATEV | Monthly auto | 2h/month | 0 min | 0.5h |
| Client diagnostics | ~2/month | 8h × 2 | 1.5h × 2 | 3.0h |
| Client deliverables | ~3/week | 90 min × 3 | 15 min × 3 | 3.75h |
| **Total** | | | | **~23h/week** |

Tracked March-April 2026, mixed personal admin + ops + advisory work.

---

## Sources

- Live deck: [`chris-demo.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides, the body-mapped tour)
- Joint deck slides 1-11: [`slides.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html)
- Abbreviated build playbook: [`solutions/setup-itself/30-min-aios-blueprint.md`](../solutions/setup-itself/30-min-aios-blueprint.md)
- What breaks in production: [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md)
- Q&A panel cheatsheet: [`events/01-2026-05-11-setup-trap/QA-CHEATSHEET.md`](../events/01-2026-05-11-setup-trap/QA-CHEATSHEET.md)
- Claude Code docs: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview)
- MCP Cookbook (10 essential servers, co-authored): [`solutions/integration-mcp/mcp-cookbook.md`](../solutions/integration-mcp/mcp-cookbook.md)

---

*If you fork this setup and hit something this spec does not cover, [open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) — Chris or another community member who runs it may answer.*
