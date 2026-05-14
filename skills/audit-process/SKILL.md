---
name: audit-process
type: domain-example
audience: For advisors, COOs, ops consultants
load_when: audit process, process audit, where are we losing time, ops diagnostic, impact effort
---

# /audit-process

> **Domain-example skill from Event #1, Demo 1 (Chris). For advisors / COOs / ops consultants.**
> Internal process diagnostics. Takes 10-30 processes you describe → returns a ranked Impact-Effort matrix with concrete fixes.

---

## Purpose

Operators and advisors get asked "where are we losing time / money / quality?" weekly. The honest answer requires structured diagnosis across 10-30 processes, not vibes. This skill runs that diagnosis in one pass and returns a forkable Impact-Effort matrix you can take into a board meeting or client engagement.

The pattern is: **intake N processes → score on 2 dimensions → output ranked matrix + per-process detail + top-3 summary**. Reusable for any "diagnostic + scoring" workflow.

---

## Inputs

1. **Process list**, paste-in or read from `memory/projects/<engagement>/processes.md`. Each process: name, owner, frequency, current pain.
2. **Org context**, `memory/projects/<engagement>/org.md` (size, stage, revenue, current pressure)
3. **Diagnostic rubric**, `memory/_meta/audit_rubric.md` (your scoring criteria, defaults below)
4. **Past audits**, `memory/projects/<engagement>/audits/` (so you don't re-flag fixed items)
5. **Voice rules**, for tone of the deliverable
6. **Industry benchmark file** (optional), `memory/_meta/benchmarks_{industry}.md` (so "fix" recommendations match what other companies in the same space did)

---

## Outputs

### A. Impact-Effort matrix (the core deliverable)

```markdown
# Process Audit · {Org Name} · {YYYY-MM-DD}

## High Impact / Low Effort (do this quarter)
| Process | Pain | Fix | Owner | Cost | Win |
|---|---|---|---|---|---|
| Invoice approval | 4-day delay average | Auto-approve <5k EUR | CFO | 0 | 12h/wk |
| ...

## High Impact / High Effort (do next quarter)
...

## Low Impact / Low Effort (do if convenient)
...

## Low Impact / High Effort (do not do)
...
```

### B. Per-process detail (one section each)

```markdown
## {Process Name}
- **Current state:** ...
- **What's broken:** ...
- **What it costs:** [time / money / quality measure]
- **Proposed fix:** ...
- **Effort to implement:** [days / weeks / months]
- **Risk of NOT fixing:** ...
- **Owner:** ...
- **Industry benchmark (if available):** ...
```

### C. Top-3 summary for the principal

```markdown
## For the Founder/CEO

If you do nothing else, do these three:
1. ...
2. ...
3. ...

The math: [N] hours per week reclaimed = [EUR] per year at [load].
```

---

## Worked example, 12-process audit at a 40-person agency

**Context:** Series-B SaaS agency, 40 FTE, 8M EUR ARR, founder-CEO is bottlenecked on approvals.

**Input data fed to skill:**
- 12 processes from intake interview (invoice approval, hiring loop, client onboarding, weekly project standup, sales handoff, etc.)
- Org context: 40 FTE, 8M ARR, growth-stage, founder-bottleneck noted
- Rubric: standard 1-5 Impact, 1-5 Effort

**Output (excerpted, top section):**

```markdown
# Process Audit · ACME Agency · 2026-05-17

## High Impact / Low Effort (do this quarter)

| Process | Pain | Fix | Owner | Cost | Win |
|---|---|---|---|---|---|
| Invoice approval | 4-day average delay, founder-bottleneck | Auto-approve invoices <5k EUR; founder reviews >5k only | CFO | 0 | 12h/wk founder time + 4 days faster cash collection |
| Hiring offer letters | Founder reviews every offer letter, 2-day SLA | Template + COO sign-off; founder reviews exec hires only | COO | 0 | 6h/wk founder time |
| Client onboarding handoff | Sales→CS handoff via Slack, 30% data loss | Notion template, sales fills before close | Head of Sales | 0 (1-day setup) | 3h/wk + 1 less re-explain per client |

## High Impact / High Effort (plan for next quarter)

| Process | Pain | Fix | Owner | Cost | Win |
|---|---|---|---|---|---|
| Project profitability tracking | No real-time view, manual quarterly exercise | Implement Productive.io integration + dashboards | COO + Finance | ~12k EUR + 60 days | Real-time gross margin + faster scope decisions |

## Low Impact / Low Effort (do if convenient)
[3 entries omitted]

## Low Impact / High Effort (do not do)

| Process | Why it's low impact / high effort |
|---|---|
| Migrate from Slack to Teams | High effort, marginal productivity win, change-management cost not justified |

## For the Founder/CEO

If you do nothing else, do these three:
1. Stop reviewing invoices <5k EUR. Today. Save 12h/wk and 4 days of cash velocity.
2. Stop reviewing non-exec offer letters. This week. Save 6h/wk.
3. Implement the sales→CS Notion template. Within 14 days. Save 3h/wk + happier clients.

The math: 21 hours per week of founder time reclaimed × 47 working weeks × your blended rate = 6-figure value per year. Implementation cost: ~12 hours of founder + COO time across 3 weeks.
```

That's the shape. 12 processes scored, top-3 surfaced for the executive, with a clear math argument. Replaces what would normally be a 2-week consulting deliverable.

---

## Default rubric (override in `audit_rubric.md`)

**Impact** (1-5 scale):
- 5: Affects revenue or compliance directly
- 4: Affects multiple teams' weekly velocity
- 3: Affects one team's weekly velocity
- 2: Affects individual productivity
- 1: Cosmetic / annoyance

**Effort** (1-5 scale):
- 5: 6+ months, multiple departments, change management
- 4: 1-3 months, one department
- 3: 2-4 weeks, one person
- 2: 1-2 days
- 1: Today

Matrix placement: Impact ≥ 4 + Effort ≤ 2 = "do this quarter".

---

## Non-negotiable rules

- **Every fix has an owner.** No "we should...". A name + role.
- **Every fix has a measure.** "Better" is not a measure. "Save 12h/wk" is.
- **Every fix has a cost.** Including "0" when it's free. Forces honest scope.
- **Past audits are remembered.** Don't re-flag what was fixed.
- **The top-3 summary is mandatory.** A founder will not read 30 process detail blocks. The summary is what survives the meeting.
- **No AI-fluff.** Banned: delve, leverage, harness, robust, seamless, em-dashes.

---

## The actual prompt under the hood

```
SYSTEM: Generate a process audit for {org_name} based on the intake below.

CONTEXT:
- Org context: {org_md_contents}
- Past audits (do not re-flag fixed items): {past_audits_concat}
- Diagnostic rubric: {audit_rubric_md_contents}
- Industry benchmarks: {benchmarks_md_contents OR "none available"}
- Voice rules: {feedback_voice_md_contents}

INPUT:
- Process list with intake data: {processes_md_contents}

OUTPUT STRUCTURE (mandatory):

# Process Audit · {org_name} · {YYYY-MM-DD}

## High Impact / Low Effort (do this quarter)
[Table: Process | Pain | Fix | Owner | Cost | Win]

## High Impact / High Effort (do next quarter)
[Same table format]

## Low Impact / Low Effort (do if convenient)
[Same table format]

## Low Impact / High Effort (do not do)
[Just process name + 1-line "why", no fix needed]

## Per-process detail
[For each process scored: full block with current state, what's broken, cost, proposed fix, effort, risk of not fixing, owner, industry benchmark]

## For the Founder/CEO
If you do nothing else, do these three:
1. [Specific action with owner + win]
2. ...
3. ...

The math: [N] hours per week reclaimed = [EUR] per year at [load].

RULES:
1. Score every process on Impact (1-5) AND Effort (1-5) using the rubric.
2. Every fix MUST have: owner (name + role), cost (currency or "0"), win (specific measure).
3. NEVER recommend a fix without a measure of impact.
4. Top-3 summary MUST cite a real number (not "save time").
5. Do NOT re-flag items present in past_audits as "already fixed".
6. Apply voice rules, no AI-fluff.
7. If a process has insufficient intake data to score, mark it "needs more intake" and skip, do not guess.

SIDE EFFECTS: 
- Save audit verbatim to memory/projects/{engagement}/audits/{YYYY-MM-DD}.md
- Update memory/projects/{engagement}/processes.md with status (audited / fixed / scheduled)
```

Full template at [`prompts/audit-prompt.md`](prompts/audit-prompt.md). Intake template at [`templates/process-intake-template.md`](templates/process-intake-template.md).

---

## Setup (20 minutes)

1. Drop SKILL.md + prompt template + intake template at `~/.claude/skills/audit-process/`
2. Create the engagement directory: `~/.claude/projects/<your-project>/memory/projects/<engagement>/`
3. Populate `processes.md` and `org.md` from your client's intake (use [`templates/process-intake-template.md`](templates/process-intake-template.md))
4. Customize `audit_rubric.md` if your impact/effort scale differs
5. (Optional) Add `memory/_meta/benchmarks_{industry}.md` if you want benchmark-aware fixes
6. Test: `/audit-process` (uses the engagement context)
7. Verify: every fix has owner + cost + win in the output. If not, your prompt isn't enforcing the rules.

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~10.000-30.000 (12-30 processes is a lot of context) |
| Model | Claude Opus 4.7 (the scoring + ranking benefits from depth) |
| Cost per invocation | **~$1.50-4.00** |
| Latency | 30-60 seconds |
| Per-engagement cost (1 audit + ongoing tracking) | **~$5-15** |

Compared to a 2-week consulting deliverable at 15-50k EUR, this is ~99.95% cheaper. The skill complements human consulting (intake + judgment + delivery), it doesn't replace it.

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/audit-pipeline` | Sales pipeline diagnostic, same scoring, different process set | Sales advisory work |
| `/audit-content` | Content engine diagnostic, content workflows scored | Marketing advisory |
| `/audit-stack` | Tech stack diagnostic, tools scored on cost / utility / replaceability | Tech operating reviews |
| `/audit-meetings` | Meeting calendar diagnostic, recurring meetings scored on Impact-Effort | When founder feels meeting-poisoned |
| `/audit-onboarding` | Customer onboarding workflow audit | CS / product advisory |

Same pattern (intake → score on 2 dims → ranked matrix → top-3 summary), different scope.

---

## Common modifications

**1. Add a 3rd dimension to the rubric.** Default is Impact × Effort. Add Risk to make it 3D for regulated industries. Edit `audit_rubric.md`.

**2. Per-industry benchmark integration.** Maintain `memory/_meta/benchmarks_saas.md`, `_meta/benchmarks_agency.md`, etc. Skill picks the right one based on `org.md` industry field.

**3. Track audit-to-implementation conversion.** After 90 days, run `/audit-followup` to score: of the top-3 recommendations, how many were implemented? Tracks your advisory effectiveness.

**4. Multi-language deliverable.** Add `language: de` to engagement context if client wants German output.

**5. Auto-generate the executive deck.** Pipe the audit output into a slide-generation skill that produces a 5-slide PDF for the board meeting.

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1 | Run `/audit-process` on a past engagement you remember well. Compare to your manual audit. |
| 2-3 | Tune the rubric and prompt until output matches what you'd write. |
| 4-7 | Use it on a real new engagement. Edit the output substantially. Don't ship raw. |
| 8-21 | After 3-4 engagements, output should need <10% editing. |
| 22+ | Use as primary deliverable, edit lightly. Audit-to-deliverable goes from 8h → 2h. |

---

## What this won't do (failure modes)

- **Will not interview the client for you.** Process intake is still 60-90 min of human conversation. The skill takes the intake notes and scores, it doesn't extract from the client's silence.
- **Will not understand client politics.** If a process is broken because of a power struggle, the skill suggests the technical fix and misses the people fix.
- **Will hallucinate impact numbers if intake is sparse.** Always force the intake to include "current cost" before scoring. Without that, "Impact" becomes a guess.
- **Will not do change management.** "Stop reviewing invoices <5k" is the recommendation. Getting the founder to actually stop is human work.
- **Top-3 summary depends on rubric quality.** Bad rubric = bad top-3. Calibrate rubric on 2-3 engagements before trusting outputs.

---

## When to delete this skill

If you don't actually do process advisory work, **delete it**. This is highly domain-specific. Reasons it might not work:
- Your audits need on-site observation (skill works on intake notes only)
- Your industry has compliance audits with mandated frameworks (e.g. SOC 2, ISO 9001), use those, not this
- You're internal at one company, only audit your own processes, overkill, just write a list

---

## Why this is a domain example (not universal)

This skill is shaped for advisory / consulting / COO work. The pattern (intake → score on 2 dimensions → output ranked matrix → top-3 summary) reuses for any "diagnostic" workflow:
- `/audit-pipeline`, sales pipeline diagnostic
- `/audit-content`, content engine diagnostic
- `/audit-stack`, tech stack diagnostic

Fork this skill, swap "process" for your domain, keep the rubric structure.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Domain example shown alongside `/sales-script-rewriter` and `/property-pricing` to illustrate "fork the pattern, adapt the specifics".*
