# Setup 2, Dom's Local-First Rolodex (built on OpenClaw)

> **The 30-second pitch.** Vanilla [OpenClaw](../solutions/openclaw-honest/openclaw-honest-assessment.md) as backbone, custom **5-tier memory** layer (`System Prompt > Bootstrap > On-Demand > Search Index > Raw Archive`), a **Rolodex of 107 person dossiers**, **1.183 files** indexed across **5.735 vectors / 11 collections**, all running on local models on a Mac. **2-5 second queries.** **~$0/month marginal cost.** Built over **12 months from scratch**. The agent that remembers.

**Maintained by:** Dominik Raute (CTO, JustWatch), [linkedin.com/in/dominikraute](https://www.linkedin.com/in/dominikraute/)
**Live demo:** Demo 2 at [Event #1](../events/01-2026-05-11-setup-trap/README.md), [slides 13-15](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13) of the joint deck
**Architecture deep-dive:** Dom's anonymized architecture doc is currently being refreshed (URL was on a self-hosted server that went offline). This file is the high-level overview based on public Event #1 slide content. When Dom's URL is back, the deep-dive technical doc (exact model choices, wire-up code, packaging) gets linked here.
**Pain clusters this addresses:** Cost, Security/GDPR, Reliability
**Cost:** ~$0/mo marginal

> **Heads-up directly from Dom:** *"die richtig interessanten Parts sind relativ hart verdrahtet mit den lokalen Modellen auf meinem Mac"*, the high-value pieces are hardwired to his specific setup. *"für nicht-techies ist leider wenig dabei. Das ist größtenteils customized."* Read this file as architecture inspiration, not a copy-paste recipe.

---

## Who this is for

- You handle data that cannot or should not leave your machine (regulated industries, M&A, legal, medical, customer-PII-heavy work)
- You are on macOS (Dom's setup is Mac-first; Linux porting is theoretical)
- You are technical enough to maintain a custom stack alone
- You want **zero ongoing API cost** and full sovereignty
- You want to *understand* every layer of your AI stack, not abstract it away

If you live in Google Workspace and want everything there, see [Chris's Workspace-native setup](chris-claude-code.md).
If you want a complete opinionated Life OS out of the box, see [Fabian's PAI setup](fabian-personal-ai.md).

---

## What you get out of the box

### The 5-Tier Memory Architecture (Hack #1, slide 14)

This is the core. Five tiers, each with a distinct job, layered from hot to cold.

| Tier | Name | Job |
|---|---|---|
| 1 | **System Prompt** | The base context loaded at every session start. Identity, role, rules. |
| 2 | **Bootstrap** | The on-startup load. Recent conversations, active projects, current state. |
| 3 | **On-Demand** | Pulled when triggered by query. Per-task context fetched lazily. |
| 4 | **Search Index** | Semantic search across the cold tier. The "find me everything related to X". |
| 5 | **Raw Archive** | Everything ever. Never deleted. The eventual ground-truth fallback. |

> **What is in Dom's anonymized doc (currently offline):** the exact tier-routing logic, when does Bootstrap trigger vs On-Demand, what counts as a query worth Search Index hit, how Raw Archive is partitioned. That technical depth is in the doc, not in this file.

### The Rolodex (Hack #2, slide 14)

| Field | What it captures |
|---|---|
| Person dossiers | **107 people** tracked |
| Per-person fields | Communication style, last contact date, open threads |
| Update mechanism | Manual today (Dom flagged "manual rolodex drift" as honest struggle) |
| Search | Local, indexed, queryable in 2-5 seconds |

The Rolodex is the "I have to remember everyone I've ever talked to and what we last said" layer. Replaces a CRM for a single operator.

### The numbers at a glance

| Component | Count |
|---|---|
| Backbone | Vanilla [OpenClaw](../solutions/openclaw-honest/openclaw-honest-assessment.md) (no fork, no patch) |
| Memory tiers | 5 |
| Person dossiers in Rolodex | 107 |
| Files indexed | 1.183 |
| Vectors stored | 5.735 |
| Vector collections | 11 |
| Local query time | 2-5 seconds |
| API cost (steady state) | $0/mo |
| Build time (from scratch) | ~12 months |
| Platform | Mac-first (M-series recommended) |
| Models | Local LLMs (Mac-hosted) for the default loop, cloud Claude only when reasoning depth is needed |

---

## Cost reality (honest, not the "$0" headline)

The "$0 marginal" framing on stage is technically true but hides two real costs.

### Steady-state monthly

| Item | Real cost |
|---|---|
| OpenClaw | Free, open source |
| Local model serving (Ollama / LM Studio / llama.cpp) | $0 software + electricity (Mac running 24/7 ≈ $5-15/mo at typical EU/US rates) |
| Vector DB | Free, runs locally |
| Cloud Claude API (only when escalated to hard reasoning) | **$5-50/month** depending on how often you escalate |
| **Real steady-state total** | **~$10-65/month** (not $0) |

### Up-front hardware (the big hidden cost)

| Item | Real cost |
|---|---|
| Mac M-series + 32GB+ RAM (recommended for useful local model speeds) | **~3-5k EUR once** if you don't already have one |

If you already own a capable Mac, this is $0 incremental. If you don't, this is the dominant cost.

### Up-front engineering effort

The trade is also **engineering time, not just money**. ~12 months from scratch for the full setup. If you fork this approach today, expect:
- **40-80 hours** to stand up the first 2 tiers (System Prompt + Raw Archive) and basic OpenClaw integration
- **+200-400 hours** to add the on-demand routing, Search Index, and Rolodex layers properly
- **Maintenance tax:** real engineering work, not zero (see honest struggles below)

### 3-year TCO honest comparison

| Scenario | Total |
|---|---|
| You already have a capable Mac | ~$360-2.340 over 3 years |
| You buy a Mac M-series (~$4k) | ~$4.360-6.340 over 3 years |

For comparison, [Chris's Workspace-Native](chris-claude-code.md) is ~5.4k EUR (~$5.800) over 3 years assuming you already have any laptop. **Once hardware is in the picture, the cost gap narrows considerably.** The real differentiator is sovereignty + control, not cost.

---

## What you need installed

| Tool | Why | Notes |
|---|---|---|
| **OpenClaw** | The workflow backbone | Read [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md) **before** installing, CVE-2026-25253 + ClawHavoc are real |
| **A local model runtime**, [Ollama](https://ollama.com), [LM Studio](https://lmstudio.ai), or [llama.cpp](https://github.com/ggerganov/llama.cpp) | Run LLMs on your Mac for the default loop | Pick one, stick with it |
| **A local vector DB**, [Chroma](https://www.trychroma.com), [LanceDB](https://lancedb.com), or sqlite-vec | Tiers 4 + 5 (Search Index + Raw Archive) | Chroma is easiest to start with |
| **A Mac with M-series chip + 32 GB+ RAM** | To run a useful local model alongside everything else | M3/M4 Pro or better recommended for real-world speed |
| **Claude API key** (optional, for escalated reasoning) | When local model is not enough | Pay-per-token, very low spend if used sparingly |

You can do this on Linux too, but everything in Dom's notes assumes Mac paths.

---

## Step-by-step to your first win (90 minutes for the backbone)

> There is no shortcut to the full 5-tier + Rolodex setup. That is months of work. But you can stand up the **backbone** (OpenClaw + local LLM + first 2 tiers) in an afternoon. After that, layer in the rest as your patterns emerge.

### 1. Install OpenClaw

Follow the OpenClaw install instructions, but **first** read [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md) and confirm you are on the patched version (CVE-2026-25253). Audit any installed skills against the ClawHavoc supply chain incident.

### 2. Install Ollama and pull a small model

```bash
# Mac
brew install ollama
ollama serve &
ollama pull llama3.2:3b   # 2GB, runs on any M-series
```

Verify: `ollama run llama3.2:3b "Say hi in 5 words"` should reply.

### 3. Stand up Tier 1 (System Prompt) + Tier 5 (Raw Archive)

Start with only 2 tiers. Do not build all 5 on day one.

**Tier 1, System Prompt:** a single Markdown file your OpenClaw flow loads at every session start. Identity, role, rules.

**Tier 5, Raw Archive:** a folder where everything you ever process gets dumped, dated, and indexed by filename. Never delete from here.

```
~/local-brain/
├── tier1_system_prompt.md
└── tier5_raw_archive/
    └── 2026-05-14/
        └── ...
```

The 3 missing tiers (Bootstrap, On-Demand, Search Index) are what comes after the first 30 days of real use, not what you start with.

### 4. Wire OpenClaw to use Ollama for cheap calls

Configure your OpenClaw flows so that high-frequency, low-stakes operations (classification, dedup, summarization) hit Ollama, and only escalate to cloud Claude when reasoning depth is needed.

> **What is in Dom's doc:** the specific OpenClaw flow patterns, the exact triggers for cloud-vs-local routing, the Vector DB schema. Not in this file because Dom did not share those details on stage.

### 5. Read Dom's anonymized architecture doc when it's back online

The full spec lives in Dom's anonymized doc. URL was on a self-hosted server that went offline; refreshing. When it's back, this file gets a working link to it. Until then, slides 13-15 of the [joint deck](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13) are the public reference.

---

## What hurts (honest struggles, from Dom's own slide 14 + chat)

These are the real trade-offs of the local-first path. Be honest with yourself before committing.

1. **Cold-start memory loss despite the 5-tier architecture.** Even with 5 tiers, the first request after a long gap is colder than the equivalent cloud-first setup. Plan for it.
2. **Manual rolodex drift, not auto-synced yet.** The 107 person dossiers do not auto-update from Gmail / Calendar / WhatsApp. Dom maintains them by hand. Auto-sync is the open work.
3. **Setup is real engineering work.** Built over 12 months from scratch. There is no shortcut.
4. **"Die richtig interessanten Parts sind relativ hart verdrahtet"** (Dom's own words). Even with the doc, parts of the setup are coupled to Dom's specific Mac, his specific local model choice, and his specific OpenClaw flows. Not all of it is transferable.
5. **Local model quality ceiling.** Even a 70B local model is well below cloud Claude on multi-step reasoning. Plan to escalate to cloud Claude when reasoning matters.
6. **You own all the bugs.** No vendor support. When the vector DB drifts, when memory tiers desync, when the Mac sleeps and the daemon dies, you fix it. Forever.

---

## When this is the right choice (and when it is not)

**Pick this if:**
- You handle regulated, medical, M&A, legal, or customer-PII data and cannot send it to a cloud LLM
- You are technical enough to debug the stack alone
- You value sovereignty over convenience
- You are on a Mac (or willing to do the porting)
- You are okay with no mobile (this setup is desktop-first)
- You can invest 12 months building toward the full vision

**Skip this if:**
- You want value in 30 minutes (use [Chris's Workspace-native setup](chris-claude-code.md) or [Fabian's PAI setup](fabian-personal-ai.md))
- You are on Windows and not willing to set up WSL + Linux daemons
- You need mobile from day one
- You don't already use OpenClaw and don't want to learn it
- The thought of debugging a vector DB on a Saturday makes you tired

---

## Why this matters as a reference architecture

Dom's setup is the **counterfactual** to the cloud-first paths. It proves that a serious operator can run a production-grade AI brain at $0/mo if they are willing to pay the engineering cost. That changes how you think about:
- **Cloud lock-in**, you are not stuck with a vendor's roadmap
- **Vendor risk**, your brain works even if Anthropic / OpenAI / Google has an outage
- **Data residency**, for DACH / regulated industries, the data simply never moves
- **Long-term cost curve**, $0 marginal is $0 in five years too

Read the architecture overview even if you never build this, it sharpens your evaluation of the other two paths.

---

## Honest caveats about OpenClaw itself

If you adopt OpenClaw for your own backbone, **read [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md) first.** The repo's honest assessment covers:
- **CVE-2026-25253** (CVSS 8.80, HIGH severity), 180.000+ instances were vulnerable before the patch
- **ClawHavoc supply chain attack**, 1.184 malicious packages on ClawHub, 9.000+ installs affected
- **Memory limitations**, OpenClaw was built for workflow orchestration, not persistent memory (which is *exactly* why Dom layered his own 5-tier memory on top)
- **Code surface area**, OpenClaw is ~430.000 lines of code
- **Five alternatives** with trade-offs: NanoClaw, ZeroClaw, Skyvern, Nanobot, OpenFang

Dom uses vanilla OpenClaw. If you are starting fresh and security matters more than feature breadth, NanoClaw is worth the look.

---

## Sources

- **Slides 13-15 of the joint deck** (Dom's section, public): [`slides.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13)
- **Dom's anonymized Architecture doc** (the actual technical spec), *URL refreshing, will be linked here when back online*
- **OpenClaw security baseline:** [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md)
- **DACH/EU compliance** (where this setup shines): [`solutions/security-gdpr/gdpr-claude-checklist-dach.md`](../solutions/security-gdpr/gdpr-claude-checklist-dach.md)
- **Ollama model library** (what local models exist today): [ollama.com/library](https://ollama.com/library)
- **Dom's LinkedIn:** [linkedin.com/in/dominikraute](https://www.linkedin.com/in/dominikraute/)

---

*This file describes only what Dom shared publicly at Event #1 (slides 13-15) plus his own chat quotes. No invented details. The deep-dive technical doc with exact tier-routing logic, OpenClaw flow code, and Vector DB schema is in Dom's anonymized doc, link will land here when his URL is back online.*
