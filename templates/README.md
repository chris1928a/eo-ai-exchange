# Templates

Forkable templates for the foundation files of any Claude Code-based personal AI brain. Drop these into your project and customize.

---

## What's here

| File | Purpose | Lives at (after fork) |
|---|---|---|
| [`CLAUDE.md.template`](CLAUDE.md.template) | Project-level instructions Claude reads every conversation. ~50 lines, pointers only. | `<your-project>/CLAUDE.md` |
| [`memory-templates/MEMORY.md.template`](memory-templates/MEMORY.md.template) | Top-level memory index | `~/.claude/projects/<your-project>/memory/MEMORY.md` |
| [`memory-templates/user_about.md`](memory-templates/user_about.md) | Who you are (foundational user memory) | `~/.claude/projects/<your-project>/memory/user_about.md` |
| [`memory-templates/feedback_voice.md`](memory-templates/feedback_voice.md) | Voice rules: banned words, required style, tone | `~/.claude/projects/<your-project>/memory/feedback_voice.md` |
| [`memory-templates/feedback_channel_rules.md`](memory-templates/feedback_channel_rules.md) | Per-channel formatting (WhatsApp, email, LinkedIn, etc.) | `~/.claude/projects/<your-project>/memory/feedback_channel_rules.md` |
| [`memory-templates/hat_template.md`](memory-templates/hat_template.md) | Per-domain ("hat") context, used by `/weekly-review` | `~/.claude/projects/<your-project>/memory/hats/<domain>.md` |
| [`memory-templates/curator_rules.md`](memory-templates/curator_rules.md) | Rules for `/memory-curator`: stale, dupe, promote, audit | `~/.claude/projects/<your-project>/memory/_meta/curator_rules.md` |

---

## Setup order (60 minutes total)

1. **Fork CLAUDE.md** to your project root (5 min). This is what Claude reads every conversation.
2. **Fork user_about.md** (10 min). The single most leveraged 10 minutes you will spend on this entire setup.
3. **Fork feedback_voice.md** (15 min). Spend real time on banned words + required style, this prevents 80% of "AI-sounding" output.
4. **Fork feedback_channel_rules.md** (5 min). Defaults are sensible, edit per your habits.
5. **Fork MEMORY.md** (5 min). Index of everything else.
6. **Fork hat_template.md once per domain** you operate in (5 min × N hats).
7. **Fork curator_rules.md** (15 min). Spend time on what counts as "stale" for your context.

After this you can run `/morning-brief`, `/weekly-review`, `/memory-curator` and they have meaningful context to work with.

---

## Why these templates exist

The 8 [`/skills/`](../skills/) reference files in `memory/` (e.g. `feedback_voice.md`, `memory/people/{slug}.md`). Without those memory files, the skills produce thin output. These templates give you a clean starting point, fork them, fill in personal data, you're done.

---

## What goes in `memory/` vs `CLAUDE.md`

| If it's... | Put it in... |
|---|---|
| Pointer ("see X for Y") | CLAUDE.md |
| Voice / behavior rules | memory/feedback_*.md |
| Personal facts about you | memory/user_*.md |
| Current project context | memory/project_*.md or memory/projects/*/ |
| External system reference | memory/reference_*.md |
| Per-stakeholder context | memory/people/{slug}.md |

Rule of thumb: if `CLAUDE.md` exceeds ~50 lines, move content to `memory/` and link.

---

## Privacy

These templates ship empty / generic. Once you fork and fill in personal data, **never push the filled versions to a public repo**. Add `~/.claude/projects/*/memory/` to your `.gitignore` if you mirror your brain to a private GitHub repo.

---

*Last updated: 2026-05-14. PRs welcome, see [CONTRIBUTING.md](../CONTRIBUTING.md).*
