# Prompt template — /audit-process

```
SYSTEM: Generate a process audit deliverable for {org_name}.

CONTEXT:
- Org context: {org_md_contents}
- Past audits for this engagement (DO NOT re-flag already-fixed items): {past_audits_concat}
- Diagnostic rubric (Impact × Effort scoring scale): {audit_rubric_md_contents}
- Industry benchmarks: {benchmarks_md_contents OR "none — skip benchmark references"}
- Voice rules: {feedback_voice_md_contents}

INPUT (the processes to audit):
{processes_md_contents}

SCORING (apply rubric to every process):
- Impact (1-5): from rubric
- Effort (1-5): from rubric
- Quadrant placement:
  - Impact ≥ 4 AND Effort ≤ 2 → High Impact / Low Effort
  - Impact ≥ 4 AND Effort ≥ 3 → High Impact / High Effort
  - Impact ≤ 3 AND Effort ≤ 2 → Low Impact / Low Effort
  - Impact ≤ 3 AND Effort ≥ 3 → Low Impact / High Effort

OUTPUT STRUCTURE (mandatory):

# Process Audit · {org_name} · {YYYY-MM-DD}

## High Impact / Low Effort (do this quarter)
| Process | Pain | Fix | Owner | Cost | Win |
|---|---|---|---|---|---|
[All processes scored into this quadrant]

## High Impact / High Effort (do next quarter)
[Same table format]

## Low Impact / Low Effort (do if convenient)
[Same table format]

## Low Impact / High Effort (do not do)
| Process | Why low impact / high effort |
|---|---|
[Just name + 1-line reasoning, no fix block]

## Per-process detail (one section per process)
### {Process Name}
- **Current state:** [from intake]
- **What's broken:** [from intake]
- **What it costs:** [time / money / quality measure, with units]
- **Proposed fix:** [specific action]
- **Effort to implement:** [days / weeks / months]
- **Risk of NOT fixing:** [consequence in 6 months]
- **Owner:** [name + role]
- **Industry benchmark:** [if benchmarks available, what other companies in this industry did about this — else skip]

## For the Founder/CEO

If you do nothing else, do these three:
1. [Specific action] — [Owner] — [Win measure]
2. ...
3. ...

The math: [N hours per week reclaimed] × [working weeks per year] × [blended rate] = [EUR per year value]
Implementation cost: [hours and currency cost across N weeks]

NON-NEGOTIABLE RULES:
1. EVERY fix MUST have: owner (name + role), cost (currency or "0"), win (specific measurable outcome).
2. NEVER recommend a fix without an Impact measure (e.g. "save 12h/wk", not "save time").
3. NEVER re-flag items present in past_audits as "already fixed".
4. Top-3 summary MUST cite real numbers — not "improve efficiency".
5. Apply voice rules: no AI-fluff (delve, leverage, harness, robust, seamless), no em-dashes.
6. If a process has insufficient intake data to score, mark "NEEDS MORE INTAKE" in the per-process section and SKIP it from the matrix — do not guess.
7. Per-process details ordered by quadrant (high-impact-low-effort first).

SIDE EFFECTS:
1. Save the audit verbatim to memory/projects/{engagement}/audits/{YYYY-MM-DD}.md
2. Update memory/projects/{engagement}/processes.md with each process's status (audited / scheduled / fixed)
3. Log invocation to memory/_meta/skill_log.md

OUTPUT: just the audit deliverable. No preamble. No closing.
```

---

## Performance notes

- ~10.000-30.000 input tokens (large context: org + processes + past audits + benchmarks)
- Opus 4.7 required (rubric application + ranking + top-3 selection benefits from depth)
- ~$1.50-4.00 per invocation
- 30-60 seconds latency
- Per-engagement: 1 audit + 2-3 follow-ups over 90 days = ~$5-15 total
