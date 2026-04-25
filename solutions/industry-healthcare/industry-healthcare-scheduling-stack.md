# Industry Healthcare Scheduling Stack

**Pain cluster:** Industry-Specific Healthcare (6+ of 85, including Dara Shortt 1.500+ calls/day eldercare scheduling and Yuan Min clinical API integration)
**Status:** Released, Event #1, 2026-05-11
**Time to read:** 15 min, time to ROI on first pilot: 30-60 days

> The 2026 production stack for healthcare scheduling, validated with deployments at hospitals handling 60%+ of inbound scheduling calls via AI. Built specifically for Dara's eldercare scenario but applicable to any healthcare scheduling pain.

---

## Why this exists

Dara Shortt (Comfort Home Care, Ireland) registered for Event #1 with one of the most concrete pain statements of all 85 audience members: „Scheduling and forward scheduling 1,500 plus calls daily."

This is not a theoretical AI question. This is „my operations are bottlenecked on phone-based scheduling and I need to halve the load while maintaining care quality."

This document is the production-validated stack to do exactly that.

---

## The 2026 healthcare AI scheduling reality

**The numbers (April 2026):**
- 60%+ of inbound scheduling calls at certain U.S. hospitals are handled by AI agents
- Hyro reports 85%+ call deflection for routine inquiries
- EliseAI claims 95% patient inquiries handled without human intervention
- Quirónsalud (Spain) achieved 50% reduction in incoming calls handling 7M patients/year
- Northeast OBGYN automated 50% of scheduling calls and grew bookings by 12%
- Market forecast: $555M+ AI in Patient Scheduling Software by 2033

**The trend in one sentence:** AI voice agents in healthcare scheduling have moved from „experimental" to „production at hospital scale" in 2025-2026. The risk profile flipped: not adopting is now the higher-risk position.

---

## The 4-layer healthcare voice agent architecture

Every production healthcare voice agent has these 4 layers:

```
LAYER 4: ORCHESTRATION
  Routes between guided skills (scheduling, triage, billing inquiry)
  Maintains conversation state across turns
       ↑
LAYER 3: DIALOGUE MANAGEMENT
  Manages context, handles unexpected turns, knows when to escalate
       ↑
LAYER 2: NLU (Natural Language Understanding)
  Extracts intent + entities (patient name, date, urgency, condition)
       ↑
LAYER 1: ASR (Automatic Speech Recognition)
  Converts speech to text with medical-terminology accuracy
```

You can build all 4 layers yourself (12-18 months), buy them as a managed product (1-2 weeks), or hybrid (build cognitive layer on top of a managed voice provider).

---

## The recommended stack for Dara's scenario

**Context recap:** 1.500+ calls/day, eldercare home care, scheduling + forward scheduling, Ireland, presumably mix of new patient intake + recurring caregiver schedule changes + family inquiries.

### Recommended stack (90-day deployment plan)

**Layer 1-3 (managed):** Hyro
- Healthcare-specialized voice agent
- 85%+ deflection on routine inquiries
- EHR integration via standardized protocols
- Pricing: roughly $150/month per concurrent line + per-call overage (estimate based on Pro tier benchmarks; request real quote)

**Layer 4 (custom orchestration):** Claude Code + skills
- Custom skills per intake type (new patient, schedule change, urgent care, family inquiry, billing)
- Memory layer for recurring caregiver-client relationships
- Escalation logic to human agents for sensitive cases

**Bridge:** MCP server connecting Hyro to Claude
- Hyro handles voice + initial intent
- Claude handles cognitive work (matching caregiver, checking history, applying eldercare-specific rules)

**Total estimated stack cost (steady state):** $4-8k/month for 1.500+ calls/day handling, vs estimated current FTE cost of 4-6 dedicated schedulers (~$15-25k/month in Ireland). ROI break-even: 30-60 days.

---

## Alternative stacks (if Hyro does not fit)

### Stack B, EliseAI-led
- EliseAI for full intake-to-scheduling
- Higher claimed deflection (95%) but less customizable
- Best if your workflows are standard, you do not need eldercare-specific rules

### Stack C, Assort Health for prior auth heavy
- Specialized in prior authorization automation
- Adjacent value if Dara has insurance complexity

### Stack D, build-your-own (Twilio + Claude Managed Agents + Custom NLU)
- Twilio Voice for Layer 1
- Claude Managed Agents for Layer 4 (with vault for credentials)
- Custom NLU using Claude with healthcare prompts
- Cost: 3-6 months of engineering time, $1-2k/month operating cost
- Best if regulatory constraints make managed-product adoption hard, OR if you have engineering team and want full IP ownership

### Stack E, Veradigm Predictive Scheduler
- More clinical-workflow-integrated
- Heavy if you only need basic scheduling
- Best if integrated with Veradigm EHR

---

## The 90-day Dara playbook (concrete)

### Week 1-2, Diagnosis
- Audit 100 sample calls: categorize by type (new intake / change / urgent / family / other)
- Identify the 3 highest-volume call types
- Document the current human script for each type
- Map current EHR/scheduling system, identify integration surface

### Week 3-4, Vendor selection
- Demo Hyro, EliseAI, Assort, one additional based on call-mix
- Get real per-month quotes (do NOT trust public pricing as gospel)
- Pick the one that handles your top 2 call types out-of-box

### Week 5-8, Pilot (1 call type, 50 calls/day)
- Deploy on the highest-volume routine call type only
- Run parallel: AI handles, human supervises and overrides
- Track: deflection rate, customer satisfaction, escalation rate, error rate

### Week 9-12, Scale + add second call type
- If pilot KPIs hit (deflection >70%, satisfaction unchanged, escalations <15%), expand
- Add second call type
- Begin building custom Claude skills for eldercare-specific rules (caregiver matching, recurring schedule patterns)

### Month 4-6, Steady state + optimization
- 60-80% of total call volume on AI
- Human team focuses on escalations + complex cases (where their judgment matters)
- Quarterly review: NPS, deflection, cost-per-call, business outcomes (caregiver retention, family satisfaction)

---

## Eldercare-specific considerations (NOT in standard healthcare AI playbooks)

These matter for Dara specifically:

1. **Family-as-decision-maker:** Many eldercare scheduling calls come from adult children, not patients. AI must handle „I am calling for my mother" as standard, not exception.
2. **Caregiver-client relationship continuity:** Schedule changes that break continuity hurt outcomes. AI must prioritize same-caregiver matching, not just availability.
3. **Sensitive escalation:** Calls about deteriorating condition, end-of-life decisions, or family conflicts MUST escalate. Train escalation patterns with explicit examples.
4. **Hearing-impaired patients:** Pronunciation tolerance matters more than in standard healthcare. Specify in NLU configuration.
5. **Regulatory:** Ireland HSE compliance + HIQA care standards apply. Get vendor written confirmation of compliance support before signing.

---

## Companion files

For voice-from-car (Marco Pasini's adjacent use case) and other industry-specific stacks, contributions welcome via PR (see [CONTRIBUTING.md](../../CONTRIBUTING.md)).

---

## Anti-patterns to avoid

- **„Let me build voice AI from scratch."** Do not, unless you have 6 months engineering budget. The managed providers solved Layers 1-3, focus on Layer 4 customization.
- **„AI replaces all schedulers."** No. AI handles routine, humans handle judgment. The calculus is „same team, 3x throughput", not „layoff team".
- **„Deploy on hardest call type first."** Wrong. Deploy on highest-volume routine type. Wins compound.
- **„One vendor will do everything."** No vendor does both healthcare voice AND custom eldercare cognitive work well. Hybrid is the answer.
- **„Skip pilot, scale fast."** Hospitals that did this in 2024-2025 had high-profile failures. 8-week pilot beats 8-month rollback.

---

## Sources

- [Hyro AI Healthcare](https://www.hyro.ai/healthcare/scheduling-management/)
- [EliseAI Healthcare](https://eliseai.com/)
- [Assort Health](https://www.assorthealth.com/)
- [Prosper AI, Healthcare Voice AI Agents Guide 2026](https://www.getprosper.ai/blog/healthcare-voice-ai-agents-guide)
- [GlobeNewswire, $555M AI Patient Scheduling Software Market Forecast](https://www.globenewswire.com/news-release/2026/02/17/3239383/28124/en/555-Mn-AI-in-Patient-Scheduling-Software-Market-Forecast-to-2033-Featuring-Veradigm-Epic-Systems-Hyro-Assort-Health-Notable-Voiceoc-Zocdoc-Relatient-and-UnityAI.html)
- [Caresmartz360, AI in Home Care Client-Caregiver Matching](https://www.caresmartz360.com/blog/artificial-intelligence/ai-revolutionizing-client-caregiver-matching-and-scheduling-in-home-care/)
- [McKnights Home Care, AI essential 2026](https://www.mcknightshomecare.com/whats-next-for-healthcare-in-2026-ai-becomes-essential-to-success/)
- [HSE Ireland, AI for Care 2026-2030](https://about.hse.ie/publications/ai-for-care-2026-2030/)
- [Parloa, AI Voice Agents in Healthcare 2026](https://www.parloa.com/blog/ai-voice-agents-in-healthcare/)
- [Rasa, AI Voice Agents Healthcare Top Platforms 2026](https://rasa.com/blog/ai-voice-agents-for-healthcare-top-platforms-for-2026)

---

*Author: Christoph Erler (EO Berlin). Date: 2026-05-11. All vendor pricing requires direct quote, public figures are estimates only. Refinement contributions welcome.*
