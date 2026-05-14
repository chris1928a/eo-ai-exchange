# Sample output, Monday after a holiday weekend

> Edge case: low-data Monday where calendar is empty and inbox is huge from the holiday backlog. Use to verify your skill handles this gracefully.

---

## Context (what Claude saw at 07:00)

- **Time:** Monday 2026-05-19, 07:00 CET (after Pfingstmontag long weekend)
- **Calendar today:** 14:00 internal weekly only, no other meetings
- **Gmail unread:** 47 messages (3-day backlog)
- **Open threads file:** 3 stale items, all from Thursday before the long weekend
- **Yesterday's brief log:** no brief Sunday (cron skipped weekends)
- **Voice rules:** as before

---

## Output (posted to Telegram at 07:01:48)

```
1. 47 unread emails from the long weekend. Top sender: a recurring partner pinged 3x, open that thread first.
2. The 3 open threads from Thursday are now 4 days old. Decay-flag any you don't act on by Wednesday.
3. Calendar empty until 14:00, protect this morning for the inbox sweep.
4. No critical deadlines from the inbox top-10. Stay disciplined on what to delete vs respond.
5. Last week's open Q3 plan (still unresolved), pre-block 10:00-11:00 for it.

Top decision today: drain the inbox to <10 by lunch, then Q3 plan in the protected slot.
```

---

## What's different about a low-data day

- **No "decision urgency" because there are no fixed deadlines.** Bullet 1 falls back to "highest signal sender".
- **Calendar gap becomes the asset, not a problem.** Bullet 3 reframes the empty morning as protected work time.
- **Yesterday's brief absent (weekend skip).** Top decision draws from older context (last week's Q3 plan).
- **Emphasis shifts to triage discipline.** Bullet 4 explicitly tells the user to be willing to delete, not just respond.

If your skill produces a brief that pretends Monday is high-stakes when it isn't, it loses trust within 2-3 weeks. Better to be honest about a quiet morning.
