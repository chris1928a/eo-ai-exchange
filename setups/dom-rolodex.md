# Setup 2 — Dom's Local-First Rolodex (built on OpenClaw)

> **The 30-second pitch.** [OpenClaw](../solutions/openclaw-honest/openclaw-honest-assessment.md) as backbone, custom memory layer running on local models on a Mac, indexed across 1.183 files and 107 contacts. ~$0/month marginal cost.

**Maintained by:** Dominik Raute (CTO, JustWatch)
**Architecture deep dive (anonymized, by Dom):** *Link temporarily offline — fresh URL coming from Dom. [Open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) if you need it urgently and we'll get one to you.*
**Pain clusters this addresses:** Cost, Security/GDPR, Reliability
**Live demo:** Demo 2 at [Event #1](../events/01-2026-05-11-setup-trap/README.md), see slides 12-15 of [`slides.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html)

> **Heads-up directly from Dom:** *"die richtig interessanten Parts sind relativ hart verdrahtet mit den lokalen Modellen auf meinem Mac"* — the high-value pieces are hardwired to his specific setup. His doc is best read as inspiration and architecture reference, not a step-by-step.

---

## What Dom shared at the event

- **Backbone:** vanilla [OpenClaw](../solutions/openclaw-honest/openclaw-honest-assessment.md) (workflow orchestration layer, no fork, no patch)
- **Memory:** custom 5-tier layer Dom built (tier names and definitions live in his Architecture doc)
- **Models:** local LLMs on his Mac, with cloud Claude only when reasoning depth is needed
- **The Rolodex (v2):** 1.183 files indexed, 107 people tracked, all searchable, all local
- **Cost:** ~$0/month marginal (compute is hardware Dom already owns)

For exact tier definitions, model choices, and wire-up details, **read [Dom's anonymized architecture doc](https://github.com/chris1928a/eo-ai-exchange/issues) when the link is back online**. This file does not paraphrase him beyond what he shared on stage.

---

## Who this is for

- You handle data that cannot or should not leave your machine
- You are technical enough to debug a custom stack alone
- You are on a Mac (Dom's setup is Mac-first)
- You want to study a working local-first architecture before deciding what to build

If you want a Workspace-native cloud setup, see [Chris's setup](chris-claude-code.md).
If you want an opinionated prebuilt Life OS, see [Fabian's setup](fabian-personal-ai.md).

---

## When this is the right choice (and when it is not)

**Pick this if:**
- You handle regulated, medical, M&A, legal, or customer-PII data
- You are comfortable maintaining a custom stack
- You value sovereignty over convenience
- You are on a Mac (or willing to do the porting)

**Skip this if:**
- You want value in 30 minutes (use [Chris's setup](chris-claude-code.md) or [Fabian's setup](fabian-personal-ai.md))
- You need mobile from day one (this setup is desktop-first)
- You don't already use OpenClaw and don't want to learn it

---

## Honest caveats about OpenClaw itself

If you adopt OpenClaw for your own backbone, read [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md) first. CVE-2026-25253 (CVSS 8.80, HIGH severity) and the ClawHavoc supply chain incident (1.184 malicious packages on ClawHub) are real and recent. Five alternatives — NanoClaw, ZeroClaw, Skyvern, Nanobot, OpenFang — are documented in the same file.

---

## Sources

- **Dom's anonymized Architecture doc** (the actual spec) — *link refreshing, see top of file*
- Live deck slides 12-15: [`events/01-2026-05-11-setup-trap/slides.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html)
- OpenClaw security baseline: [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md)

---

*This file describes only what Dom shared publicly at Event #1. No invented details, no speculation. For the technical depth, the Architecture doc is the source — once the link is back, it goes here.*
