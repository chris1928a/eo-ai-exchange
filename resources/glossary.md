# Glossary, in plain language

Quick definitions for the terms that show up across this repo. Aimed at operators who are new to the AI-tooling stack. No jargon, no condescension.

If a term you need is missing, [open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) and we will add it.

---

## Claude

The large language model from Anthropic. The current top-tier models (as of 2026-05) are **Opus 4.7** (best reasoning), **Sonnet 4.6** (balanced default), and **Haiku 4.5** (fastest, cheapest). When people in this repo say "Claude," they usually mean either the model itself or the consumer app at [claude.ai](https://claude.ai).

## Claude Code (in slides: "OpenClaw")

Anthropic's official command-line tool that runs Claude on your machine. It can read your files, edit them, run commands, and call external services. It is the backbone of all three setups in this repo. Free to install at [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview). Installs as a CLI command called `claude`.

> **Why "OpenClaw" in the slides?** Chris uses "OpenClaw" as a working code-name in some materials. It is the same thing as Claude Code.

## Skill

A reusable instruction set Claude Code can invoke on demand. Lives as a `SKILL.md` file in `~/.claude/skills/<skill-name>/`. The file's frontmatter has a `description` field — that description is what tells Claude *when* to trigger the skill. Bad description = skill never triggers. Skills replace one-off prompts: write it once, reuse forever. See [docs.claude.com/skills](https://docs.claude.com/skills).

## MCP (Model Context Protocol)

The open protocol that lets Claude (and other LLMs) talk to external tools and data sources. Each external system you wire in is one **MCP server**. Examples: Gmail MCP, Notion MCP, GitHub MCP, your-database MCP. Think of MCP as "USB for LLMs." Spec at [modelcontextprotocol.io](https://modelcontextprotocol.io).

## MCP Server

One specific external integration. You install MCP servers individually. Each gives Claude a fixed set of read/write capabilities into one external system. Chris runs 31. Most people should start with 3-5. The [MCP Cookbook](../solutions/integration-mcp/mcp-cookbook.md) lists the 10 most useful ones.

## Hook

A piece of automation that fires on a specific event in Claude Code. Defined in `~/.claude/settings.json`. Common events: `PreToolUse` (before Claude runs a tool), `PostToolUse` (after), `Stop` (when Claude finishes a turn), `UserPromptSubmit` (when you press enter). Hooks are how you add guardrails — e.g. block any `rm -rf` command, or auto-format code after every edit.

## Memory

Plain Markdown files that capture what Claude should remember across conversations. Live in `~/.claude/projects/<project>/memory/`. Four common types:
- **user** — who you are, your role, your preferences
- **feedback** — corrections you have given Claude ("don't do X")
- **project** — current work context, deadlines, stakeholders
- **reference** — pointers to where information lives outside the project

If you skip memory, every conversation starts cold. Memory is the single highest-leverage thing to set up.

## Subagent / Agent

A second Claude session spawned by your main Claude session to handle a specific task in parallel or in isolation. Useful for: research that would bloat your main context, parallel tool calls, or running something risky without polluting the parent conversation. Each subagent has its own scoped tools and memory.

## Worktree

A Git feature, supported natively by Claude Code, that creates a temporary isolated copy of your repo for one task. Used so an agent can experiment without touching your live working directory. Cleanup is automatic if no changes were made.

## Slash command

A user-typed shortcut starting with `/` that triggers a Skill or built-in action in Claude Code. Examples: `/morning-brief`, `/audit-memory`, `/help`, `/clear`. Skills become slash commands by virtue of where they are filed.

## CLAUDE.md

A project-level instruction file Claude Code automatically loads at the start of every conversation in that directory. Think of it as the README that Claude reads instead of the human. Use it for project-specific style, conventions, "always do X here, never do Y here" rules. One per project, optional.

## Settings.json

The configuration file at `~/.claude/settings.json` that controls Claude Code's behavior. Hooks, permissions, environment variables, MCP server registrations all live here. Keep it short. A bloated `settings.json` is one of the most common sources of mysterious breakage.

## Permission mode

Controls whether Claude Code asks before running tools. Modes range from "ask every time" to "auto-allow read-only" to "fully autonomous." Set per-session or in `settings.json`. Auto-allowing destructive operations is how people lose work. Default to ask-first for anything that writes or deletes.

## API vs Pro vs Enterprise

Three ways to pay for Claude:
- **Pro** — flat $20/mo, browser app + Claude Code, fair usage limits, retention applies
- **API** — pay per token, higher control, retention applies (default 7 days)
- **Enterprise / Bedrock / Vertex** — custom contract, can include Zero Data Retention (ZDR), regional residency (e.g. AWS Frankfurt for EU), DPA signed

For DACH/regulated industries, the route is API via AWS Bedrock EU Frankfurt or Google Vertex AI EU regions. See [GDPR Claude Checklist DACH](../solutions/security-gdpr/gdpr-claude-checklist-dach.md).

## ZDR (Zero Data Retention)

A configuration on the Claude API where Anthropic does not store your prompts or responses after the request completes. Available on Enterprise contracts. Apply via Anthropic Sales. Required for any sensitive data you send to Claude.

## Telos / ISA / TRIOT (PAI-specific)

Daniel Miessler's framing inside the PAI architecture:
- **Telos** — your ideal state across life and work
- **ISA** (Ideal State Artifact) — a document expressing your Telos in concrete, verifiable terms
- **TRIOT** (The Real Internet of Things) — Miessler's 2016 framing where every product/person/place gets an API and your Digital Assistant assembles interfaces dynamically

Only relevant if you are running [PAI](../setups/fabian-personal-ai.md). Skip otherwise.

## Vector DB

A database optimized for similarity search over embeddings (numerical representations of text/images). Used to give an LLM "memory" over thousands of unstructured documents. Common picks: Chroma, LanceDB, sqlite-vec, Pinecone (cloud). Most personal setups can skip this entirely until they have 10.000+ unstructured docs — Markdown files in folders work shockingly well below that threshold.

## Embedding

A numerical vector that represents a chunk of text, an image, or another asset, in a way that allows similarity comparison. Embeddings are what go into a vector DB. You generate them with an embedding model (e.g. OpenAI's `text-embedding-3-small` or a local one).

## Local model

An LLM running on your own hardware (your laptop, your server) instead of on a vendor's cloud. Tools that make this easy: [Ollama](https://ollama.com), [LM Studio](https://lmstudio.ai), [llama.cpp](https://github.com/ggerganov/llama.cpp). Quality ceiling is below cloud Claude on hard reasoning, but the data never leaves your machine and the marginal cost is $0. The foundation of [Dom's setup](../setups/dom-rolodex.md).

## CVE-2026-25253

The OpenClaw (Claude Code) security vulnerability discussed at Event #1 and detailed in [openclaw-honest-assessment.md](../solutions/openclaw-honest/openclaw-honest-assessment.md). Cited as a worked example of how agentic systems can fail in production. Read the assessment before trusting any agent with destructive operations.

## EU AI Act

The European regulation governing AI systems. **Full effect: 2026-08-02.** Affects any system serving EU users, including AI-enabled features in B2B SaaS. The [GDPR Claude Checklist DACH](../solutions/security-gdpr/gdpr-claude-checklist-dach.md) covers the practical impact.

## DPA (Data Processing Agreement)

The legal contract between you (data controller) and a vendor (data processor) under GDPR. Anthropic signed an updated DPA in January 2026 that covers most legitimate enterprise use of Claude in the EU. You still need to sign it on your end and configure data flow correctly.

---

## Acronym soup, fast lookup

- **API** — Application Programming Interface
- **CLI** — Command Line Interface
- **CVE** — Common Vulnerabilities and Exposures (the public security advisory naming scheme)
- **DA** — Digital Assistant (PAI term)
- **DACH** — Germany + Austria + Switzerland
- **DPA** — Data Processing Agreement (GDPR)
- **DSGVO** — German for GDPR
- **GDPR** — General Data Protection Regulation
- **ICP** — Ideal Customer Profile
- **JTBD** — Jobs To Be Done
- **LLM** — Large Language Model
- **MCP** — Model Context Protocol
- **PAI** — Personal AI Infrastructure (Daniel Miessler's framework)
- **PRD** — Product Requirements Document
- **VC** — Venture Capital
- **WSL** — Windows Subsystem for Linux
- **ZDR** — Zero Data Retention

---

*Missing a term? [Open an issue](https://github.com/chris1928a/eo-ai-exchange/issues) tagged `glossary`.*
