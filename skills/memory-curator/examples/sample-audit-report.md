# Sample audit report, Sunday, 4-week-old brain

> Real shape of `/memory-curator` output, anonymized. Use as calibration target.

---

## Output (posted Sun 14:00 to Telegram + appended to last_audit.md)

```markdown
# Memory Audit · 2026-05-17

## Health
- Total files: 87 (+12 since last audit 2026-05-10)
- Stale (no reference in 90+ days): 0 (brain too young)
- Contradictions detected: 1
- Duplicates suggested for merge: 2
- Empty files auto-pruned: 1
- Promotions from chat → memory: 3 candidates

## Contradictions found
1. feedback_voice.md says "always Du form for founders"
   feedback_voice.md ALSO says "Sie form for first contact via LinkedIn"
   → These can both be true. Suggest scoping: "Du after the first reply, Sie on first cold contact"

## Duplicates suggested for merge
1. feedback_email_tone.md (12 lines) + feedback_email_style.md (18 lines)
   → 70% overlap on email-specific rules
   → Suggest: merge to feedback_email.md, keep both for 1 audit cycle for verification
2. people/anna_beispiel.md + people/anna_b.md
   → Same person, different slugs, likely created on different days
   → Suggest: merge to people/anna_beispiel.md, redirect anna_b.md as a stub

## Stale entries
None yet (brain only 4 weeks old). First stale candidates expected ~week 12.

## Promotions from chat → memory (3 candidates)
1. Conversation 2026-05-15 09:14: you flagged "never CC {colleague} on financial docs"
   → Suggest: create feedback_{colleague}.md OR add to people/{colleague}.md
2. Conversation 2026-05-16 16:42: you said "for any pricing decision, ALWAYS check competitor floor first"
   → Suggest: add to memory/hats/real-estate.md as a non-negotiable rule
3. Conversation 2026-05-17 11:08: you said "Q3 plan top priority for next 4 weeks"
   → Suggest: create memory/projects/q3-plan.md OR add to top of memory/user_about.md

## What I changed automatically (--auto mode)
- Removed 1 empty file: feedback_temp.md (0 bytes after frontmatter strip)
- Updated MEMORY.md index: added 12 new entries from this week, sorted by category
- Created memory/_archive/2026-05-17/ folder for future archival use

## Recommendations for human review
- Review the 1 contradiction (~5 min)
- Approve/reject the 2 merge suggestions (~5 min)
- Decide on the 3 chat-promotion candidates (~5 min)
- Total review time: ~15 min, run weekly
```

---

## What's good about this audit

1. **Specific.** Every finding cites file paths + line ranges + dates.
2. **Honest about youth.** "0 stale, brain too young", doesn't invent stale entries.
3. **Auto vs flagged separation.** Auto-actions are listed transparently. Anything with judgment is flagged.
4. **Realistic time estimate.** "15 min total" sets a reasonable Monday-morning commitment.
5. **Promotion candidates have context.** Each one quotes the conversation, not just "consider promoting".

If your audit just says "all good" every week, your prompt isn't working, there's always something to find in a 80+ file brain.
