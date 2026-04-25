# 30-Min aiOS Blueprint

**Pain cluster:** Setup itself (7 explicit + 30+ indirect of 85)
**Status:** Released, Event #1, 2026-05-11
**Time to complete:** 30 minutes from zero to working aiOS

> The state-of-the-art way to build a personal AI operating system in 2026, based on Anthropic's Claude Code best practices, the 1.234+ community-skill ecosystem, and the trend toward composable agent stacks.

---

## Why this exists

7 audience members at Event #1 wrote „Setup" or variations as their primary pain. 30+ more wrote adjacent pains („time to implement the set up", „finding the right setup", „how to link everything").

The reason most setups fail: founders treat AI as a tool problem instead of a memory + composition problem. In 2026, the answer is not „pick the best tool". The answer is build a **persistent context system** before you prompt for anything.

This blueprint takes you from zero to working aiOS in 30 minutes.

---

## The 4-layer architecture (state of the art, April 2026)

```
LAYER 4: AGENTS + MCP        ← What runs work for you autonomously
            ↑
LAYER 3: HOOKS               ← Deterministic behavior, guardrails, post-actions
            ↑
LAYER 2: SKILLS              ← Composable playbooks (1 skill = 1 repeatable task)
            ↑
LAYER 1: CLAUDE.md + VOICE   ← Persistent identity, who you are, what matters
```

The trend in 2026 is **unbundling**: stop using monolithic AI platforms, assemble your stack from composable pieces. CLAUDE.md is the highest-leverage file in your stack because every other layer reads from it.

---

## Step 1, install Claude Code (5 min)

Mac: `brew install anthropic/claude/claude-code`
Win: download from `code.claude.com` and run installer
Linux: `curl -fsSL https://claude.ai/install.sh | sh`

Authenticate: `claude auth login` (opens browser, requires Claude Pro or API key).

---

## Step 2, create your CLAUDE.md (10 min)

In any directory you will work from (suggest your home directory, NOT inside a code repo, since this is your personal aiOS):

```bash
cd ~
touch CLAUDE.md
code CLAUDE.md  # or vim, nano, whatever you use
```

Use this template, replace bracketed sections:

```markdown
# CLAUDE.md, [Your Name]'s Personal aiOS

## Who I am
- Role: [e.g. Founder of XYZ, ex-COO of ABC]
- Companies: [list of current ventures]
- Time zone + location: [e.g. Berlin, CEST]
- Primary working language: [English / Deutsch / both]

## What I prioritize this quarter
1. [Top quarter goal, 1 sentence]
2. [Second goal]
3. [Third goal]

## Decisions already made (do not re-litigate)
- [Decision 1, e.g. „We use Claude over ChatGPT for thinking work"]
- [Decision 2, e.g. „Email triage runs daily 7am, no exceptions"]
- [Decision 3]

## Hard constraints
- Never expose: [list secrets, sensitive data types]
- Always confirm before: [list destructive actions]
- Never recommend: [list anti-patterns specific to your work]

## My biggest current goal
[One sentence. The thing you would sacrifice 80% of other work to achieve.]
```

**Why this works:** Claude reads CLAUDE.md before every session, so the agent knows who you are without re-priming. This is the difference between „agent that helps with one task" and „agent that operates as your context-aware assistant".

---

## Step 3, create your Voice file (5 min)

Voice is separate from CLAUDE.md because it changes more slowly and is more personal.

```bash
touch ~/VOICE.md
```

Template:

```markdown
# VOICE.md, How [Your Name] writes

## Beliefs (the contrarian ones)
- [Strong opinion 1, e.g. „Memory > Tools > Models, always"]
- [Strong opinion 2]
- [Strong opinion 3]

## Sentence rhythm
- Prefer: short sentences, active voice, concrete nouns
- Avoid: passive voice, em-dashes, „in fact", „certainly", „undoubtedly"
- German texts: Umlaute always (ä, ö, ü, ß), never ae/oe/ue/ss substitutes

## Things I find cringe
- [List 5-10 phrases or patterns you would never use]

## Tone calibration
- Internal team: direct, no fluff
- Customer-facing: warm but specific
- Investor-facing: data-first, claim-first
- Public (LinkedIn, Substack): contrarian, evidence-backed
```

**Why this works:** The default LLM voice is generic. Your Voice file collapses your style into a reusable spec. Every email, post, draft Claude writes will sound like you, not like ChatGPT.

---

## Step 4, install your starter skills (5 min)

The community-maintained skill libraries hit 1.234+ skills in 2026. Install the 5 essential starters:

```bash
# Anthropic-official
claude skills install anthropic/frontend-design  # 277k+ installs, optional unless you build UI

# Composio's awesome-claude-skills (curated index)
claude skills install composio/build-test-verify
claude skills install composio/create-pull-request
claude skills install composio/core-conventions
claude skills install composio/web-research
claude skills install composio/email-triage  # the universal founder skill
```

These 5 cover the most common workflows. You will add more over time as your patterns emerge.

**Browse the full index:**
- [Composio's awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) (curated)
- [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) (232+ skills, multi-agent compatible)

---

## Step 5, write your first custom skill (5 min)

The pattern that makes aiOS work: when you do a task 3+ times, turn it into a skill.

```bash
mkdir -p ~/.claude/skills/daily-brief
touch ~/.claude/skills/daily-brief/SKILL.md
```

Template:

```markdown
---
name: daily-brief
description: Generate Chris's morning brief from calendar + email + open tasks
trigger: "daily brief", "morning brief", "what's today"
---

# Daily Brief Skill

When triggered, do the following:

1. Pull today's calendar events from Google Cal (use gws MCP)
2. Pull unread email from Gmail with priority labels
3. Pull open Notion tasks tagged „today"
4. Pull yesterday's open commitments from yesterday's brief
5. Format as a 1-page brief:
   - Top 3 priorities (deduce from CLAUDE.md current quarter goals)
   - Calendar with prep notes
   - Email triage queue (max 5)
   - Yesterday-carryover

Output format: Plain markdown. No headers above H2. Bullet points only.

Constraints:
- Never include subjects or names from sensitive emails (legal, medical, M&A)
- Always reference CLAUDE.md priorities, not LLM-inferred priorities
- If a calendar event has no prep note in CLAUDE.md context, flag it explicitly
```

**Trigger pattern:** When you ask Claude „daily brief" or „morning brief", it reads SKILL.md, executes the steps, returns the brief. No re-priming needed.

---

## Step 6, optional, add Hooks for guardrails

Hooks are deterministic rules that fire before/after agent actions. Examples:

- Pre-write hook: never modify CLAUDE.md without confirmation
- Post-action hook: log every API call to a daily audit file
- Pre-execute hook: refuse to run any shell command containing `rm -rf` without confirmation

Skip this in the first 30 min, add when you have 4+ weeks of usage data telling you what guardrails matter.

---

## What this gets you

After 30 minutes, you have:
- An agent that knows who you are (CLAUDE.md)
- An agent that writes in your voice (VOICE.md)
- 5 working skills covering universal workflows
- 1 custom skill (daily-brief) showing the pattern
- A foundation that survives model changes (everything is markdown, model-agnostic)

What you do NOT have yet:
- MCP integrations (next 30-60 min, see [MCP Cookbook](../integration-mcp/mcp-cookbook.md))
- Long-running agents (Layer 4, see [Agent Reliability Checklist](../agents/agent-reliability-checklist.md))
- Memory architecture beyond CLAUDE.md (advanced, comes after 4-6 weeks of usage)

---

## The 2026 trend you should know about

**The agent stack is unbundling.** Monolithic platforms (think Lindy, OpenClaw) are losing ground to composable stacks (Claude Code + Skills + MCP). The reason: composable stacks survive model changes and vendor changes. Monolithic platforms force you to migrate everything when their roadmap diverges from yours.

**Memory is the next frontier.** Vector databases, knowledge graphs, and memory-centric OS layers are emerging as the answer to the „amnesia problem" in LLMs. Google's TurboQuant (March 2026) achieved 6x KV-cache compression. Within 12 months, expect Claude/GPT/Gemini to ship persistent memory natively. Your skills + CLAUDE.md investment will translate forward.

**Local-first is mainstream demand.** On-device inference, self-hosted knowledge bases, and privacy-preserving AI tools represent 700K+ GitHub stars collectively. If you handle sensitive data, build with local-first in mind from day 1.

---

## Anti-patterns to avoid

- **Skipping CLAUDE.md** because „I will write it later". You will not. Without it, every session is amnesiac.
- **Installing 50 skills before you have 1 working workflow.** Skill bloat is real. Start with 5, add only when proven.
- **Writing skills without trigger patterns.** A skill that needs prompting is just a doc. Triggers make it autonomous.
- **Using Voice file to encode politeness.** Voice = your style, not your manners. Manners go in CLAUDE.md hard constraints.

---

## Sources

- [Claude Code Best Practices, official](https://code.claude.com/docs/en/best-practices)
- [Extend Claude with Skills, official](https://code.claude.com/docs/en/skills)
- [Agent Skills, Claude API Docs](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
- [Claude Best Practices Power User Guide 2026](https://www.the-ai-corner.com/p/claude-best-practices-power-user-guide-2026)
- [Composio, Awesome Claude Skills GitHub](https://github.com/ComposioHQ/awesome-claude-skills)
- [Composio, Top 10 Claude Code Skills 2026](https://composio.dev/content/top-claude-skills)
- [Matthew Groff, Implementing CLAUDE.md and Agent Skills](https://www.groff.dev/blog/implementing-claude-md-agent-skills)
- [Amit Ray, CLAUDE.md vs Agents.md vs Memory.md Hierarchy 2026](https://amitray.com/claude-md-vs-agents-md-memory-md-skills-md-context-md-guide-2026/)
- [alirezarezvani, claude-skills 232+ skills](https://github.com/alirezarezvani/claude-skills)
- [Vela Partners, 19 Open-Source AI Infrastructure Trends 2026](https://www.vela.partners/blog/emerging-open-source-ai-infrastructure-trends-2026)
- [Bessemer, AI Infrastructure Roadmap 2026](https://www.bvp.com/atlas/ai-infrastructure-roadmap-five-frontiers-for-2026)

---

*Author: Christoph Erler (EO Berlin). Date: 2026-05-11. Tested with Claude Code on Mac, Win, Linux. Skill ecosystem references valid as of April 2026.*
