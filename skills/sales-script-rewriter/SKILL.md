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

---

## Inputs

1. **Call transcript(s)** — paste-in, or pulled from Fathom / Granola / Gong via MCP
2. **Rep ID** — name, resolved to `memory/people/sales/{rep-slug}.md`
3. **Current script** — `memory/sales/scripts/{rep}_current.md` if you have one
4. **Buyer ICP** — `memory/sales/icp.md` (who you are selling to)
5. **Past scores for this rep** — `memory/sales/scores/{rep}/` (so we trend, not just snapshot)
6. **Scoring rubric** — `memory/_meta/sales_rubric.md` (defaults below)

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

## Setup (30 minutes)

1. Drop this file at `~/.claude/skills/sales-script-rewriter/SKILL.md`
2. Create `~/.claude/projects/<your-project>/memory/sales/` with subfolders: `scripts/`, `scores/`, `icp.md`
3. Connect Fathom / Granola / Gong MCP if available (otherwise paste transcripts manually)
4. Customize `sales_rubric.md` for your sales motion (B2B SaaS ≠ retail ≠ enterprise)
5. Test: paste a transcript, run `/sales-script-rewriter {rep-name}`

---

## Honest caveats

- **Transcript quality matters.** Whisper / Deepgram errors cascade. Spot-check the transcript before scoring.
- **First-time scoring on a rep is shallow.** No history yet. Run 5-10 calls before trusting the trend.
- **Rep buy-in is the real bottleneck.** A rep who doesn't believe the score will not work the fixes. Frame as coaching tool, not performance review.
- **Compliance:** call recording requires consent. See [`solutions/security-gdpr/gdpr-claude-checklist-dach.md`](../../solutions/security-gdpr/gdpr-claude-checklist-dach.md) for DACH considerations.

---

## Why this is a domain example (not universal)

This skill is shaped for sales coaching. The pattern (transcript-in → score on N dimensions → output ranked fixes + rewritten section) reuses for any "scored coaching" workflow:
- `/customer-success-coach` — CS call coaching
- `/recruiter-coach` — recruiting call coaching
- `/founder-pitch-coach` — investor pitch coaching

Fork this skill, swap the rubric, keep the structure.

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Domain example shown alongside `/audit-process` and `/property-pricing` to illustrate "fork the pattern, adapt the specifics".*
