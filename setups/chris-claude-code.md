# Setup 1 — Chris's Workspace-Native Claude Code

> **The 30-second pitch.** [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) wired into Google Workspace via 31 MCP tools, with 19 reusable Skills and 125 memory files. Mobile access via a Telegram bot. ~150 EUR/month all-in. ~23 hours per week saved, tracked over 8 weeks.

**Maintained by:** Christoph Erler ([erlerventures.org](https://erlerventures.org))
**Companion deck:** [chris-demo.html](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides, body-mapped tool snapshots)
**Pain clusters this addresses:** Setup Itself, Tool Overload, Integration, Pace
**Cost:** ~150 EUR/mo all-in

---

## Who this is for

- You live inside Google Workspace (Gmail, Calendar, Drive, Docs, Sheets, Meet)
- You want AI everywhere, including on mobile
- You are fine paying ~150 EUR/month for the convenience
- You are willing to invest 30-60 hours up-front to get the foundation right

If you want a complete opinionated Life OS, see [Fabian's setup](fabian-personal-ai.md).
If you want zero ongoing cost and full sovereignty, see Dom's local-first path — full doc refreshing, [slides 13-15](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13) cover the architecture.

---

## What you get

| Component | Count / Detail |
|---|---|
| Tooling backbone | [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) CLI |
| MCP tools wired in | 31 (Gmail, Calendar, Drive, Notion, Deepgram, etc.) |
| Skills | 19 (`/morning-brief`, `/audit-memory`, etc.) |
| Memory files | 125 (user / feedback / project / reference) |
| Mobile | Telegram bot on AWS Lightsail Frankfurt (~10 EUR/mo) |
| Hours saved per week | ~23h (8-week tracked sample) |
| Total monthly cost | ~150 EUR |

---

## Step-by-step to your first win (60 minutes)

### 1. Install Claude Code

```bash
# Mac / Linux
curl -fsSL https://claude.ai/install.sh | bash

# Windows: install WSL first, then run the same command inside WSL
```

Verify: `claude --version`. Reference: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview).

### 2. Write your first memory file

Create `~/.claude/projects/<your-project>/memory/MEMORY.md`:

```markdown
- [About me](user_about.md) — name, role, what I'm working on this quarter
```

Then create `~/.claude/projects/<your-project>/memory/user_about.md`:

```markdown
---
name: About me
description: Who I am and what I'm working on right now
type: user
---

I am [name]. I run [company]. My current focus is [thing].
My goals this quarter are: [3 bullets].
```

Claude now reads this every conversation in that project.

### 3. Connect Gmail as your first MCP tool

From Claude Code:

```
/mcp
```

Pick **Gmail**, follow the OAuth flow. Verify by asking Claude: *"List my unread emails from today."*

### 4. Write your first skill

Create `~/.claude/skills/morning-brief/SKILL.md`:

```markdown
---
name: morning-brief
description: Give me a 5-bullet brief on today — calendar, top emails, news. Trigger when I say "morning brief", "what's on today", or "brief me".
---

Pull from:
1. Calendar today (next 8 hours)
2. Gmail unread top 5
3. Any news headlines I subscribed to in /resources/news-feeds.md

Output: 5 bullets max. No fluff. Lead with what needs my decision today.
```

Type `/morning-brief` in Claude Code. You have a working personal AI.

### 5. (Optional) Mobile via Telegram

Spin up an AWS Lightsail VM in Frankfurt (~10 EUR/mo). Run a small Node bot that listens to Telegram, forwards messages to a `claude` session, posts replies back. Detailed playbook in [`solutions/setup-itself/30-min-aios-blueprint.md`](../solutions/setup-itself/30-min-aios-blueprint.md).

---

## What hurts (honest struggles)

1. **Memory drift.** Memory files go stale within weeks if you don't audit them. Run a weekly `/audit-memory` skill or the brain runs on lies.
2. **MCP server count.** 31 is too many. Most go untouched for weeks. Start with 5, add only when a real need surfaces.
3. **Skill description quality.** A skill with a bad description never triggers. The trigger sentence is 80% of the work.
4. **Cost spikes during build-up.** Real number: $50/day Opus burn for 2 to 4 weeks while iterating. Steady state is much lower.
5. **Vendor roadmap risk.** Anthropic changes the CLI quarterly. Three times in 2026 my settings.json broke on a release. Pin a version if you cannot tolerate that.

---

## When this is the right choice (and when it is not)

**Pick this if:**
- You live in Google Workspace and want everything there
- You need mobile access from day one
- You can pay ~150 EUR/mo for convenience
- You want to *own* the setup and iterate forever, not buy a SaaS

**Skip this if:**
- You handle data that cannot leave your machine (Dom's local-first path — doc refreshing, see [slides 13-15](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html#13))
- You want a complete Life OS out of the box (use [Fabian's PAI setup](fabian-personal-ai.md))
- You are not willing to maintain a personal stack ongoing

---

## Sources

- Live deck: [`chris-demo.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html) (44 slides)
- Abbreviated build playbook: [`solutions/setup-itself/30-min-aios-blueprint.md`](../solutions/setup-itself/30-min-aios-blueprint.md)
- What breaks in production: [`solutions/openclaw-honest/openclaw-honest-assessment.md`](../solutions/openclaw-honest/openclaw-honest-assessment.md)
- Claude Code docs: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview)
