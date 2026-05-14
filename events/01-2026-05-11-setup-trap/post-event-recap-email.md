# Post-Event Recap Email

**To:** All Event #1 registrants (118)
**From:** Chris Erler, on behalf of Chris / Dom / Fabian
**Send via:** Luma "Email all attendees"
**Subject options (pick one):**
- A) `EO AI Exchange #1 — the slides, the repo, and the 5 things we'd do differently`
- B) `Recap + the OpenClaw pitfalls everyone hits (and how we'd avoid them)`
- C) `Your fork-this gift from Monday's session`

**Recommended subject:** A.

---

## Email body (paste into Luma)

Hey,

Thanks for showing up Monday night — 50 of you in the live room, 118 registered, 53 EO chapters across 4 continents. Energy was nuts, the hour disappeared.

We promised "fork tonight, use tomorrow." Here is everything in one place.

**The repo (fork-ready):**
👉 **[github.com/chris1928a/eo-ai-exchange](https://github.com/chris1928a/eo-ai-exchange)**

Brand new on the repo since Monday — we shipped these for you over the last 48 hours:
- **[`START-HERE.md`](https://github.com/chris1928a/eo-ai-exchange/blob/main/START-HERE.md)** — 3-step path if you have never used GitHub before
- **[`setups/`](https://github.com/chris1928a/eo-ai-exchange/tree/main/setups)** — three working architectures: Chris (Workspace-native, ~150 EUR/mo), Dom (local-first, ~$0/mo, link to his anonymized architecture doc), Fabian (PAI v5.0.0)
- **[`resources/glossary.md`](https://github.com/chris1928a/eo-ai-exchange/blob/main/resources/glossary.md)** — plain-language defs for Claude Code, MCP, Skills, Hooks, ZDR, EU AI Act and 30+ more

**The decks (live links, printable as PDF in your browser):**
- [Joint deck (22 slides)](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/slides.html)
- [Chris's deep dive (44 slides, body-mapped tools)](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html)
- [Q&A backup (15 slides, all 12 Slido questions answered)](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/qa-deck.html)

**The 11 solutions** (one per audience pain cluster from your registration responses): [`SOLUTIONS.md`](https://github.com/chris1928a/eo-ai-exchange/blob/main/SOLUTIONS.md)

---

### The 5 OpenClaw pitfalls everyone burns their fingers on

We compressed a year of pain into one list. If you only read one section of this email, read this one.

1. **Memory drift.** You set up memory files, you stop auditing them, three weeks later the brain is running on lies. **Fix:** weekly `/audit-memory` skill on a cron.
2. **Hook hell.** `settings.json` grows tentacles. One bad PreToolUse hook breaks every command silently. **Fix:** keep settings.json under 100 lines. Comment every hook with what it protects against.
3. **MCP maze.** You install 31 MCP servers because each looks useful. You forget what each does. Two go broken and you don't notice for weeks. **Fix:** start with 5. Add one only when a real need surfaces.
4. **Skill spam.** 50 skills with mediocre descriptions = nothing triggers correctly. The frontmatter `description` field is 80% of the work. **Fix:** spend 10 minutes per skill on the trigger sentence.
5. **No memory discipline.** New users dump everything into one giant CLAUDE.md. It works for a week, then context bloat eats every conversation. **Fix:** types and files. user/feedback/project/reference. Never one file.

CVE-2026-25253 details and 5 alternative orchestrators are in [`solutions/openclaw-honest/openclaw-honest-assessment.md`](https://github.com/chris1928a/eo-ai-exchange/blob/main/solutions/openclaw-honest/openclaw-honest-assessment.md).

---

### If we'd start over today (the Slido top-voted question)

5 things, in order of regret:

1. **Memory before tools.** Write the user/feedback/project memory files on day one. Most of us wasted weeks installing MCP servers before we had any persistent context.
2. **One stack, not five.** v1-v3 of every personal setup are dead. Pick one and commit. Trying to keep ChatGPT + Claude + Notion + Zapier + custom code in parallel is the trap.
3. **Markdown over Vector-DB until 10k+ unstructured docs.** Files in folders work shockingly well. Vector DBs add complexity most personal brains don't need.
4. **Skills, not custom code.** Default to a skill until it's proven impossible. Custom Python helpers from month one all got replaced by skills within 90 days.
5. **No vendor lock-in at the prompt layer.** Every memory file and every skill in plain Markdown. If your provider disappeared tomorrow, your brain should run on the next one.

---

### What's next?

We are running this as a continuous series — next event fires when there's something genuinely worth meeting for (model release, MCP standard shift, or audience pain cluster maturing). Default cadence: 60-90 days.

**One ask:** what should the next exchange be about? Reply to this email with one sentence — the pain you want solved, the topic you want demoed, or the operator you want to hear from.

We aggregate responses. Top theme wins.

If you want to **submit a pain** or **propose a solution** any time, the GitHub issue + PR templates are in [`CONTRIBUTING.md`](https://github.com/chris1928a/eo-ai-exchange/blob/main/CONTRIBUTING.md).

If you want to **speak at the next one**, see [`speakers/README.md`](https://github.com/chris1928a/eo-ai-exchange/blob/main/speakers/README.md).

Thanks again for the time on Monday. Fork the repo, break things, tell us what worked.

Chris, Dom, Fabian
EO AI Productivity Exchange

---

*P.S. Chatham House Rule applies to everything from the live session. Share the information, not the attribution.*

---

## Notes for sending

- **Format:** Luma's "Email all attendees" supports basic Markdown. The bold + bullet structure renders fine.
- **Personalization token:** Add `{{first_name}}` after "Hey," if you want first-name-personalized opener — Luma supports it.
- **Send time recommendation:** Tuesday or Wednesday morning EU time (9-10 CEST), highest open rates for B2B operator audiences.
- **Reply tracking:** Replies to this email come back to the address you used as From. If you want them to land somewhere specific (e.g. a shared inbox), set that up before sending.
- **Length check:** ~520 words including the structural elements. Body content (what gets read) is ~440 words. Slightly above the 300-word target you mentioned, but the OpenClaw pitfalls section and "start over" answers are the meat — cutting them shrinks the asset value of the email.

If you want a **shorter (~250 word)** variant that drops the two long sections and just points to the repo for them, ask and I'll write it.
