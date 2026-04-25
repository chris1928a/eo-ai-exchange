# Contributing

Three ways to contribute. All are welcome from any EO/YPO/Founder-Network member or AI-curious operator.

---

## 1. Submit a pain (open an issue)

If you are stuck on something AI-setup-related, open a GitHub issue tagged `pain`. Use this template:

```
**My setup today:** (1-2 sentences)
**My pain:** (1 sentence)
**What I have tried:** (bullet list)
**What I would need to unblock:** (1 sentence)
```

We aggregate pains for the next event. If 10+ similar pains accumulate, we create a dedicated solution cluster.

---

## 2. Submit a solution (open a PR)

Found something that works? Open a PR with a markdown file in the appropriate `solutions/<cluster>/` folder, or a runnable skill in `skills/`.

### Solution markdown format

```markdown
# Solution Title

**Pain cluster:** Tool Overload (or whichever)
**Author:** Your Name (EO Chapter)
**Date:** YYYY-MM-DD
**Tested with:** Claude Sonnet 4.6 / Opus 4.7 / etc.

## Context

What problem does this solve, in 1 paragraph.

## Approach

Step-by-step. Be specific. Include actual prompts, code, or commands.

## Results

What happened when you used this. Include metrics where possible.

## Caveats

What did NOT work, what to watch out for, when this approach is wrong.

## Sources / References

Links to docs, blog posts, papers.
```

### Runnable skill format

Skills go in `skills/<skill-name>/` and follow the [Claude Code Skills spec](https://docs.claude.com/skills):

- `SKILL.md` (description, when-to-trigger, instructions)
- Optional: `examples/` folder with sample inputs/outputs
- Optional: `scripts/` folder with helper code

---

## 3. Apply to speak

Fill the speaker application form: [link populated after Event #1 launch].

We review applications weekly. Slot offers come within 7 days.

---

## Review process

- Pull requests are reviewed within 7 days
- Reviewer team: Christoph Erler (host), Dominik Raute (host), and rotating community reviewers
- We optimize for **practical, tested, honest** content. We reject:
  - Vendor pitches disguised as solutions
  - Theoretical frameworks without lived experience
  - Anything that violates Chatham House Rule (citing speakers without permission)

---

## Code of conduct

- Be honest about what works and what does not
- No vendor incentivization (if a vendor sponsors your time, disclose it)
- No personal attribution without consent (Chatham House)
- Be specific (no vague „AI saves time")
- Respect the audience: this is for operators, not for AI hype

---

## Recognition

All contributors are credited:
- Solution authors: byline in the solution file
- Speakers: profile in `speakers/alumni/`
- Pain submitters: thanked in the relevant solution file (anonymously by default, opt-in for attribution)

---

*Updated 2026-04-25.*
