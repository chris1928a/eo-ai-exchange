# MCP Cookbook

**Pain cluster:** Integration / MCP (10 of 85 audience members)
**Status:** Released, Event #1, 2026-05-11
**Time to complete:** 2 hours from zero MCP to 6 working integrations

> The 10 essential MCP servers every founder should run in 2026, with setup commands, gotchas, and the trend you must know about. Based on Anthropic's December 2025 donation of MCP to the Agentic AI Foundation and the 6.400+ servers now in the official registry.

---

## Why this exists

10 audience members at Event #1 named integration as their top pain: „Making everything work together", „Automation between tools", „How to link everything", „Integration mit vorhandenen Daten".

The answer in 2026 is unambiguous: MCP. The Model Context Protocol is now the de facto standard for connecting AI to your data and tools. If you are not using it, you are doing 2024 integration work in 2026.

This cookbook gets you from zero to 6 working integrations in one focused afternoon.

---

## The 2026 trend you must know

**Anthropic donated MCP to the Agentic AI Foundation (AAIF) in December 2025.** AAIF is a directed fund under the Linux Foundation, co-founded by Anthropic, Block, and OpenAI, with support from Google, Microsoft, AWS, Cloudflare, and Bloomberg.

This is the „Linux moment" for AI integration. MCP is now neutral, governed openly, and adopted by every major player. There is zero vendor lock-in risk.

**The numbers (April 2026):**
- 6.400+ MCP servers in the official registry as of February 2026
- 10.000+ community MCP servers published in total
- 97 million MCP installs since late 2024
- 22.200 monthly US searches for „Model Context Protocol" (mainstream awareness)

**The practical implication:** You no longer build custom integrations. You install MCP servers, configure credentials, and your agent has the same access you do.

---

## Step 1, install MCP support in Claude Code

If you completed [30-Min aiOS Blueprint](../setup-itself/30-min-aios-blueprint.md), you already have Claude Code. MCP support is built in.

Verify:
```bash
claude mcp list
```

Should return empty list initially. If error, upgrade Claude Code: `claude upgrade`.

---

## Step 2, the 6 essential MCP servers

**Practical limit:** Run no more than 4-6 MCP servers per session. More than that confuses Claude's tool selection. Be selective.

These 6 cover 90% of founder workflows:

### 1. Notion MCP (official)

Read/write your knowledge base, plans, decisions, briefs.

```bash
claude mcp add notion @makenotion/notion-mcp-server \
  --env NOTION_API_KEY=secret_xxx
```

Get API key: Notion → Settings → Connections → Integrations → Create new internal integration. Share specific pages with the integration (do NOT use Member-upgrade, which costs €12/user unnecessarily).

### 2. Gmail MCP (Google official via gws)

Read, draft, label, send emails.

```bash
npm install -g @google/gws
claude mcp add gmail gws \
  --env GOOGLE_CREDENTIALS=path/to/credentials.json
```

OAuth flow in browser on first use. Scope: gmail.readonly + gmail.modify.

### 3. Google Calendar MCP (Google official via gws)

Read schedule, create events, find availability.

```bash
claude mcp add calendar gws --service calendar
```

### 4. Google Drive MCP (Google official via gws)

Read documents, find files, upload outputs.

```bash
claude mcp add drive gws --service drive
```

### 5. Slack MCP (community-maintained)

Read channels, post messages, search history.

```bash
claude mcp add slack @modelcontextprotocol/server-slack \
  --env SLACK_BOT_TOKEN=xoxb-xxx \
  --env SLACK_TEAM_ID=Txxx
```

### 6. GitHub MCP (official)

Read repos, write code, manage PRs and issues.

```bash
claude mcp add github @github/github-mcp-server \
  --env GITHUB_TOKEN=ghp_xxx
```

---

## Step 3, the 4 specialty MCPs (add when needed)

These are not for everyone. Add only when you have the specific workflow:

### Stripe MCP (e-commerce / SaaS)
```bash
claude mcp add stripe @stripe/mcp-server \
  --env STRIPE_API_KEY=sk_xxx
```

### HubSpot MCP (sales pipeline)
```bash
claude mcp add hubspot @hubspot/mcp-server \
  --env HUBSPOT_TOKEN=xxx
```

### Zapier MCP (legacy automation bridge)
```bash
claude mcp add zapier @zapier/mcp-server \
  --env ZAPIER_NLA_KEY=xxx
```

### Apify / Octoparse MCP (web scraping)
```bash
claude mcp add apify @apify/mcp-server \
  --env APIFY_TOKEN=xxx
```

---

## Step 4, verify your stack

```bash
claude mcp list
```

Should return your installed servers. Test each:

```bash
claude
> Use notion to find my page about Q2 priorities
> Use gmail to show unread emails from today
> Use calendar to show my next 3 events
```

If any fails: check credentials, check OAuth scope, check `claude mcp logs <server>`.

---

## When to use MCP vs Zapier vs custom code

| Situation | Use |
|---|---|
| Read/write to a tool you already use | MCP, always |
| Trigger workflow on event (webhook) | Zapier or n8n |
| Cross-system multi-step transformation | MCP + Claude Agent (cognitive) + Zapier (orchestration) |
| Real-time streaming, sub-second latency | Custom code |
| One-off batch job | Claude Code with MCP, no Zapier needed |
| 100k+ API calls/day | Custom backend with Claude API directly |

The 2026 default: MCP for cognitive work, Zapier/n8n for ETL only when you need event-driven triggers.

---

## Common gotchas

**1. Tool name collisions.** If 2 MCP servers expose a tool called „search", Claude may pick the wrong one. Use server-prefixed naming in your prompts: „use github.search" instead of „search".

**2. Credential rotation.** OAuth tokens expire. Set calendar reminders quarterly to refresh. Or use long-lived API keys where supported.

**3. Rate limits.** Notion API: 3 req/sec. Gmail: 250 quota units/sec. Slack: tier-dependent. If you hit limits, your agent stalls. Add retry-with-backoff in skills.

**4. Permission scope creep.** Default OAuth scopes are often broader than needed. Audit + scope down. Notion should be limited to specific pages, not whole workspace.

**5. Multiple-account confusion.** If you have personal + business Gmail, MCP gets confused. Set up per-context configurations: `~/.claude/mcp/personal/` and `~/.claude/mcp/business/`.

---

## The 5-minute test, are you ready for MCP?

If you cannot answer YES to ALL of these, get the basics first:
- Do I have Claude Code installed and working?
- Do I have a CLAUDE.md file with my context?
- Do I have at least 1 working skill?
- Do I have an OAuth/API workflow I am comfortable with (5 min setup max per service)?
- Do I have a specific cross-tool workflow in mind I want to automate?

If you said NO to any: complete [30-Min aiOS Blueprint](../setup-itself/30-min-aios-blueprint.md) first.

---

## Companion skill

The companion runnable skill `mcp-installer` ([skills/mcp-installer/](../../skills/mcp-installer/)) automates this entire flow: detects your existing tool stack, recommends MCP servers, walks you through OAuth, and validates the setup.

Coming Event #2.

---

## Anti-patterns to avoid

- **„Install all 20 MCP servers I see online."** Limit 4-6 active per session. More confuses tool selection.
- **„MCP replaces Zapier."** It does not. MCP is for cognitive integration, Zapier for event-driven triggers. Use both.
- **„Skip OAuth, paste credentials directly."** Credential leak in 6 weeks guaranteed. Always vault.
- **„Custom MCP for tools that have no MCP yet."** Wait 90 days. The registry adds 100+ servers/month. Most tools will have official MCP by Q3 2026.
- **„Run MCP on production without monitoring."** MCP calls are API calls = cost + rate limits. Log everything.

---

## Sources

- [Anthropic, Donating MCP to Agentic AI Foundation](https://www.anthropic.com/news/donating-the-model-context-protocol-and-establishing-of-the-agentic-ai-foundation)
- [Linux Foundation, Agentic AI Foundation Announcement](https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation)
- [MCP Blog, MCP Joins AAIF](https://blog.modelcontextprotocol.io/posts/2025-12-09-mcp-joins-agentic-ai-foundation/)
- [MindStudio, Connect Claude Code to Notion Gmail MCP](https://www.mindstudio.ai/blog/mcp-servers-connect-claude-code-notion-gmail)
- [Octoparse, 11 Best MCP Servers 2026](https://www.octoparse.com/blog/best-mcp-servers)
- [Composio, Notion MCP Integration with Claude Code](https://composio.dev/toolkits/notion/framework/claude-code)
- [Notion Docs, Connecting to Notion MCP](https://developers.notion.com/guides/mcp/get-started-with-mcp)
- [Claude Code Docs, MCP Connection](https://code.claude.com/docs/en/mcp)
- [Pento, Year of MCP, From Internal Experiment to Industry Standard](https://www.pento.ai/blog/a-year-of-mcp-2025-review)
- [The Next Web, Rise of MCP in the Agentic Era](https://thenextweb.com/news/rise-of-model-context-protocol-in-the-agentic-era)

---

*Author: Christoph Erler (EO Berlin) + Dominik Raute (CTO JustWatch). Date: 2026-05-11. Tested with Claude Code on Mac. All 6 essential MCPs verified working April 2026.*
