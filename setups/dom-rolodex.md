# Setup 2 — Dom's Local-First 5-Tier Memory + Rolodex

> **The 30-second pitch.** Vanilla OpenClaw (Claude Code) running entirely against local models on a Mac, with a hand-built 5-tier memory layer and a Rolodex that has indexed 1.183 files and 107 people. $0/month marginal cost. Maximum sovereignty.

**Maintained by:** Dominik Raute (CTO, JustWatch)
**Architecture deep dive (anonymized):** [mcguffin.duckdns.org/.../ARCHITECTURE-anonymized.md](https://mcguffin.duckdns.org:4547/ws/rolodex-v2/ARCHITECTURE-anonymized.md?token=74gj4kk43B7hM5VztP09ZQ)
**Pain clusters this addresses:** Security/GDPR, Cost, Setup Itself, Reliability
**Live demo:** Demo 2 at [Event #1](../events/01-2026-05-11-setup-trap/README.md), see slides 12-15 of [slides.html](../events/01-2026-05-11-setup-trap/slides.html)

> ⚠️ **Heads-up on the Architecture link.** Dom's doc lives on his personal `mcguffin` server with a token-based URL. The token is good as of Event #1 (2026-05-11). If the link 404s when you try it, [open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) and we will get a fresh one from Dom.

---

## Who this is for

- You are on macOS or Linux (this setup is Mac-first)
- You want **zero ongoing API cost** and full local sovereignty
- You are comfortable in a terminal and willing to maintain custom code
- You handle data that you cannot or will not send to a cloud LLM (regulated industries, M&A, legal, medical, customer-PII-heavy)
- You want to *understand* every layer of your AI stack, not abstract it away

If you want everything to work in Google Workspace, look at [Chris's setup](chris-claude-code.md).
If you want an opinionated, prebuilt Life OS, look at [Fabian's setup](fabian-personal-ai.md).

---

## The 30-second architecture

> The full anonymized architecture doc is at the link above. This is a summary so you know what you are signing up for before you click through.

**Backbone:** Vanilla [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) (called "OpenClaw" in the slides). No fork, no patch.

**Memory in 5 tiers:**
1. **Hot** — current conversation context
2. **Warm** — last N days of summarized interactions
3. **Cold** — long-term semantic store (local vector DB)
4. **Frozen** — archival raw files, never deleted
5. **Index** — symbolic / structured index over the other 4 (the "Rolodex")

**Models:**
- **Local LLMs** for the high-frequency, low-stakes loop (memory writes, classification, dedup)
- **Claude (cloud) only** when reasoning depth is needed and the data is safe to send

This is the inverse of most setups: cloud LLMs handle the *exception*, local LLMs handle the *default*. Most queries never leave the machine.

**The Rolodex (v2):**
- 1.183 files indexed (notes, transcripts, docs, web clips)
- 107 people tracked (relationship graph + interaction history)
- All searchable, all local

---

## Cost reality

| Item | Cost |
|---|---|
| Claude Code | Free |
| Local model serving (Ollama/LM Studio/llama.cpp on M-series Mac) | Hardware you already own |
| Vector DB | Free, runs locally |
| Cloud Claude API (only when escalated) | < $5/mo for typical use |
| **Total marginal cost** | **~$0/mo** |

The trade is engineering time, not money. Plan for 40-80 hours of build-up if you want to replicate this from scratch.

---

## What you need installed

| Tool | Why | Notes |
|---|---|---|
| [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) | The CLI | Free |
| A local model runtime — [Ollama](https://ollama.com), [LM Studio](https://lmstudio.ai), or [llama.cpp](https://github.com/ggerganov/llama.cpp) | Run LLMs on your Mac | Pick one, stick with it |
| A local vector DB — [Chroma](https://www.trychroma.com), [LanceDB](https://lancedb.com), or sqlite-vec | The cold tier | Chroma is easiest |
| A Mac with M-series chip + 32 GB+ RAM | To run a useful local model | M3/M4 Pro or better is real-world fast |

You can do this on Linux too, but everything in Dom's notes assumes Mac paths.

---

## Step-by-step to your first win (90 minutes)

There is no shortcut for the full Rolodex — that is months of work. But you can stand up the *backbone* (Claude Code + local LLM + first memory tier) in an afternoon.

### 1. Install Claude Code

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Verify: `claude --version`.

### 2. Install Ollama and pull a small model

```bash
# Mac
brew install ollama
ollama serve &
ollama pull llama3.2:3b   # 2GB, runs on any M-series
```

Verify: `ollama run llama3.2:3b "Say hi in 5 words"` should reply.

### 3. Wire Claude Code to use Ollama for cheap calls

This is the critical move. Claude Code's default model is Anthropic's cloud Claude. You can layer a local model in front for the high-volume operations. Patterns Dom uses (see his Architecture doc for specifics):

- Pre-classification of incoming text → local
- Memory deduplication → local
- Conversation summarization → local
- Anything privacy-sensitive → local
- Final reasoning step on a hard query → cloud Claude

The wire-up uses MCP servers and PreToolUse hooks defined in `~/.claude/settings.json`.

### 4. Stand up your first memory tier

Start with Hot + Frozen only. Do not build all 5 tiers on day one.

```
~/.claude/memory/
├── hot/        # current conversation, ephemeral
├── frozen/     # raw archive, never deleted
└── index.md    # what is in frozen, with one-line summaries
```

The 5-tier system is what comes after the first 30 days of real use, not what you start with.

### 5. Read Dom's Architecture doc end-to-end before going further

The [anonymized architecture](https://mcguffin.duckdns.org:4547/ws/rolodex-v2/ARCHITECTURE-anonymized.md?token=74gj4kk43B7hM5VztP09ZQ) is the spec for everything beyond this point. Skim it twice. Decide which pieces you actually need before building any of them.

---

## What hurts (honest struggles)

These are the trade-offs of the local-first path. Be honest with yourself before committing.

1. **Local model quality ceiling.** Even a 70B local model is well below Claude Opus on multi-step reasoning. You will hit its limit on hard tasks. Plan to escalate to cloud Claude when reasoning matters.
2. **You own all the bugs.** No vendor support. When the vector DB drifts, when memory tiers desync, when the Mac sleeps and the daemon dies — you fix it. Forever.
3. **Mac-first means Mac-only in practice.** Cross-platform is theoretical until you maintain both. Dom's setup runs on Mac. Period.
4. **No mobile out of the box.** Cloud setups (like Chris's) get mobile via Telegram bots in a day. Local-first means you are at the desktop or you are not using the brain.
5. **Maintenance tax.** Roughly 4-6 hours per month of upkeep. Model updates, dependency churn, occasional rebuild of the index. It is not zero, even if the API spend is.

---

## When this is the right choice (and when it is not)

**Pick this if:**
- You handle regulated, medical, M&A, legal, or customer-PII data and cannot send it to a cloud LLM
- You are technical enough to debug the stack alone
- You value sovereignty over convenience
- You are on a Mac (or willing to do the porting)
- You are okay with no mobile

**Skip this if:**
- You want value in 30 minutes (use [Chris's setup](chris-claude-code.md) or [Fabian's setup](fabian-personal-ai.md))
- You are on Windows and not willing to set up WSL + Linux daemons
- You need mobile from day one
- The thought of debugging a vector DB on a Saturday makes you tired

---

## Why this matters even if you don't fork it

Dom's setup is the **counterfactual** to the Workspace-native and PAI paths. It proves that a serious operator can run a production-grade AI brain at $0/mo if they are willing to pay the engineering cost. That changes how you think about cloud lock-in, vendor risk, and data residency.

Read the architecture doc even if you never build this — it will sharpen your evaluation of the other two paths.

---

## Where to read more

- **Anonymized Architecture (Dom):** [mcguffin link above](https://mcguffin.duckdns.org:4547/ws/rolodex-v2/ARCHITECTURE-anonymized.md?token=74gj4kk43B7hM5VztP09ZQ)
- [`solutions/security-gdpr/gdpr-claude-checklist-dach.md`](../solutions/security-gdpr/gdpr-claude-checklist-dach.md) — DACH/EU compliance, where this setup shines
- [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md) — what breaks in production
- [`events/01-2026-05-11-setup-trap/slides.html`](../events/01-2026-05-11-setup-trap/slides.html) — slides 12-15 are Dom's section
- [Ollama model library](https://ollama.com/library) — what local models exist today

---

*If the link to Dom's architecture doc is broken, [open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) and tag @chris1928a — we'll get a fresh one.*
