# Audience Analysis, Event #1

**Snapshot:** 2026-05-11 08:48 CEST
**Source:** Luma guest export, 140 approved registrations
**Capacity:** 150 (93% sold)

> Live picture of who is in the room tonight and what they are stuck on. Drives Slido prioritization and the panel order.

---

## Stack distribution, what registrants currently use

| Stack | Count | Share |
|---|---|---|
| **Claude (any variant)** | ~95 | 68% |
| Claude Code + Cowork | ~45 | 32% |
| OpenClaw (alone or mixed) | ~22 | 16% |
| ChatGPT (alone or mixed) | ~30 | 21% |
| Gemini / Google Workspace | ~18 | 13% |
| Perplexity | ~8 | 6% |
| Multi-vendor stack ("Claude + GPT + Gemini") | ~20 | 14% |
| PAI (Personal AI Infrastructure) | 1 explicit (Fabian) | <1% |
| Other (Copilot, n8n, Zapier, Fireflies, Cursor, Lovable, Replit) | ~25 | 18% |
| Just basic / browser only | ~12 | 9% |
| No AI yet | 2 | 1% |

**Takeaway:** Claude is the de-facto standard in this room (68%). OpenClaw is the orchestration second-place. The audience is sophisticated, most are past "should we use AI" and into "how do we make it work in production".

---

## Pain clusters from registration responses

### Cluster 1, Tool Overload (29% of registrations)

**Trigger phrases:** "too many options", "so much out there, overwhelmed", "which tool for what", "Integration der einzelnen Elemente in ein vernünftiges einfaches System", "Maintaining the overview", "FOMO", "feel like I am getting left behind".

Notable: Several registrants explicitly mention being overwhelmed by tool combinatorics. The fix is not more tools, it is fewer with deeper integration.

**Live response:** Slide 4 "Two Traps" addresses head-on. [Solution: tool-overload-diagnostic.md](../../solutions/tool-overload/tool-overload-diagnostic.md).

### Cluster 2, Setup Itself (28% of registrations, biggest single cluster)

**Trigger phrases:** "Setup me", "Setup", "Time to implement the set up", "Finding the right setup", "Setup and adoption", "Set up knowledge", "What to fix first", "Mehr Struktur und bessere Wiederholung".

Critical pattern: people have invested weeks and still do not have a setup they trust.

**Live response:** Slide 7 "Diagnostic" three questions. [Solutions: setup-trap-diagnostic.md + 30-min-aios-blueprint.md](../../solutions/setup-itself/).

### Cluster 3, Agents / Orchestration (18%)

**Trigger phrases:** "Agent orchestration", "Setting up an agent team", "autonomous systems", "actively use Agents", "agent value optimization", "agents to get productive results", "Scaling agents", "Autonomous systems".

Notable: nobody asks "what is an agent" anymore. They want them in production.

**Live response:** Demo 2 (Dom) shows 5-tier memory + Rolodex. Demo 3 (Fabian) shows PAI agent layer. [Solution: agent-reliability-checklist.md](../../solutions/agents/).

### Cluster 4, Team Adoption (18%)

**Trigger phrases:** "Getting team onboard", "Transfer to Team" (Fabian, registrant), "Scaling for my Team", "spread throughout the organization", "bring everything to stable enterprise setup", "Change team mindset to fully embrace agents", "Setup for the entire company", "ensure its spread throughout the organization".

**Live response:** Slide 19 GitHub Reveal references 18% pain. [Solution: team-rollout-playbook.md](../../solutions/team-adoption/).

### Cluster 5, Integration / MCP (14%)

**Trigger phrases:** "Making everything work together", "Automation between tools", "Integration mit vorhandenen Daten", "How to link everything", "integrated with my CRM", "Integration into daily work", "Synchronisation".

**Live response:** Slide 19 GitHub Reveal. [Solution: mcp-cookbook.md](../../solutions/integration-mcp/).

### Cluster 6, OpenClaw Stability (12%)

**Trigger phrases:** "stability", "Workflows in OpenClaw", "ease of use and reliability", "Open claw".

Notable: OpenClaw users explicitly mention reliability. Some are exploring alternatives.

**Live response:** Q&A backup slide #13 (Worst AI Fail), CVE-2026-25253 covered. [Solution: openclaw-honest-assessment.md](../../solutions/openclaw-honest/).

### Cluster 7, Pace / Keeping Up (11%)

**Trigger phrases:** "Keeping up with the pace", "Keeping pace with rapid upgrades", "Race between Opus and Codex and the API costs", "Choosing which approach to take because everything keeps changing", "Keeping up with release cadence of new tools", "Switching components in & out & staying consistent".

**Live response:** Q&A slide #7 (slide 9 of qa-deck) addresses pace risk. [Solution: weekly-ai-filter.md](../../solutions/pace-keeping-up/).

### Cluster 8, Security / GDPR / Compliance (6%)

**Trigger phrases by registrant name:**
- **Boris Kirn (Berlin):** "GDPR and compliance with security standards"
- **Carsten Hermann (Munich):** "Security, tool cluttering, news & updates fatigue"
- **Dan Schwarzlmüller (Hamburg):** "using Agents in a secure way"
- **Leonard Rego (Dubai):** "robust security, uptime and error-free functioning"

Notable: every DACH-based registrant carries implicit GDPR weight. The 6% explicit is the floor, not the ceiling.

**Live response:** Q&A backup slide #4. [Solution: gdpr-claude-checklist-dach.md](../../solutions/security-gdpr/).

### Cluster 9, Industry-Specific (6%)

**Trigger phrases:**
- **Dara Shortt (Ireland, eldercare):** "Scheduling and forward scheduling 1,500 plus calls daily"
- **Yuan Min (Costa Rica, clinical):** "hard to adapt to our clinical & appointments software API and to create other agents for sales follow up, treatment follow up, AR agent"
- Multiple manufacturing, hospitality, real estate registrants

**Live response:** Demo 1 (Chris) shows real estate pricing skill. [Solution: industry-healthcare-scheduling-stack.md](../../solutions/industry-healthcare/).

### Cluster 10, Time / Learning (8%)

**Trigger phrases:** "Time to learn more", "Finding time to learn and implement ideas", "I don't yet have a basis to work from", "not to invest too much time in AI", "Feeling I could get more leverage", "Just curious to keep upgrading".

**Live response:** Slide 22 (Master Template Gift) + 30-day rollout plan. [Solution: 60-day-founder-onboarding.md](../../solutions/time-learning/).

---

## Geographic distribution

Roughly half DACH (Germany, Austria, Switzerland), other half global:

- **DACH:** Berlin (~20), Hamburg (~12), Munich (~8), Zurich (~8), Southwest Germany (~5), Rhine-Ruhr (~5), Austria (~4)
- **Other Europe:** Netherlands, Ireland, Bulgaria, Italy, Spain, Romania, Ukraine, Belgium
- **Americas:** New York, Charlotte, Houston, Miami, Dominican Republic, El Salvador, Brazil, Monterrey, Vancouver Island
- **Asia / Pacific:** Bahrain, Bengaluru, Chennai, Qatar, Australia (Melbourne), Costa Rica
- **Africa:** Cape Town, Kenya

**Takeaway:** ~30 EO chapters represented. DACH is the plurality. English presentation is the right choice; some German-language pain points indicate German-speaking attendees comfortable in either.

---

## Speakers and their pain alignment

| Speaker | Their pain (registration self-statement) | Their demo |
|---|---|---|
| Christoph Erler | (host, no pain submitted) | Workspace-native, 23h/week saved |
| Dom Raute | (host, no pain submitted) | Local-first, 5-tier memory, $0/mo |
| **Fabian Gless** | **"Transfer to Team"** | **PAI v5.0.0 Life OS, addresses exactly his pain** |

Notable: Fabian's pain ("Transfer to Team") puts him squarely in **Cluster 4 (Team Adoption, 18%)**. His PAI demo is the practical answer for the 18% audience pain. Strong narrative alignment.

---

## Pre-event Slido state

**12 questions, sorted by votes:**

1. (7 votes) Start over differently
2. (6 votes) GDPR sensitive data
3. (5 votes) Monthly cost honest
4. (5 votes) Thilo Wendt: AI risk to business + investments (Thilo Wendt is a registrant, EO Berlin)
5. (4 votes) Cloud vs self-hosted vs local
6. (2 votes) Claude vs Gemini in Workspace
7. (2 votes) Pace overruns Enterprise AI
8. (1 vote) Hours saved real numbers
9. (1 vote) Perplexity use cases beside search
10. (1 vote) ChatGPT use cases
11. (0 votes) Worst AI fail
12. (0 votes) Team adoption

**Coverage:** All 12 questions have prepared answers in [QA-CHEATSHEET.md](QA-CHEATSHEET.md) and [qa-deck.html](qa-deck.html).

---

## Operational priorities for tonight

1. **Open Slido early** so registrants land in the question queue, not the chat
2. **Acknowledge geographic spread** in welcome (30 chapters represented)
3. **Frame "honest" early** to match the Luma tagline expectation
4. **Lead the panel from Slido top-votes**, not the deck's question list
5. **Tag Thilo by name** if his question comes up (he is on the registrant list, EO Berlin)
6. **Spotlight the registrants with industry-specific pains** in the panel: Dara Shortt (eldercare scheduling), Yuan Min (clinical workflows). Reference their pain even if they do not unmute.

---

*Source data: Luma guest export 2026-05-11 08:48 CEST. Refresh before each future event.*
