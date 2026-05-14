# Setup 1 — Chris's Workspace-Native Claude Code

> **The 30-second pitch.** [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) wired into Google Workspace via 31 MCP servers (~39 total Workspace adapters), 19 reusable Skills, 125 memory files, 7 cron jobs, and a Telegram bot for mobile. ~150 EUR/month all-in. ~23 hours per week saved on a tracked sample. Replaces ~1.5 FTE that would have cost 80-110k EUR/year — a **45-60x cost ratio**. Personal opportunity cost reclaimed: **~270k EUR/year** (23h/wk × 47 weeks × 250 EUR/hr).

**Maintained by:** Christoph Erler ([erlerventures.org](https://erlerventures.org))
**Companion deck:** [chris-demo.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides, body-mapped tour)
**Joint deck:** [slides.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html) (slides 1-11 are Chris's section)
**Pain clusters this addresses:** Setup Itself, Tool Overload, Integration, Pace
**Live demo:** Demo 1 at [Event #1](../events/01-2026-05-11-setup-trap/README.md), 2026-05-11
**Cost:** ~150 EUR/mo all-in
**License of this spec:** MIT

---

## Origin — the bet behind the architecture

> *"After ComX, I had the option to hire and rebuild what I already knew. Instead I bet that **AI as infrastructure can replace the team I would have hired**. Three years later, that bet is still the strategy."* — Chris, Slide 2

**Three founding rules:**
1. **Every workflow I touch becomes a skill.**
2. **Every meeting I have becomes a memory.**
3. **Every recurring task lands on a cron.**

**The discipline rule (slide 36):**
> *"If I have to ask my system for the same thing twice, **I failed**."*

**Result:** zero employees. A brain that is version-controlled and queryable. Runs at ~150 EUR/month. Replaces ~1.5 FTE. Same architecture scales to a 12-person agency brain and a B2B sales-org brain (~5 FTE total replaced across three "bodies", ~330-490k EUR/yr equivalent capability never paid for — slide 25).

---

## Who this is for

- You live inside Google Workspace (Gmail, Calendar, Drive, Docs, Sheets, Meet)
- You operate across multiple domains (advisory, real estate, ventures, content, etc.) and need one brain that understands all of them
- You want AI everywhere — including on mobile — not just at your desk
- You are fine paying ~150 EUR/month for the convenience
- You are willing to invest 30-60 hours up-front to get the foundation right
- You want to *own* the setup and iterate on it for years, not buy a SaaS

If you want a complete opinionated Life OS out of the box, see [Fabian's PAI setup](fabian-personal-ai.md).
If you want zero ongoing cost and full sovereignty, see [Dom's local-first setup](dom-rolodex.md).

---

## What you get out of the box

### The 4-Layer Brain Architecture

The core mental model. Each layer has a clear job and lives in a specific place.

| Layer | Job | Where it lives |
|---|---|---|
| **1. Long-term Memory** | Everything retained, version-controlled, source of truth | GitHub (code/skills), Notion (shared prose), Google Drive (originals only) |
| **2. Short-term Memory** | Loaded on-demand per task, routed by context | 125 `.md` files in `~/.claude/projects/erler-brain/memory/` (mirrored to GitHub), routed by a ~50-line `CLAUDE.md` |
| **3. Working Memory** | Active reasoning, where Claude actually thinks | [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) on AWS Lightsail Frankfurt (EU residency, audit-logged, read-only by default) |
| **4. Body** | Execution, the tools the brain can touch | Telegram bot (mobile), 31 MCP servers (~39 Workspace adapters incl. Computer-Use / Chrome / Telegram), 7 cron jobs (daily / weekly / monthly) |

### The numbers at a glance

| Component | Count |
|---|---|
| MCP servers wired in | 31 |
| Total Workspace adapters (incl. Computer-Use, Chrome, Telegram) | ~39 |
| Skills | 19 (8 demoed publicly, see [`/skills/`](../skills/)) |
| Memory files | 125 (`.md`, ~1-page profiles each) |
| Cron jobs | 7 (daily / weekly / monthly) |
| Search backend | `ripgrep` + glob — **no vector DB** (threshold ~10k files; this brain is at ~200) |
| Mobile | Telegram bot on AWS Lightsail Frankfurt (~20 EUR/mo VM) |
| EU residency | Yes — all reasoning happens on AWS Frankfurt |
| Hours saved per week (8-week tracked sample) | ~23h |
| Total monthly cost | ~150 EUR all-in |
| Total annual cost | ~1.8k EUR/yr |
| Replaces | ~1.5 FTE = 80-110k EUR/yr (~45-60x ratio) |

### Memory file structure (the 125 files, by category)

| Category | Files | Examples |
|---|---|---|
| Schreibregeln (voice rules) | 12 | tone-by-channel, written-vs-spoken style, banned words list |
| Brain Architecture | 5 | conventions, routing, audit cadence |
| Real Estate | 15 | properties, pricing rules, partner contacts |
| Aviation | 10 | aircraft specs, maintenance cadence, dispatch |
| Erler Ventures | 8 | thesis, pipeline, advisory engagements |
| Personal & Family | 8 | calendar rules, family ops, domestic ops |
| Content & Sales | 10 | content pillars, ICP, sales cadence |
| Diverses | 7 | catch-all |

Each file: 1 page max, frontmatter (`name`, `description`, `type` ∈ {reference, project, feedback, user}, `originSessionId`).

---

## Memory file anatomy (slide 43)

Every memory file follows the same internal structure. Not optional — this is what makes the brain usable months later.

```markdown
---
name: stephan_big_decision_apr26
description: Big Decision Framework for Stephan
type: reference
originSessionId: 8b99bcca-...
---

# Stephan · Big Decision Framework · April 2026

## Why (the trigger context)

[Why this memory exists. The conversation, the pattern, the decision that
was made. 2-4 sentences. Context for future-you.]

## How to apply

[The actionable distillation. When does this memory matter? What does it
change about your behavior? Specific, not abstract.]

## Anchor

[When to revisit this memory. Auto-pruned if stale by /memory-curator.
e.g. "Re-evaluate if Stephan's role changes" or "Sunset on 2026-12-01".]
```

**Why this structure matters:** the `originSessionId` lets you trace back to the original conversation. The `Why` answers "why does this exist?" — without that, files become orphans you cannot prune. The `Anchor` is the auto-prune signal for `/memory-curator`.

---

## SKILL.md anatomy (slide 38, ev-assistant example)

Every skill file follows the same structure. This is the actual `ev-assistant` from Chris's brain, shown live on stage:

```markdown
# SKILL.md, ev-assistant

name: ev-assistant
type: founder-os
load_when: erler ventures, positioning, ICP, outreach, content

## Purpose
Founder operating system for Erler Ventures. Drafts, intel, content, sales prep.

## Inputs (4 sources)
- Notion: Brain Hub > Ventures > Erler Ventures (live)
- Memory: ev_positioning.md, ev_icp_dual.md, ev_services.md
- Voice rules: writing_rules.md
- Calendar + Gmail: deal-stage context per prospect

## Outputs
- LinkedIn post drafts in my voice
- Outreach emails per ICP segment
- Sales conversation prep
- Content calendar suggestions
- Pricing + service page updates

## Non-negotiable rules
No AI-fluff (delve, leverage, harness, robust).
German Umlaute mandatory. No em-dashes.
Voice match exact. No vendor pitch tone.
```

**The 8 forkable starter SKILL.md files** demoed at Event #1 are now in [`/skills/`](../skills/) — fork as templates, customize the Inputs / Outputs / rules to your context.

---

## The 8 forkable skills (now live in `/skills/`)

> All 8 are `SKILL.md` templates. Patterns from the live demo. Sanitized of personal data — your job is to plug in your context.

### Universal (5) — fork as-is, edit personal data

| Skill | What it does | Tracked saved time | File |
|---|---|---|---|
| `/morning-brief` | Daily 7am brief: inbox top 3, calendar, open threads | 2.25h/week | [`/skills/morning-brief/SKILL.md`](../skills/morning-brief/SKILL.md) |
| `/diarize-person` | 1-page stakeholder dossier with full history | (5.7h/wk meeting prep) | [`/skills/diarize-person/SKILL.md`](../skills/diarize-person/SKILL.md) |
| `/draft-by-channel` | Voice-locked drafts per recipient + channel | 2.7h/week | [`/skills/draft-by-channel/SKILL.md`](../skills/draft-by-channel/SKILL.md) |
| `/weekly-review` | Friday 7-day review across all "hats" | 1.3h/week (90→10 min) | [`/skills/weekly-review/SKILL.md`](../skills/weekly-review/SKILL.md) |
| `/memory-curator` | Weekly memory hygiene cron | maintenance | [`/skills/memory-curator/SKILL.md`](../skills/memory-curator/SKILL.md) |

### Domain examples (3) — show the pattern, adapt to your vertical

| Skill | For who | Pattern to copy | File |
|---|---|---|---|
| `/audit-process` | Advisors / COOs / ops consultants | Diagnostic + Impact-Effort matrix + top-3 | [`/skills/audit-process/SKILL.md`](../skills/audit-process/SKILL.md) |
| `/sales-script-rewriter` | Sales founders / SDR managers | Transcript-in + 6-dim score + rewritten section | [`/skills/sales-script-rewriter/SKILL.md`](../skills/sales-script-rewriter/SKILL.md) |
| `/property-pricing` | Real estate / daily-priced goods | API-in + decision-out + daily cron | [`/skills/property-pricing/SKILL.md`](../skills/property-pricing/SKILL.md) |

---

## The 7 cron jobs (slide 46)

This is what "every recurring task lands on a cron" actually looks like. Real schedule, real outputs.

| When | Job | Output |
|---|---|---|
| Daily 06:00 | Parkside daily pricing | 6 studio units, Holidu GraphQL update, optimal price + Notion log |
| Daily 07:00 | Morning brief | Inbox top 3, calendar, open threads → Telegram |
| Hourly | Drive memory sync | Git pull from GitHub to local + Telegram bot server |
| Sun 14:00 | Weekly content engine | LinkedIn + Substack drafts, anti-AI voice check |
| Mon 1st of month | Invoice generation + DATEV | PDF invoices, signed, archived |
| Fri 17:00 | Weekly review | 7-day summary, open threads, priorities → Telegram |
| As-needed | Receipt sweep (WIP) | JPG → PDF, queued for DATEV |

**Cron discipline rule:** if you find yourself manually doing a task you've done >3 times in a month, it's a cron candidate. Add it to the list, do not promote it as "important manual work".

---

## Anti-AI voice clone rules (slides 41-42)

Voice is the highest-leverage memory. Every output that sounds like AI degrades trust. These rules are loaded on every skill that produces text.

### Banned (never use)

- delve / delving
- leverage / leveraged
- unlock / unlocking
- harness / harnessing
- synergy / synergize
- robust
- seamless / seamlessly
- "I hope this finds you well"
- em-dashes (—) — use commas, periods, parentheses
- mega-paragraphs (>5 sentences without a break)
- "happy to help" / "great question"
- "in today's fast-paced world"

### Required

- **German Umlauten** always (never `ae`, `oe`, `ue`)
- **Direct, terse** — cut adjectives that aren't load-bearing
- **Sie-Form for PE / corporate counsel**, **Du-Form for founders / EO peers**
- **One concrete number per outreach** ("in 6 to 9 months", not "fairly quickly")
- **First name only sign-off in DMs**, full sign-off block only in formal emails
- **Match recipient's last register** — don't switch mid-thread

Full template at [`templates/memory-templates/feedback_voice.md`](../templates/memory-templates/feedback_voice.md). Fork it, fill in your own examples.

---

## Cost — the honest breakdown

### Steady state

| Item | Cost/month |
|---|---|
| Claude Pro subscription | ~20 EUR |
| AWS Lightsail Frankfurt VM (Telegram bot + Claude Code daemon) | ~20 EUR |
| Misc API spend across MCP servers (Holidu, Close, etc.) | ~110 EUR |
| **Total** | **~150 EUR** |

### What it replaces

| What this replaces | Cost/year |
|---|---|
| 0.5 EA + 0.5 Junior Analyst + 0.5 Content Manager (~1.5 FTE in DACH at 7-9k EUR/mo each) | 80-110k EUR/yr |
| **This setup** | **~1.8k EUR/yr** |
| **Cost ratio** | **~45-60x cheaper** |

### Personal opportunity cost reclaimed

23 hours per week × 47 weeks × 250 EUR/hr (Chris's blended advisory rate) = **~270k EUR/year** of Chris's time freed up for higher-leverage work.

### Hidden costs (not in the 150 EUR/mo)

- **Setup time:** ~200h up-front. Payback period 4-5 months.
- **Maintenance tax:** ~2h/month (memory curation, dependency churn, occasional debug).
- **Build-up burn:** $50/day Opus burn for 2-4 weeks while iterating. Plan for it.

Not zero. Honest.

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

## Quick Start (5 minutes — you'll have a working brain)

If you only have 5 minutes right now:

```bash
# 1. Install Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# 2. Clone this repo
git clone https://github.com/chris1928a/eo-ai-exchange.git
cd eo-ai-exchange

# 3. Fork the templates into your Claude config
mkdir -p ~/.claude/projects/my-brain/memory
cp -r templates/memory-templates/* ~/.claude/projects/my-brain/memory/
cp templates/CLAUDE.md.template ~/.claude/projects/my-brain/CLAUDE.md

# 4. Fork the morning-brief skill
cp -r skills/morning-brief ~/.claude/skills/

# 5. Open a Claude Code session in the project
cd ~/.claude/projects/my-brain && claude
```

Then in Claude Code: edit `memory/user_about.md` (5 min, the highest-leverage file you'll write) and type `/morning-brief` to test.

For the full path with MCP servers, cron jobs, and Telegram, continue with the Step-by-step below.

---

## Day 0 checklist (the shopping list)

Before you start the long-form Step-by-step, confirm you have:

- [ ] A Claude Pro subscription (or API access) — [console.anthropic.com](https://console.anthropic.com)
- [ ] Google Workspace account with admin access (for OAuth approval of MCP servers)
- [ ] Mac / Linux machine, OR Windows + WSL2 installed and working
- [ ] `git` and `curl` installed (`git --version` and `curl --version` should both work)
- [ ] (Optional) AWS account if you want the Telegram bot path — [aws.amazon.com](https://aws.amazon.com)
- [ ] (Optional) Telegram account + access to BotFather for bot creation
- [ ] 60 minutes of uninterrupted time (or break it into two 30-min sessions)

If any of the optional ones is missing, you can still run the desktop-only version — skip Step 5 in the long-form below.

---

## Step-by-step to your first win (60 minutes)

### 1. Install Claude Code

```bash
# Mac / Linux
curl -fsSL https://claude.ai/install.sh | bash

# Windows: install WSL first, then run the same command inside WSL
```

Verify: `claude --version`. Reference: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview).

### 2. Fork the templates

```bash
git clone https://github.com/chris1928a/eo-ai-exchange.git
mkdir -p ~/.claude/projects/<your-project>/memory
cp -r eo-ai-exchange/templates/memory-templates/* ~/.claude/projects/<your-project>/memory/
cp eo-ai-exchange/templates/CLAUDE.md.template ~/.claude/projects/<your-project>/CLAUDE.md
```

**The 30-minute step that matters:** Edit `user_about.md` and `feedback_voice.md`. These two files are 80% of the leverage you will get from the entire setup. Spend real time on them. Banned words list, voice examples, how you actually sound — all of it.

**Verification:** `ls ~/.claude/projects/<your-project>/memory/` should show 7+ template files.

### 3. Connect Gmail as your first MCP server

From Claude Code:

```
/mcp
```

Pick **Gmail**, follow the OAuth flow. Verify: ask Claude *"List my unread emails from today."*

> **Discipline:** start with 3-5 MCP servers max. Gmail, Calendar, Drive, Notion. Stop. Add more only when a real need surfaces. The 31-server count is what 3 years of additions look like — it is not a starting point.

### 4. Fork your first skill — `/morning-brief`

```bash
mkdir -p ~/.claude/skills
cp -r eo-ai-exchange/skills/morning-brief ~/.claude/skills/
```

Edit the `SKILL.md` to match your sources. Type `/morning-brief` in Claude Code.

**Verification:** Claude should produce a 5-bullet brief from your real Gmail + Calendar data. If it doesn't trigger, check the `description` field in the frontmatter — that's the trigger sentence.

**You now have a working personal AI.** Stop here for today if you want. Come back for Step 5 when you want mobile + always-on.

### 5. (Optional) Mobile via Telegram + always-on cron

Spin up an AWS Lightsail VM in Frankfurt (~20 EUR/mo). Install Claude Code on it, register a Telegram bot via BotFather, run a small Node bot that listens to Telegram messages, forwards them to a `claude` session over HMAC-verified webhook, posts replies back. Schedule cron jobs for `/morning-brief` (07:00 daily) and `/weekly-review` (Fri 17:00).

Detailed playbook: [`solutions/setup-itself/30-min-aios-blueprint.md`](../solutions/setup-itself/30-min-aios-blueprint.md).

---

## Troubleshooting — things that go wrong on first setup

| Symptom | Likely cause | Fix |
|---|---|---|
| `claude --version` says "command not found" | PATH not refreshed after install | Restart your terminal, or `source ~/.bashrc` / `source ~/.zshrc` |
| `/mcp` doesn't list any servers | First-time setup, none registered | That's expected — pick one (e.g. Gmail), follow the OAuth flow |
| `/mcp` lists Gmail but Claude says "I cannot access your email" | OAuth wasn't completed | Re-run `/mcp`, complete the browser auth flow, retry |
| `/morning-brief` doesn't trigger when you type it | Skill description doesn't match the trigger words | Edit `~/.claude/skills/morning-brief/SKILL.md` `description` field — must contain words you actually type |
| Skill triggers but output is generic | Memory files are empty templates | Edit `user_about.md` and `feedback_voice.md` with real content |
| Claude doesn't load `CLAUDE.md` | Wrong directory | `CLAUDE.md` must be at the root of the project where you start `claude` |
| Memory file doesn't get loaded | Not pointed to from `MEMORY.md` | Add a one-line entry to `~/.claude/projects/<your-project>/memory/MEMORY.md` |
| Telegram bot doesn't reply | Webhook URL wrong, or HMAC signature mismatch | Check Lightsail security group + bot token + webhook URL in BotFather |
| Cron job doesn't fire | Cron daemon not running, or path issue in cron command | `systemctl status cron` (Linux) / `crontab -l` to confirm; use absolute paths in cron commands |
| Cost spiking past expected | Probably Opus burn during build-up | Switch model to Sonnet 4.6 for high-frequency operations; reserve Opus for hard reasoning |

If you hit something not on this list, [open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) and we'll add it.

---

## What hurts (honest struggles)

1. **Memory drift.** Memory files go stale within weeks if you do not audit them. Run `/memory-curator` on a Sunday cron or the brain runs on lies.
2. **MCP server count.** 31 is too many. Most are quiet for weeks. Start with 5 and earn the rest. Integration testing across all of them gets nasty fast.
3. **Skill description quality.** A skill with a bad `description` field never triggers. The trigger sentence is 80% of the work — invest 10 minutes per skill on it.
4. **Cost spikes during build-up.** Real number: ~$50/day Opus burn for 2-4 weeks while iterating. Steady state much lower (~150 EUR/mo) but plan for the burn.
5. **Vendor roadmap risk.** Anthropic changes the CLI quarterly. In 2026 my `settings.json` broke on three releases. Pin a Claude Code version if you cannot tolerate that.
6. **Migration drag.** I wasted 30 days mid-2026 on a half-finished Drive sync (race condition with OneDrive). Lesson from the v3.5 audit (slide 50): 1-day audit, 1-day migration, 1-day docs. Don't drag.

---

## Audit + migration timeline (slide 50)

The honest history of how this brain got here:

| When | What happened |
|---|---|
| Mar 18 | v4 vision: Drive-Hub as brain, Telegram security fixes, 39 tools registered, PDF/DOCX parsing |
| Mar-Apr (30 days) | Skills clustering to 17 clusters, 175 uncommitted files, Drive sync half-finished |
| Apr 27 AM | Brain v3.5 audit — Drive sync killed, OneDrive+Git race condition flagged |
| Apr 27 PM | 1-day migration: Robocopy `C:\Code` (1.72 GB / 58.638 files in 43 sec) |
| Apr 27 EOD | Documentation + talk backbone drafted |
| May 11 | Event #1 delivered |

**The lesson:** *"Audit is one day. Migration is one day. Documentation is one day."* Don't drag. v3.5 has been live in production for ~2 years now.

---

## When this is the right choice (and when it is not)

**Pick this if:**
- You live in Google Workspace and want everything there
- You operate across multiple domains (≥3) and need a single brain that understands all of them
- You need mobile from day one
- You can pay ~150 EUR/mo for convenience
- You want to *own* the setup and iterate forever, not buy a SaaS

**Skip this if:**
- You handle data that cannot leave your machine (use [Dom's local-first setup](dom-rolodex.md))
- You want a complete Life OS out of the box ([Fabian's PAI setup](fabian-personal-ai.md))
- You operate in a single domain and 5 skills would cover you (this is overkill)
- You are not willing to maintain a personal stack on an ongoing basis

---

## The 3-Pyramid reference architecture (slides 9-10, 18-19, 22-24)

The same 4-Layer Brain pattern scales across very different "bodies." Demo'd at Event #1 across three:

| Body | Skills | Working Memory | Body / Tools |
|---|---|---|---|
| **Personal** (this file) | 19 | Claude Code on Lightsail Frankfurt | Telegram bot + 39 Workspace adapters |
| **12-person Agency** | 10 | Claude Code Bypass mode | GitHub master + Notion + Dropbox |
| **B2B Sales Org** | 8 | AWS Lambda harness | Close.com CRM + Sheets + Slack + EventBridge |

Same architecture, different surface area. Across the three: ~5 FTE replaced, **~330-490k EUR/yr equivalent capability never paid for** (slide 25-26).

The number that matters is not the count of skills — it is the count of *workflows you do not have to do anymore*.

---

## Where this fits in the industry (slide 48 — convergence table)

| Pattern | Chris | Karpathy | Anthropic |
|---|---|---|---|
| Markdown + Git for memory | ✅ | ✅ | ✅ |
| Skip Vector-DB at this scale | ✅ | ✅ | ✅ |
| Skill files as units of behavior | ✅ | ✅ | ✅ |
| Multi-domain operator focus | ✅ (5+ hats) | partial | n/a |
| 31 MCP tools orchestrated | ✅ | n/a | n/a |
| Telegram interface for mobile | ✅ | n/a | n/a |
| Cron-driven daily workflows | ✅ | partial | n/a |
| Notion sharing layer | ✅ | n/a | n/a |
| EU-only stack | ✅ | n/a | n/a |

Where Chris's setup differs: multi-domain operator surface area + EU-residency / DACH compliance + cron-driven everything. The architecture pattern is industry-convergent. The differences are operator-specific.

---

## Tracked results — the 9-row "Day in the Life" table (slide 7)

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

## 30-day rollout plan (slide 27-29)

If you fork everything in this repo today, here is the realistic timeline:

**Day 1-7 — Personal brain bootstrap**
- Day 1: Install Claude Code, fork [`templates/`](../templates/) into `~/.claude/projects/<your-project>/`
- Day 1-2: Edit `user_about.md` + `feedback_voice.md` (this is the leverage)
- Day 3-4: Connect 3 MCP servers (Gmail, Calendar, Drive)
- Day 5-7: Fork 5 universal skills from [`/skills/`](../skills/), test each one in isolation

**Day 8-21 — First org skill**
- Pick your weakest workflow (mine was real estate pricing). Build it as a skill following the `/property-pricing` pattern.
- Run it manually for a week. Tune the rules. Tighten the floor/ceiling. Build trust.

**Day 22-30 — Cron live**
- Move the working skill onto a cron (Lightsail Frankfurt VM, ~20 EUR/mo)
- Add `/morning-brief` and `/weekly-review` on cron
- Set up the Telegram bot if you want mobile

**Weekend breakdown for the first push:**
- 30 min: clone the repo, fork templates
- 1-2h: write your `CLAUDE.md` and `user_about.md`
- 1h: fork the first skill, test
- 1-2h: harness setup on Lightsail (or skip if desktop-only)
- **Monday 07:00: your first auto-generated brief lands in Telegram**

---

## Honest struggles, expanded (slide 20-21)

A few extra honest data points from the deck:

- **80% of org memory dies in Slack/email**, only ~20% survives in Notion (slide 20). The whole "memory layer first" insight comes from this number.
- **External agency quote for an org-brain build:** 56-89 person-days = 110-180k EUR. Chris built the equivalent in ~27.5k EUR with this stack (slide 21-22).
- **Sales org headcount comparison:** would have hired Sales Manager + Sales Ops Analyst (140-200k EUR/yr) — never did, brain replaces the leverage parts.

---

## Sources

- Live deck: [`chris-demo.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides, the body-mapped tour)
- Joint deck slides 1-11: [`slides.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html)
- The 8 forkable skills: [`/skills/`](../skills/)
- The starter templates: [`/templates/`](../templates/)
- Abbreviated build playbook: [`solutions/setup-itself/30-min-aios-blueprint.md`](../solutions/setup-itself/30-min-aios-blueprint.md)
- 30-day onboarding plan: [`solutions/time-learning/60-day-founder-onboarding.md`](../solutions/time-learning/60-day-founder-onboarding.md)
- What breaks in production: [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md)
- Q&A panel cheatsheet: [`events/01-2026-05-11-setup-trap/QA-CHEATSHEET.md`](../events/01-2026-05-11-setup-trap/QA-CHEATSHEET.md)
- MCP Cookbook (10 essential servers, co-authored): [`solutions/integration-mcp/mcp-cookbook.md`](../solutions/integration-mcp/mcp-cookbook.md)
- Claude Code docs: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview)

---

*If you fork this setup and hit something this spec does not cover, [open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) — Chris or another community member who runs it may answer. Sub a pain, get a solution.*
