# GDPR Claude Checklist DACH

**Pain cluster:** Security / GDPR / Compliance (4 explicit + all DACH-Mitglieder implicit)
**Status:** Released, Event #1, 2026-05-11
**Time to read:** 20 min, time to compliant deployment: 1-3 days

> The DACH-specific GDPR + EU AI Act compliance checklist for Claude. Covers DPA, ZDR, EU data residency via AWS Bedrock Frankfurt, and the August 2026 EU AI Act deadline. Tested against German enterprise procurement standards.

---

## Why this exists

4 audience members at Event #1 explicitly named GDPR/Security as their top pain (Boris Kirn, Carsten Hermann, Dan Schwarzlmüller, Leonard Rego). Plus 16+ DACH-based members for whom GDPR is implicit operational reality.

The reality in 2026 is not „can I use Claude under GDPR" (yes, you can). The reality is „what do I configure to be COMPLIANT, not just legal-on-paper". This checklist is the configuration.

Plus: EU AI Act takes full effect August 2, 2026. You have 3 months from Event #1 to get this right.

---

## The 2026 compliance reality

**Anthropic GDPR-Stack as of April 2026:**
- DPA (Data Processing Addendum) effective January 1, 2026
- ISO 27001:2022 (Information Security)
- ISO 42001 (AI Management System, brand new for AI specifically)
- SOC 2 Type I + II
- SCCs (Standard Contractual Clauses) for international data transfers covered

**Critical caveat:** Anthropic's DPA satisfies basic GDPR. It does NOT automatically satisfy the stricter requirements many German + EU enterprise, public sector, and regulated-industry customers have. For those: you MUST route through AWS Bedrock EU profiles or Google Vertex AI EU regional endpoints.

**EU AI Act August 2, 2026 deadline:**
- Full effect across EU
- Penalties up to €40M or 7% of worldwide annual turnover for prohibited practices
- Training data transparency requirement
- High-risk AI systems: documented risk management + data governance + technical documentation + automatic logging + human oversight

---

## The checklist (20 items, organized by risk tier)

### Tier 1, Foundation (every Claude user, including Free + Pro)

**1. Sign Anthropic DPA**
- Action: Privacy Center → request DPA → sign
- For Pro/Team accounts: automatic via Commercial Terms acceptance
- For Enterprise: explicit DPA signature, includes SCCs

**2. Confirm zero training of your data**
- Default for paid Claude tiers (Pro, Team, Enterprise, Claude Code commercial): your data is NOT used for training
- Verify: privacy.claude.com/en/articles/zero-training

**3. Audit current API retention**
- Claude API logs retained 7 days (was 30 days before September 2025), then auto-deleted
- API data NEVER used for training
- For ZDR (Zero Data Retention): apply via Anthropic Sales for eligible APIs

**4. Run sensitive-data triage**
- What goes into Claude Browser (Pro): treat as „same level as your personal Gmail"
- What goes into Claude API with default retention: 7 days exposure window
- What requires ZDR: medical, legal, financial, M&A, HR sensitive data

### Tier 2, EU/DACH Data Residency (recommended for DACH businesses)

**5. Route through AWS Bedrock EU**
- Available regions: Frankfurt (eu-central-1), Ireland, Paris, Stockholm, Milan, Spain
- Anthropic does NOT retain prompts/outputs for training via Bedrock
- Configuration for Claude Code:
  ```bash
  export CLAUDE_CODE_USE_BEDROCK=1
  export AWS_REGION=eu-central-1
  export AWS_ACCESS_KEY_ID=...
  export AWS_SECRET_ACCESS_KEY=...
  ```

**6. OR route through Google Vertex AI EU**
- 10 EU regions available
- Claude models including Opus 4.7, Sonnet 4.6, Haiku 4.5 verfügbar
- Anthropic retains nothing via Vertex

**7. Document the data residency choice**
- Internal compliance docs: which Claude tier, which deployment, which region
- Required for ISO/SOC audits and DSGVO Auditor reviews

**8. Note the gap, Cowork EU residency**
- Claude Cowork (desktop app) does NOT yet support EU data residency natively
- GitHub issue #40530 tracks this
- Workaround: use Claude Code via Bedrock for EU-residency-required workflows, Cowork for non-sensitive

### Tier 3, EU AI Act August 2026 (mandatory by August 2, 2026)

**9. Inventory every AI system**
- Spreadsheet: tool name, vendor, use case, data types touched, who uses it
- Required artifact for AI Act compliance

**10. Classify by risk level**
- Prohibited (e.g. social scoring): you are not running these as a founder, but verify
- High-risk (e.g. recruitment, credit scoring, medical): full compliance burden
- Limited risk (chatbots, deepfakes): transparency obligations
- Minimal risk (spam filters, productivity tools): informal best practices

Most founder use cases = limited or minimal risk. But check.

**11. Determine your role per system**
- Provider (you build the AI system) vs Deployer (you use a vendor's)
- Most founders are Deployers for Claude
- Provider obligations are 10x deeper, so be honest about which role you have

**12. Assign governance ownership**
- One person responsible: AI compliance lead
- For SMB: usually the founder or COO

**13. Conduct impact assessment for any high-risk system**
- Documentation: who is affected, what data, what risks, what mitigations

**14. Update vendor contracts**
- Add AI-specific clauses to vendor agreements
- Especially for resellers / agencies using Claude on your behalf

**15. Build training programme for staff**
- Mandatory under AI Act for staff using AI in customer-facing or decision-influencing roles
- Document attendance, content, refresh cadence

**16. Create documentation trails**
- Automatic logging of AI decisions in regulated workflows
- Retain per industry-specific retention rules

**17. Establish incident response plan**
- What happens if Claude generates harmful output that reaches a customer
- Who notifies whom, by when, with what artifacts

**18. Set up ongoing monitoring**
- Quarterly review: still compliant, still using as documented, still within risk classification

### Tier 4, Industry-Specific (if applicable)

**19. Healthcare (Dara, Yuan, Comfort Home Care, GoodMed)**
- HIPAA (US) + national equivalents (HSE Ireland, Bundesdatenschutzgesetz, Schweizer DSG)
- Patient data NEVER goes through default Claude API
- Required: Bedrock EU/HIPAA-eligible AWS endpoints OR self-hosted

**20. Financial Services**
- BaFin compliance (DE), FINMA (CH)
- Required: enhanced auditability, data localization, vendor due diligence

---

## Ready-to-use DPA Anthropic request template

Email to: privacy@anthropic.com

```
Subject: DPA Request, [Your Company Name]

Hi Anthropic Privacy Team,

we are [Your Company], based in [Country, EU/DACH]. We use Claude [tier: Pro / Team / Enterprise / API].

Please send us:
1. Current DPA with EU SCCs for signature
2. Confirmation of data residency options for our use case
3. ZDR availability + eligibility check for our API key
4. Most recent ISO 27001 + ISO 42001 + SOC 2 attestation summaries

Use case summary: [1-2 sentences]
Sensitive data types: [list]
Required EU region: [Frankfurt / Other]

Thanks,
[Your Name]
[Title]
[Company]
```

Expected response: 3-5 business days.

---

## Decision tree, what should you actually do?

```
Are you handling regulated data (medical, financial, legal, M&A, HR sensitive)?
├── YES → Tier 1 + Tier 2 + Tier 3 + Tier 4 specific to your industry
│         Estimated effort: 3-5 days for setup, ongoing monthly review
│
└── NO  → Are you DACH-based?
         ├── YES → Tier 1 + Tier 3 (AI Act mandatory)
         │         Optional but recommended: Tier 2 (Bedrock EU)
         │         Estimated effort: 1-2 days
         │
         └── NO  → Tier 1 + Tier 3 (AI Act if EU customers)
                   Estimated effort: 4-8 hours
```

---

## Companion files

- [dpa-anthropic-template.md](dpa-anthropic-template.md): formal request template + sample reply + signing workflow (TBD)
- [eu-data-residency-decision.md](eu-data-residency-decision.md): direct API vs Bedrock vs Vertex decision matrix (TBD)
- [agent-credential-security-baseline.md](agent-credential-security-baseline.md): vault patterns for production agents (TBD)

---

## Anti-patterns to avoid

- **„DSGVO ist eh nur ein Papier-Thema, niemand prüft."** False since 2025. DSGVO enforcement intensified, AI Act adds penalties up to €40M.
- **„Ich nutze Claude nur intern, das ist privat."** Wrong. „Internal" still triggers GDPR if any personal data is in prompts. „Intern" ≠ „nicht reguliert".
- **„Bedrock ist zu teuer, ich nehme die Browser-Version."** Risk-cost calculation: legal exposure for one DSGVO violation > 12 months of Bedrock fees.
- **„Ich warte mit AI Act bis August."** August is 3 months away. Inventory + classification take 4-6 weeks. Start now.
- **„Mein Steuerberater hat das checked."** Steuerberater are not GDPR/AI Act experts. Get a Datenschutzbeauftragten or legal advisor for high-stakes deployments.

---

## Sources

- [Anthropic Privacy Center, Zero Data Retention](https://privacy.claude.com/en/articles/8956058-i-have-a-zero-data-retention-agreement-with-anthropic-what-products-does-it-apply-to)
- [Anthropic Privacy Center, DPA Request](https://privacy.claude.com/en/articles/7996862-how-do-i-view-and-sign-your-data-processing-addendum-dpa)
- [Compound Law, Claude Enterprise Germany GDPR DPA Checklist](https://compound.law/en-DE/tools/claude-enterprise/)
- [WAIMAKERS, Claude GDPR Compliance Guide](https://www.waimakers.com/en/resources/gdpr-compliance/claude-anthropic)
- [Christian Gerloff, Claude on AWS vs Azure vs Google GDPR Data Residency Compared 2026](https://www.gerloff.dev/writing/claude-aws-azure-google-gdpr)
- [Char Blog, Anthropic Data Retention 2026](https://char.com/blog/anthropic-data-retention-policy/)
- [Claude Code Docs, Zero Data Retention](https://code.claude.com/docs/en/zero-data-retention)
- [SecurePrivacy, EU AI Act 2026 Compliance Guide](https://secureprivacy.ai/blog/eu-ai-act-2026-compliance)
- [Raconteur, EU AI Act Compliance Technical Audit Guide 2026 Deadline](https://www.raconteur.net/global-business/eu-ai-act-compliance-a-technical-audit-guide-for-the-2026-deadline)
- [CMARIX, EU AI Act Compliance Checklist 2026 Software Teams](https://www.cmarix.com/blog/eu-ai-act-compliance-checklist/)
- [Agentic Fluxus, EU AI Act 10-Step Compliance Before August 2026](https://agenticfluxus.com/blog/eu-ai-act-compliance-checklist)
- [Legalnodes, EU AI Act 2026 Updates Compliance Requirements Business Risks](https://www.legalnodes.com/article/eu-ai-act-2026-updates-compliance-requirements-business-risks)

---

*Author: Christoph Erler (EO Berlin). Date: 2026-05-11. NOT a substitute for qualified legal counsel. For high-stakes deployments, engage a Datenschutzbeauftragten + AI-Act-aware legal advisor. Tested against German SMB compliance requirements.*
