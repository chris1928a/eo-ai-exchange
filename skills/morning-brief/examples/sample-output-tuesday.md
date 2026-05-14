# Sample output — Tuesday morning, mid-week, mid-noise

> Real shape of a `/morning-brief` output, anonymized. Use this as the calibration target when you fork the skill.

---

## Context (what Claude saw at 07:00)

- **Time:** Tuesday 2026-05-12, 07:00 CET
- **Calendar today:** 09:00 board prep, 11:00 sales call (cold prospect, first contact), 14:00 client diagnostic kickoff, 16:00 partner sync, 18:00 family
- **Gmail unread:** 12 messages
- **Open threads file (3 items):** Q3 plan response overdue 2 days, partner quote awaiting OK, dentist confirmation
- **Yesterday's brief log:** ran Mon 07:00, top item was "answer Q3 plan today" — not done
- **Voice rules:** Du-Form internal, no AI-fluff, lead with decisions, terse

---

## Output (posted to Telegram at 07:02:14)

```
1. Q3 plan response is 2 days overdue (was top item Mon). Partner expects answer by 12:00 today.
2. Cold prospect at 11:00 has not confirmed agenda — send 1-line ping by 09:00 or kill.
3. Today: 5 calls, longest gap 12:00-14:00 (use for Q3 plan).
4. Partner quote OK is decay-flagged — answer yes/no in 5 minutes.
5. Dentist confirm slipped from yesterday — 30 sec text.

Top decision today: Q3 plan yes/no by 12:00.
```

---

## What's good about this output

1. **Decision-ordered.** Not chronological. The 12:00 deadline goes to bullet 1.
2. **Repeats acknowledged.** "Was top item Mon" tells the user the system knows yesterday's brief.
3. **Action verbs.** "Send", "answer", "text" — every bullet is actionable.
4. **Specific times.** "By 12:00", "by 09:00", "in 5 minutes" — no "soon" or "today".
5. **Skip-rules.** Bullet 2 ends "or kill" — gives permission to drop the item if not worth pursuing.
6. **Terse top decision.** 8 words. Names the deliverable + the deadline.

---

## What would make this output bad

If the same Tuesday produced this instead, it would fail:

```
Good morning Christoph!

I hope you had a great evening. I wanted to leverage your morning to delve
into what today might unlock for you. Looking at your calendar, I can see
you have a robust day ahead with several seamless transitions between
meetings. Here are some thoughts:

— Your Q3 plan response is still pending; you might want to address that
— There's a sales call later that could use some prep
— You have several other meetings throughout the day
— Don't forget about your open threads
— Have a productive day!

Let me know if I can help with anything else!
```

This fails the voice rules (banned words: leverage, delve, robust, seamless, em-dashes, "I hope"). It fails the format (greeting, sign-off, mega-paragraphs). It fails decision-first (chronological, no rankings). And it fails specificity ("address that", "could use some prep"). If your skill produces this, your prompt template is not loading the voice rules — debug that first.
