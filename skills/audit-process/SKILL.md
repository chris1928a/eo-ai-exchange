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

---

## Inputs

1. **Process list** — paste-in or read from `memory/projects/<engagement>/processes.md`. Each process: name, owner, frequency, current pain.
2. **Org context** — `memory/projects/<engagement>/org.md` (size, stage, revenue, current pressure)
3. **Diagnostic rubric** — `memory/_meta/audit_rubric.md` (your scoring criteria — defaults below)
4. **Past audits** — `memory/projects/<engagement>/audits/` (so you don't re-flag fixed items)
5. **Voice rules** — for tone of the deliverable

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

## Setup (20 minutes)

1. Drop this file at `~/.claude/skills/audit-process/SKILL.md`
2. Create the engagement directory: `~/.claude/projects/<your-project>/memory/projects/<engagement>/`
3. Populate `processes.md` and `org.md` from your client's intake
4. Customize `audit_rubric.md` if your impact/effort scale differs
5. Test: `/audit-process` (uses the engagement context)

---

## Honest caveats

- **Process intake is the bottleneck, not the analysis.** Plan 60-90 min to interview the owner before running the skill.
- **Without numbers, the output is opinion.** If you can't get a baseline measure for a process (current time, current cost, current error rate), the matrix becomes hand-waving.
- **Owners reject blame.** Frame fixes as system changes, not as "X is bad at Y". Adjust your voice rules accordingly.
- **The matrix is a snapshot.** Re-run after 90 days to verify fixes landed and to surface new pain.

---

## Why this is a domain example (not universal)

This skill is shaped for advisory / consulting / COO work. The pattern (intake → score on 2 dimensions → output ranked matrix → top-3 summary) reuses for any "diagnostic" workflow:
- `/audit-pipeline` — sales pipeline diagnostic
- `/audit-content` — content engine diagnostic
- `/audit-stack` — tech stack diagnostic

Fork this skill, swap "process" for your domain, keep the rubric structure.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Domain example shown alongside `/sales-script-rewriter` and `/property-pricing` to illustrate "fork the pattern, adapt the specifics".*
