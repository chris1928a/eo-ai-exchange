# Agent Reliability Checklist

**Pain cluster:** Agents (15 of 85 audience members)
**Status:** Released, Event #1, 2026-05-11 (foundation), full deep-dive at Event #2
**Time to complete:** 2-4 hours from prototype to production-ready

> 12 reality-checks before you put any agent in front of a customer or a real workflow. Based on Anthropic's published research, the April 2026 Managed Agents launch, and the production patterns emerging from LangGraph deployments at 1.000+ employee companies.

---

## Why this exists

15 audience members at Event #1 named some form of agent pain: „Agent Orchestration", „using Agents in a secure way", „autonomous systems", „Setting up an agent team", „agent value optimization".

The dominant failure: founders prototype an agent that works once in a demo, then deploy it to production where it breaks within 2 weeks. The fix is not better prompting. The fix is **production discipline**.

This checklist is the production discipline.

---

## The 2026 trend you must know

**Anthropic launched Claude Managed Agents in public beta on April 8, 2026.** This changes the game for solo operators and small teams: the infrastructure overhead that previously required a DevOps team (sandboxing, checkpointing, credential management, scoped permissions, end-to-end tracing) is now a managed service.

**LangGraph appears in 34% of production architecture documents at companies with 1.000+ employees in Q1 2026.** It is the de facto framework for complex multi-agent orchestration. CrewAI wins on ease of entry. Anthropic SDK wins on Claude-native simplicity.

**The Model Context Protocol (MCP) is now governed by the Agentic AI Foundation**, backed by Anthropic, OpenAI, Google, Microsoft, AWS, Block, Cloudflare, and Bloomberg. MCP is now the industry-standard integration layer.

**The trend in one sentence:** the gap between agent-prototype and agent-in-production is closing fast. Discipline beats framework choice.

---

## The 12-point checklist

Tick each box before deploy. Skipping any is a known production-failure mode.

### Architecture (4 points)

**1. Single agent or multi-agent?**
Default: single agent with tools. Multi-agent only when you can prove independent failure modes for each agent. „Multi-agent" is the most over-engineered choice in 2026. Anthropic's own research: start simple, prove necessity, then add complexity.

**2. Framework matches your scale?**
- 1 person, Claude-only: Claude Agent SDK. Lightest weight, ships fast.
- Small team, multi-model: CrewAI. Easiest learning curve, role-based.
- Production at scale: LangGraph. Most adopted, most stateful, most observable.
- Enterprise with infra team: also consider OpenAI Agents SDK or Google ADK.

**3. Memory layer designed before agent built?**
Most agent failures are memory failures masquerading as logic failures. Decide upfront:
- What state survives session-end? (= persistent memory)
- What state survives only within session? (= scratchpad)
- What state must NEVER survive? (= secrets, PII)

If you cannot answer these 3, do not write a line of code.

**4. Self-correcting feedback loop in place?**
Per Anthropic research: agents that check and improve their own output are fundamentally more reliable. Build in:
- Output validation against explicit rules
- Failure-mode logging
- Retry logic with bounded attempts (3-5 max)

The best feedback loops are rules-based (linting analog), not LLM-judge-based.

---

### Reliability (4 points)

**5. Checkpoint strategy defined?**
Long-running agents (anything > 10 min execution time) MUST checkpoint after each significant step. Claude Managed Agents does this natively. If self-hosted: write checkpoints to disk after each tool call.

**6. Independent failure recovery?**
The Claude Managed Agents architecture pattern: harness, sandbox, session are independent. If harness crashes, new harness picks up session log. If sandbox dies, session survives. Replicate this pattern in self-hosted: 3 layers, each fails independently, none brings down the other 2.

**7. Initializer agent for first session?**
First session sets up environment + progress log. Subsequent sessions make incremental progress. Without this, every restart re-does work, agents drift, costs spiral.

**8. Testing tools available to the agent?**
Per Anthropic: providing Claude with testing tools dramatically improves performance. Agents that can run tests on their own work catch bugs invisible from code alone. If your agent writes code, give it test execution. If it writes content, give it style-validation.

---

### Security (3 points)

**9. Credentials in vault, NOT in system prompt?**
Hardcoded credentials in prompts is the #1 production-security failure in 2026. Use:
- Claude Managed Agents vault system (vault_id pattern)
- AWS Secrets Manager / GCP Secret Manager (self-hosted)
- HashiCorp Vault (enterprise)

Pass `vault_id` when creating session, never the actual credential.

**10. Scoped permissions per agent?**
Default: minimum permissions. Email-triage agent does not need calendar-write. Status-update agent does not need email-send. Each agent gets exactly the permissions for its job, no more.

**11. Audit log of every tool call?**
Every tool call writes to structured log: timestamp, agent, tool, input-hash, output-hash, success/fail. This is non-negotiable for production. Without it, you cannot debug, audit, or comply with GDPR.

---

### Cost (1 point)

**12. Cost ceiling per session set?**
Agents can rack up $100+ in API calls if loops misbehave. Set hard ceilings:
- Max tokens per session: 100k typical, 500k for complex tasks
- Max tool calls per session: 50 typical, 200 for complex
- Max wall-clock time: 30 min typical, 4h for batch jobs

Hit ceiling = agent stops, alerts you. No exceptions.

---

## Decision tree, what should you actually build?

```
Question: How long does the task take a human?

< 5 min        → Skill (NOT agent). Use Claude Code Skill.
5-30 min       → Single agent with 3-5 tools.
30 min - 4 hrs → Single agent with checkpointing (Claude Managed Agents).
> 4 hrs        → Multi-agent orchestration (LangGraph) OR redesign the task.
```

Most pain in 2026 comes from people building agents for tasks that should be skills.

---

## Anti-patterns to avoid

- **„Let me try multi-agent because it sounds impressive."** Single agent with good tools beats 80% of multi-agent setups.
- **„The agent will figure it out."** No it will not. Explicit rules > implicit hopes.
- **„Production = same as demo + bigger."** Production has interruptions, network failures, model timeouts, rate limits, evolving prompts. Architecture matters.
- **„Why bother with a vault for one credential."** Because in 6 weeks you have 5 credentials and no central management.
- **„LangGraph is overkill for me."** It probably is. CrewAI or Claude Agent SDK is fine for <5 agents.

---

## Migration paths (if you already have agents in production)

| Where you are now | Recommended next step |
|---|---|
| Custom Python loop with OpenAI calls | Migrate to Anthropic SDK (better long-run handling) or CrewAI (better ergonomics) |
| LangChain | Evaluate LangGraph (same team, better for stateful) |
| n8n / Make / Zapier with AI nodes | Stay there for ETL, add Claude Agent SDK for cognitive work |
| OpenClaw | Move cognitive workloads to Claude Agent SDK, keep OpenClaw for visual orchestration if it works for you |
| Lindy / OpenClaw / monolithic platforms | Plan unbundling: skills first, then MCP, then agents |

---

## Sources

- [Anthropic, Claude Managed Agents announcement (April 2026)](https://claude.com/blog/claude-managed-agents)
- [Anthropic, Claude Managed Agents Overview Docs](https://platform.claude.com/docs/en/managed-agents/overview)
- [Anthropic, Building Effective Agents Research](https://www.anthropic.com/research/building-effective-agents)
- [Anthropic, Building Agents with Claude Agent SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk)
- [Anthropic, Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [InfoQ, Anthropic Managed Agents 2026](https://www.infoq.com/news/2026/04/anthropic-managed-agents/)
- [QubitTool, AI Agent Framework Showdown 2026](https://qubittool.com/blog/ai-agent-framework-comparison-2026)
- [Fungies, Best AI Agent Frameworks 2026](https://fungies.io/best-ai-agent-frameworks-2026-comparison/)
- [GuruSup, Best Multi-Agent Frameworks 2026](https://gurusup.com/blog/best-multi-agent-frameworks-2026)
- [DEV Community, Claude Managed Agents Deep Dive 2026](https://dev.to/bean_bean/claude-managed-agents-deep-dive-anthropics-new-ai-agent-infrastructure-2026-3286)

---

*Author: Christoph Erler (EO Berlin) + Dominik Raute (CTO JustWatch). Date: 2026-05-11. Next event will deep-dive each architecture pattern with Dom's engineering perspective.*
