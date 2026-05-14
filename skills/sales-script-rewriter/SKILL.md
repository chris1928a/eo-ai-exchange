---
name: sales-script-rewriter
type: domain-example
audience: For sales founders, heads of sales, SDR managers
load_when: sales script, rewrite script, call coaching, score this call, sales transcript
---

# /sales-script-rewriter

> **Domain-example skill from Event #1, Demo 1 (Chris). For sales founders / SDR managers.**
> Sales call coaching from transcripts. Scores 6 dimensions per call. Rewrites the script per rep, used live with the sales floor.

---

## Purpose

Most sales coaching is anecdotal: "I think Rep A talks too much" / "I feel Rep B is good on objections." This skill replaces vibes with a 6-dimension score per call, identifies pattern weaknesses across a rep, and outputs a rewritten script tuned to that rep's actual gaps. Used live with sales teams, not as theory.

The pattern is: **transcript-in → score on 6 dimensions → trend across last N calls → rewrite the section with weakest score → top-3 fixes for the rep**. Reusable for any "scored coaching from recordings" workflow.

---

## Inputs

1. **Call transcript(s)**, paste-in, or pulled from Fathom / Granola / Gong via MCP
2. **Rep ID**, name, resolved to `memory/people/sales/{rep-slug}.md`
3. **Current script**, `memory/sales/scripts/{rep}_current.md` if you have one
4. **Buyer ICP**, `memory/sales/icp.md` (who you are selling to)
5. **Past scores for this rep**, `memory/sales/scores/{rep}/` (so we trend, not just snapshot)
6. **Scoring rubric**, `memory/_meta/sales_rubric.md` (defaults below)
7. **Voice rules**, for tone of the deliverable

---

## Outputs

### A. Per-call score sheet

```markdown
# Call Score · {rep-name} · {YYYY-MM-DD HH:MM} · {prospect-name}

## Headline
- Outcome: [meeting booked / lost / pending]
- Talk ratio: 42% rep / 58% prospect (target: 40/60)
- Longest monologue: 87s (target: <60s)
- Discovery questions asked: 4 (target: ≥6)

## 6-dimension score (1-5 each)
1. Opening hook: 3
2. Discovery quality: 2 ← weakest
3. Objection handling: 4
4. Value framing: 3
5. Closing crispness: 2 ← weakest
6. Listen-to-talk discipline: 3

Total: 17/30 (last 5 calls average: 16/30)

## Top 3 fixes for this rep, this week
1. **Discovery:** Ask the "What changed in the last 90 days?" question every call
2. **Closing:** Stop offering 3 meeting times, offer 2 + "or what works"
3. **Listen:** When prospect says "interesting", count to 3 before responding
```

### B. Rewritten script section (whatever the rep is weakest on)

```markdown
## Discovery section, rewrite for {rep-name}

### Old
[verbatim from current script]

### New (tuned to your weak spot: discovery quality)
[rewritten section, with the 3 fixes above embedded]

### What to practice this week
- 3 reps of the new opening, recorded
- Send recording to {coach-name} for review by Friday
```

---

## Worked example, second call score for a rep on a 5-call streak

**Context:** Rep "Rep A" has had 5 calls scored. This is call 6. Trend shows persistent weakness in discovery + closing.

**Output:**

```markdown
# Call Score · Rep A · 2026-05-15 14:30 · Acme Corp

## Headline
- Outcome: meeting booked, qualified opportunity
- Talk ratio: 47% rep / 53% prospect (target: 40/60), slightly over
- Longest monologue: 71s (target: <60s), over
- Discovery questions asked: 5 (target: ≥6), close but missed

## 6-dimension score
1. Opening hook: 4 (named buyer's role pain in first 30s)
2. Discovery quality: 2 ← weakest (5 questions, mostly closed yes/no)
3. Objection handling: 4 (handled "we already have a vendor" cleanly)
4. Value framing: 3 (features, not buyer outcomes)
5. Closing crispness: 3 (offered 3 times, prospect picked one, should have offered 2)
6. Listen-to-talk discipline: 3 (paused mid-pitch when prospect interjected, good)

Total: 19/30 (improving from 16/30 last week)

## Trend across last 5 calls
- Discovery quality: 2.2 average (PERSISTENT WEAKNESS)
- Closing crispness: 2.4 average (PERSISTENT WEAKNESS)
- Opening hook: 3.6 → 4 (improving)
- Listen-to-talk: 2.8 → 3 (improving)
- Other dimensions stable

## Top 3 fixes for this rep, this week
1. **Discovery:** Add the "What changed in the last 90 days that triggered this conversation?" question to every call. Track in skill log. (Targets persistent dim 2 weakness.)
2. **Closing:** Stop offering 3 meeting times. Offer EXACTLY 2 + "or what works for you." (Targets persistent dim 5 weakness.)
3. **Talk ratio:** Cut the longest monologue by 10s. Practice the value framing in 50s, not 71s.

## Discovery section rewrite

### Old (current script)
"Tell me about your current solution. What are you using today?"
"How is that working for you?"
"Are you happy with it?"

### New (tuned to dim 2 weakness)
"Walk me through what changed in the last 90 days that made this a real conversation today."
"What does success look like for you in the next quarter?"
"Who else internally needs to see this work for it to land?"

### What Rep A practices this week
- Run 3 mock calls using the new discovery questions, recorded
- Send recording to {coach-name} by Friday for review
- Track in `/sales-rep-tracker` whether the new questions actually got asked
```

That's the shape. Real, trend-aware, actionable. Replaces 60 minutes of "let me listen to the recording and give vibes-based feedback" with 3 minutes of structured coaching output.

---

## 6-dimension scoring rubric (defaults)

| Dimension | 1 (poor) | 3 (decent) | 5 (excellent) |
|---|---|---|---|
| Opening hook | Generic intro | Names buyer's role pain | Names buyer's *yesterday* pain with evidence |
| Discovery quality | Closed yes/no questions | Open questions, surface | "What changed?" + "Walk me through the last time..." |
| Objection handling | Rebuts | Acknowledges then redirects | Gets ahead of common objections preemptively |
| Value framing | Features | Benefits | Buyer's outcomes in their language |
| Closing crispness | "Want to set something up?" | Offers 3+ times | Offers 2 + "or what works" + commitment ladder |
| Listen-to-talk | <30% buyer talk | 40-50% buyer talk | 50-60% buyer talk + uses pauses |

Override per-org in `sales_rubric.md`.

---

## Non-negotiable rules

- **Score every dimension.** Even if "n/a", explain why.
- **Top 3 fixes maximum.** A rep cannot work on 6 things this week.
- **Rewrites are surgical.** Rewrite only the section the rep is weakest on. Don't rewrite the whole script.
- **Trend over snapshot.** Show the 5-call rolling average so reps see progress.
- **One fix has a measure.** "Be more curious" is not a fix. "Ask the 'what changed' question every call" is.
- **No AI-fluff.** Banned: delve, leverage, harness, robust, seamless.

---

## The actual prompt under the hood

```
SYSTEM: Score this sales call from {rep_name} and produce coaching output.

CONTEXT:
- Buyer ICP: {sales_icp_md_contents}
- This rep's past 5 scores (for trend detection): {rep_past_scores_concat}
- Current script for this rep: {rep_current_script_md OR "no script on file"}
- Scoring rubric: {sales_rubric_md_contents}
- Voice rules: {feedback_voice_md_contents}

INPUT:
- Call transcript: {transcript}
- Outcome: {outcome, meeting booked / lost / pending}

SCORING (apply rubric to every dimension):
1. Opening hook (1-5)
2. Discovery quality (1-5)
3. Objection handling (1-5)
4. Value framing (1-5)
5. Closing crispness (1-5)
6. Listen-to-talk discipline (1-5)

For each dimension, cite a specific moment in the transcript that justifies the score.

OUTPUT STRUCTURE (mandatory):

# Call Score · {rep-name} · {YYYY-MM-DD HH:MM} · {prospect-name}

## Headline
- Outcome
- Talk ratio (rep% / prospect%) vs target 40/60
- Longest monologue (seconds) vs target <60s
- Discovery questions count vs target ≥6

## 6-dimension score (each 1-5 with brief justification + transcript citation)
1. ...
[mark weakest dimensions with ←]

Total: N/30 (last 5 calls average: M/30)

## Trend across last 5 calls
[For each dimension: average + direction (improving/declining/stable)]
[Flag PERSISTENT WEAKNESS where average ≤ 2.5 across 3+ calls]

## Top 3 fixes for this rep, this week
1. [Dimension]: [specific action with measurable outcome]
2. ...
3. ...

## Rewritten script section (the weakest dimension)
### Old (verbatim from current script)
### New (tuned to weak spot)
### What to practice this week (specific, recorded)

RULES:
1. EVERY dimension scored. No skipping.
2. EVERY score cites a specific transcript moment.
3. Top 3 fixes ONLY (not 4, not 5).
4. Rewrites are SURGICAL, only the weakest section.
5. Trend MUST flag persistent weaknesses (≤ 2.5 avg across 3+ calls).
6. Apply voice rules.
7. If the rep has < 3 past scores, skip "Trend" section, do not invent.

SIDE EFFECTS:
- Save score to memory/sales/scores/{rep-slug}/{YYYY-MM-DD}.md
- Update memory/sales/scripts/{rep-slug}_current.md with the rewrite (or create new file)
- Log invocation to memory/_meta/skill_log.md
```

Full template at [`prompts/score-prompt.md`](prompts/score-prompt.md). Rubric at [`templates/sales-rubric.md`](templates/sales-rubric.md).

---

## Setup (30 minutes)

1. Drop SKILL.md + prompts + templates at `~/.claude/skills/sales-script-rewriter/`
2. Create `~/.claude/projects/<your-project>/memory/sales/` with subfolders: `scripts/`, `scores/`, `icp.md`
3. Connect Fathom / Granola / Gong MCP if available (otherwise paste transcripts manually)
4. Customize `sales_rubric.md` for your sales motion (B2B SaaS ≠ retail ≠ enterprise)
5. Test: paste a transcript, run `/sales-script-rewriter {rep-name}`
6. Verify: every dimension scored with transcript citation, top-3 has measurable outcomes

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~8.000-25.000 (transcript can be long) |
| Model | Claude Opus 4.7 (scoring + rewriting + trend reasoning needs depth) |
| Cost per invocation | **~$0.80-2.50** |
| Latency | 20-45 seconds |
| Monthly cost (10 reps × 5 calls/wk = 200 calls/mo) | **~$160-500** |

Most expensive of the universal-pattern skills, but justified, it replaces a sales coach role at 6-figure salary. Use Sonnet 4.6 if you can accept shallower trend detection (drops cost ~50%).

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/customer-success-coach` | CS call coaching, different rubric (renewal rate, expansion signals) | CS team management |
| `/recruiter-coach` | Recruiting call coaching, different rubric (candidate fit signals) | Recruiting ops |
| `/founder-pitch-coach` | Investor pitch coaching, different rubric (clarity, traction story) | Pre-fundraise prep |
| `/discovery-call-only` | Subset focused on first-call discovery quality | Top-of-funnel teams |
| `/closing-coach` | Subset focused on closing tactics across all calls | Late-stage deal coaching |

Same pattern (transcript-in → score → trend → top-3 fixes → script rewrite), different rubric.

---

## Common modifications

**1. Add buyer-side scoring.** Score the prospect's engagement signals too (interest level, decision maker presence, urgency). Useful for forecasting.

**2. Per-segment rubrics.** SMB calls scored on different criteria than enterprise. Add `sales_rubric_smb.md` and `sales_rubric_enterprise.md`, switch per ICP.

**3. Multi-language scoring.** German calls scored with German rubric phrases, English calls with English. Add `language` field to call metadata.

**4. Auto-trigger on Fathom/Gong recording.** Wire a webhook so every recorded call gets scored automatically within 5 minutes of the call ending.

**5. Coach dashboard.** Aggregate scores across reps weekly into a leaderboard. Identifies coaching priorities for the manager.

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1-3 | Score 3 past calls manually + with skill. Compare. Tune rubric. |
| 4-7 | Score real new calls daily. Edit output substantially before sharing with reps. |
| 8-21 | After 5+ calls per rep, trend detection kicks in. Outputs need <20% editing. |
| 22-60 | Reps see consistent feedback patterns. Their scores should improve measurably. |
| 60+ | Audit the audit: did rep scores actually improve? If not, your rubric is wrong. |

---

## What this won't do (failure modes)

- **Will not catch tone/empathy/rapport from text alone.** A great-sounding call may score average if the rapport happened in non-verbal cues. Mitigation: weight transcript scores 70%, manual rapport check 30%.
- **Will hallucinate scores if the transcript is bad.** Whisper / Deepgram errors cascade. Spot-check the transcript before trusting the score.
- **Will not coach the rep.** It produces the coaching output. Getting the rep to act on it is human work.
- **Trend detection requires consistent transcript quality.** If transcripts vary in completeness, trend is noisy.
- **Compliance:** call recording requires consent. See [`solutions/security-gdpr/gdpr-claude-checklist-dach.md`](../../solutions/security-gdpr/gdpr-claude-checklist-dach.md) for DACH considerations.

---

## When to delete this skill

If you're not actually a sales-coaching role, **delete it**. Reasons it might not work:
- Your team is too small to need standardized coaching (just talk to your reps)
- Your sales motion is consultative + relationship-driven, not transactional
- Your reps reject scoring as a coaching tool, culture matters more than the skill

---

## Why this is a domain example (not universal)

This skill is shaped for sales coaching. The pattern (transcript-in → score on N dimensions → output ranked fixes + rewritten section) reuses for any "scored coaching" workflow. Fork this skill, swap the rubric, keep the structure.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Domain example shown alongside `/audit-process` and `/property-pricing`.*
