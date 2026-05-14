# Q&A Cheatsheet, Event #1 Panel

Live Slido state, 12 questions, sorted by vote count. Quick-answers + slide references + solution-file links for the live panel.

**Slido:** https://app.sli.do/event/ayixnbqUoPEUoNJQa6WuFA &middot; Code `#3261743`

---

## Format

Each question:
- **Quick answer (30-60 sec)**, what to say live
- **Deeper points**, for follow-ups
- **References**, slides + solution files to point to

---

## Q1, 7 votes, If you could start over, what would you build differently?

**Quick answer**
"Five things, in order of regret. One: start with memory, not with tools. Two: write down 'who I am, what I do' before installing anything. Three: use Markdown files, not Vector-DB, until you have 10.000+ unstructured docs. Four: avoid Voice-of-AI lock-in, every assistant should be a Markdown wrapper, not a vendor. Five: build for one stack you live in, not for every tool you have."

**Deeper points**
- v1-v3 of my own setup are dead (ChatGPT-only, Notion+Zapier, multiple-tools-no-architecture). Only v4 Workspace-native and v5 Local-first survived.
- 12 weeks of building, ripping, rebuilding before something held.
- Single biggest mistake: optimizing for tools before defining what I want the brain to remember.

**References**
- slides.html #5 My 12 Weeks
- slides.html #6 Stack Versions v1-v5
- chris-demo.html #6 Building 1 Personal Deep
- chris-demo.html #24 Take-aways 5 lines
- Solution: `solutions/openclaw-honest/openclaw-honest-assessment.md`

---

## Q2, 6 votes, GDPR sensitive company data

**Quick answer**
"You can run Claude GDPR-compliant in 2026, but you have to configure it. Anthropic signed the DPA in January 2026. For DACH or regulated industries, route through AWS Bedrock EU Frankfurt or Google Vertex AI EU regions, that is the legal floor. For ZDR, zero data retention, apply via Anthropic Sales. Critical: EU AI Act takes full effect August 2 2026, you have three months from tonight."

**Deeper points**
- ZDR available on Enterprise APIs, not on Pro/Team browser
- Customer data in transcripts: Deepgram EU datacenter, Claude API zero-retention via Bedrock
- Recording-consent is your obligation, not the vendor's
- Don't put sensitive financial, medical, legal, M&A data in default Claude API, retention is 7 days

**References**
- slides.html #15 GitHub Reveal (Security/GDPR DACH 5% pain cluster)
- Solution: `solutions/security-gdpr/gdpr-claude-checklist-dach.md` (20-item checklist, 1-3 day deployment)

---

## Q3, 5 votes, Monthly cost honest, API + subs + hosting

**Quick answer**
"My personal setup, all-in: 150 EUR per month. Claude Pro plus a Telegram bot VM on Lightsail Frankfurt plus minor APIs. Dom is at zero dollars, fully local. Compared to Glean Enterprise at 500 per seat or a full enterprise stack at 1.5k per month, this is architecture beating budget. For an agency-scale Org Brain, expect under 1k per month all-in, including cloud harness, transcription, and API costs."

**Deeper points**
- During build-up, $50 per day Opus burn is realistic, plan for 2 to 4 weeks of that
- Steady-state operational cost is much lower than people expect
- Hidden costs: setup time (200h for me) and maintenance tax (2h per month patching)
- Replaces 200-260k EUR per year in hires that never happened

**References**
- slides.html #14 Cost Reality ($0 local vs $500/seat Glean vs $1.5k enterprise stack)
- chris-demo.html #5 25% Digital Twin (150 EUR/mo, 31 MCP tools, 19 skills, 125 memory files)
- chris-demo.html #20 Headcount Math (330-490k EUR replaced, equivalent-capability honest)
- Solution: `solutions/setup-itself/30-min-aios-blueprint.md`

---

## Q4, 5 votes, AI risk to your own business model + investments

**Quick answer**
"Two questions in one. First, your own business. If your value prop is mostly information arbitrage or doing what a junior analyst does, AI eats it in 18 months. If your value prop is relationships, judgment under uncertainty, or operational execution under pressure, AI compresses your cost base but does not eat the wedge. Test it by asking: can a well-prompted Claude do my next quarter? If yes, you have a problem. If no, AI is leverage, not threat. Second, your investments. Same test, applied to each portfolio company. PE LP fund: ask each GP for their AI-readiness audit. Public equities: shift exposure toward owners of proprietary data, distribution moats, regulated rails."

**Deeper points**
- Solo-founder bias: AI looks like infinite leverage. For enterprise B2B with long sales cycles, AI looks like commoditization risk.
- "Operational alpha" thesis: AI compresses ops cost, the residual value is judgment + distribution.
- DACH advantage: regulated industries and trust-based B2B sales cycles are AI-resistant by default. Don't sleep on this.
- For your investments: filter for moat type, not for "AI-native" branding. Branding is noise, moats are signal.

**References (no slide directly, this is panel-only)**
- chris-demo.html #2 Origin (key-person risk story, what compressed ComX multiple by 50%)
- Solution: `solutions/pace-keeping-up/weekly-ai-filter.md`

---

## Q5, 4 votes, Cloud vs self-hosted vs local

**Quick answer**
"Three valid paths, depending on what you optimize for. Local-first like Dom: zero ongoing cost, full sovereignty, but you carry the engineering load forever. Workspace-native like me: 150 EUR per month, mobile access via Telegram, but you ride the vendor roadmap. Enterprise hosted like Glean: 500 per seat, no engineering load, but you pay vendor lock-in and your data lives in a third party. For sensitive data, DACH legal, AWS Bedrock EU is the middle path: cloud convenience, EU residency, audit trail."

**Deeper points**
- Local: best for power users, regulated industries, max privacy
- Workspace-native: best for mobile-first operators, multi-domain, want it everywhere
- Enterprise hosted: best for teams not building, want it now, accept vendor lock-in
- Middle: cloud-deployed open-source harness (Claude Code Bypass on AWS Frankfurt)

**References**
- slides.html #14 Cost Reality (the comparison)
- chris-demo.html #14 3-Pyramid (Mac/Cloud/Edge swappable)
- Solution: `solutions/security-gdpr/gdpr-claude-checklist-dach.md` (data residency section)

---

## Q6, 2 votes, Claude vs Gemini, Google Workspace context

**Quick answer**
"Honest answer: use both, for different things. Gemini is best inside Workspace for quick Doc and Sheet and Slides work because it is native. Claude is best for reasoning, long-context analysis, anything that requires judgment over multiple sources, and for the agentic loop. If you are deep in Workspace and already paying for Gemini Advanced, do not pay for Claude Pro separately, use the Anthropic API for the agentic stack and let Gemini do the Workspace inline work. Do not wait for Google to catch up on reasoning. Use Claude where reasoning matters today."

**Deeper points**
- Gemini 2.x is competitive on speed and Workspace integration, weaker on reasoning chains
- Claude Opus 4.7 is the current judgment leader, especially for code and multi-step analysis
- Cost: Gemini Advanced 22 EUR/mo, Claude Pro 20 USD/mo, both reasonable
- Tip: Claude in Chrome extension gives you Claude inside Workspace browser, best of both

**References (no slide, panel-only)**
- Solution: `solutions/tool-overload/tool-overload-diagnostic.md`

---

## Q7, 2 votes, Pace of software development overruns Enterprise-AI utility

**Quick answer**
"Bet on architecture, not on model. The same architecture, Memory plus Tools plus Models, survives any model swap. If your enterprise platform is locked to a specific model API, you bought a depreciating asset. If your platform has a thin harness that calls a swappable model, you bought an appreciating asset. Test it by asking: can my product run on a different model in 30 days? If no, you have technical lock-in, not product moat."

**Deeper points**
- Models compete down to commodity in 12-18 months, OpenAI vs Anthropic vs Google vs open-weights
- The moat is data, distribution, judgment encoding, vertical depth
- Risk mitigation: keep harness thin, keep skills version-controlled, keep data layer separate
- For enterprise customers: they will demand model-portability in contracts by 2027

**References**
- chris-demo.html #14 3-Pyramid (different harnesses, same skills)
- slides.html #16 Headcount Teaser ("deployed on different harnesses")
- Solution: `solutions/pace-keeping-up/weekly-ai-filter.md`

---

## Q8, 1 vote, Hours saved per week, real numbers

**Quick answer**
"23 hours per week, tracked over 8 weeks. Morning briefing saves 2.25h, meeting prep saves 5.7h across 4 calls per day, email and WhatsApp drafts save 2.7h, real estate pricing fully auto-runs at 5h saved, weekly review goes from 90 minutes to 10 minutes, client diagnostics save 3h, deliverables save 3.75h. Personal Brain version 4, alive 6 months, 150 EUR per month."

**Deeper points**
- 18.7h personal admin + 4.75h client work = 23h reclaimed
- Not all gains are time, many are quality: fresher context, fewer dropped balls, better drafts
- Payback period: 4 to 5 months including 200h setup time
- Dom's local-first setup saves similar hours at $0 marginal cost

**References**
- slides.html #10 Demo 1 Recap (13h/wk personal headline number)
- chris-demo.html #7 Day in the Life Table (10 tasks, full table, 23h)
- chris-demo.html #9 Personal Brain (23h bottom callout)

---

## Q9, 1 vote, Perplexity use case beside search

**Quick answer**
"Three honest uses beyond standard search. One: deep-research mode for sourcing primary documents, when you need 8 to 15 citations on a specific topic. Two: competitive intel, watching specific competitors over time via Spaces. Three: stock and market research with current data and inline citations. For everything else, Claude with web search is sharper. Perplexity wins on citation density and source transparency. Claude wins on reasoning over the sources once you have them."

**Deeper points**
- Spaces feature is the underrated killer, like a curated workspace per topic
- Pro tier ($20/mo) for deep research, free tier fine for most queries
- Watch the citation links yourself, hallucinations on web sources still happen
- Not a Claude replacement, a complementary research layer

**References (panel-only, no slide)**

---

## Q10, 1 vote, Best practical case where you use ChatGPT

**Quick answer**
"Honestly: image generation via DALL-E for quick mockups, and voice mode for hands-free brainstorming on walks. For everything text-based and reasoning-heavy, Claude is sharper. For multimodal tasks like fast image edits, ChatGPT plus DALL-E is faster than the equivalent Claude plus separate image tool. If you have ChatGPT Plus and Claude Pro, treat them as specialized tools: ChatGPT for multimodal and casual chat, Claude for work."

**Deeper points**
- Voice mode for thinking out loud on walks, generates great notes
- Custom GPTs are a niche win for repeated narrow workflows
- Code Interpreter (Advanced Data Analysis) is useful but Claude Code is better for software work
- Do not use ChatGPT for anything customer-facing, retention policies are looser than Claude

**References (panel-only, no slide)**

---

## Q11, 0 votes, Worst AI fail in your business, what did you learn

**Quick answer**
"Two real fails. One: April 2026, my user memory had a 13-month drift, the brain was running on stale facts because I never audited. Fix: weekly /audit-memory cron now catches drift. Two: an early Claude Code run modified files in a production repo without a backup snapshot, lost 4 hours of work. Fix: hard rule, every destructive operation needs a backup branch created first. The lesson: AI fails silently. Build the audit and the snapshot before you trust it, not after."

**Deeper points**
- Most AI fails are silent: wrong context loaded, plausible-sounding wrong answer, action taken on stale data
- The fix is never "more AI", the fix is always "more verification"
- OpenClaw CVE-2026-25253 is a public example of agentic system failing in production
- Standard discipline: backup branches, audit cron jobs, manual review before commit on sensitive actions

**References**
- slides.html #5 My 12 Weeks (5 dead stacks)
- slides.html #10 + #13 Honest Struggles boxes
- chris-demo.html mentions in struggles
- Solution: `solutions/openclaw-honest/openclaw-honest-assessment.md` (CVE-2026-25253 details)

---

## Q12, 0 votes, Team adoption, change management

**Quick answer**
"Three things, in order. One: do not roll out tools, roll out skills. People can adopt a skill called /audit-process. People cannot adopt a generic LLM. Two: solve one painful workflow per quarter, not all of them at once. The win has to be visible in the first 30 days. Three: founder uses it visibly. If the founder is still in old workflows, the team mirrors that. The 90-day playbook is in the repo, six prerequisites, then phased rollout."

**Deeper points**
- The hardest workflow change is not the tool, it is the new mental model
- Train on real org skills, not on toy demos
- Measure adoption by skill invocations per team member, not by tool installs
- Plan for 20-30% drop-off, not everyone wants this. That is OK.

**References**
- slides.html #15 GitHub Reveal (Team Adoption 18% pain cluster)
- Solution: `solutions/team-adoption/team-rollout-playbook.md` (6 prereqs + 90-day plan)

---

## Backup deck topics (Slide 10 of slides.html)

For Slido fallback if live questions slow down:
- Hours saved per week, honest numbers (covered above Q8)
- Where the agent failed catastrophically (covered above Q11)
- What we'd build completely differently today (covered above Q1)
- Monthly cost, real numbers, incl. API spend (covered above Q3)
- How we protect sensitive customer data (covered above Q2)
- From which company size does this pay off (NEW, see below)
- How we brought the team along (covered above Q12)

### Bonus: From which company size does this pay off?

**Quick answer**
"Solo founders: day one. The Personal Brain replaces three hires you cannot afford. Teams of 2-10: month one. The Org Brain captures process knowledge before it walks out the door. Teams 10-50: quarter one. ROI shows up in stopped hires plus retained tribal knowledge plus reduced onboarding time. 50-plus: depends. Enterprise has compliance, change-management, and procurement gates that add 6 to 12 months. The math always works, the timing depends on your bottleneck."

---

## Live panel discipline

1. Read top Slido question, repeat it for the audience.
2. Answer in 60 seconds. No filler. No "great question".
3. Add a follow-up only if the question asker is in the room.
4. Move on to next top-voted.
5. If a question is too vague, ask one clarifying then answer.
6. Hard skip on financial trades, legal advice, prohibited actions.

**Time budget for 15 min panel: 6 to 8 questions at 60-90 sec each.**

---

*Built for Event #1, 2026-05-11. Update after each event.*
