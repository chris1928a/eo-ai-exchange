# Prompt template — /sales-script-rewriter

```
SYSTEM: Score this sales call from {rep_name} and produce coaching output for {user_name}.

CONTEXT:
- Buyer ICP definition: {sales_icp_md_contents}
- This rep's past 5 scores (for trend detection): {rep_past_scores_concat OR "fewer than 5 past scores, skip trend section"}
- Current script for this rep: {rep_current_script_md OR "no script on file"}
- Scoring rubric: {sales_rubric_md_contents}
- Voice rules: {feedback_voice_md_contents}

INPUT:
- Call transcript: {transcript}
- Outcome: {outcome}
- Call duration: {duration_minutes} minutes
- Date/time: {YYYY-MM-DD HH:MM}
- Prospect: {prospect_name}, {prospect_company}

ANALYSIS TASKS:

1. Calculate quantitative metrics:
   - Talk ratio: rep words / total words
   - Longest monologue: longest contiguous rep speech in seconds
   - Discovery questions count: number of open questions asked by rep
   - Number of buyer interruptions
   
2. Score each of the 6 dimensions (1-5):
   - Opening hook
   - Discovery quality
   - Objection handling
   - Value framing
   - Closing crispness
   - Listen-to-talk discipline
   
   Each score MUST cite a specific moment in the transcript ("at ~03:24 the rep said...").

3. Trend detection (if past 5 scores available):
   - Per dimension: average across last 5, direction (improving/stable/declining)
   - Flag PERSISTENT WEAKNESS where average ≤ 2.5 across 3+ calls

4. Top 3 fixes for this week:
   - Tied to the dimensions with lowest score OR persistent weakness
   - Each fix is specific + measurable + actionable in the next 7 days

5. Rewrite the section of the script tied to the weakest dimension:
   - Old: verbatim from current script
   - New: tuned to the weak spot, NOT a wholesale rewrite
   - Practice plan: specific, recorded, accountable

OUTPUT STRUCTURE (mandatory):

# Call Score · {rep-name} · {YYYY-MM-DD HH:MM} · {prospect-name}

## Headline
- Outcome: ...
- Talk ratio: N% rep / M% prospect (target: 40/60)
- Longest monologue: Ns (target: <60s)
- Discovery questions: N (target: ≥6)

## 6-dimension score
1. Opening hook: N — [transcript citation, e.g. "at ~01:12, rep opened with..."]
2. Discovery quality: N — [transcript citation]
[etc.]
Mark the weakest with ←

Total: N/30 (last 5 average: M/30)

## Trend across last 5 calls (skip if < 3 past scores)
- Opening hook: avg X.X (improving/stable/declining)
- Discovery quality: avg X.X — PERSISTENT WEAKNESS if ≤2.5 across 3+ calls
[etc.]

## Top 3 fixes for this rep, this week
1. **{Dimension}:** [specific measurable action in 7 days]
2. **{Dimension}:** [specific measurable action in 7 days]
3. **{Dimension}:** [specific measurable action in 7 days]

## Rewritten script section: {weakest dimension}

### Old (verbatim from current script)
[paste from rep_current_script_md]

### New (tuned to weak spot)
[surgical rewrite, not whole-script]

### What to practice this week
- N mock calls recorded with new section
- Send recording to {coach_name} for review by {YYYY-MM-DD}

RULES:
1. EVERY dimension scored, no skipping.
2. EVERY score cites a specific transcript moment.
3. Top 3 fixes ONLY (not 4, not 5).
4. Rewrites are SURGICAL.
5. If < 3 past scores, skip Trend section — do not invent.
6. Apply voice rules.
7. If transcript quality is bad (lots of [inaudible] / [unclear]), say so up top and lower confidence on scores.

SIDE EFFECTS:
- Save score to memory/sales/scores/{rep-slug}/{YYYY-MM-DD}.md
- Update memory/sales/scripts/{rep-slug}_current.md with the rewritten section (mark date)
- Log to memory/_meta/skill_log.md
```

---

## Performance notes

- ~8.000-25.000 input tokens (transcript size dominates)
- Opus 4.7 required for scoring + trend + rewrite
- $0.80-2.50 per call score
- 10 reps × 5 calls/week = 200 calls/mo = $160-500/mo
- Latency 20-45 seconds
