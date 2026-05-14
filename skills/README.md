# Skills

Forkable Claude Code Skills, contributed by the EO AI Productivity Exchange community.

Each skill follows the [Claude Code Skills spec](https://docs.claude.com/skills) with `SKILL.md` (description, when-to-trigger, instructions). Optional `examples/` and `scripts/` folders.

---

## The 8 skills demoed at Event #1 (2026-05-11)

Same structure as Chris demoed live. Five universal, three domain examples.

### Universal (fork as-is, edit personal data)

| Skill | What it does | Tracked saved time | File |
|---|---|---|---|
| `/morning-brief` | Daily 7am brief: inbox top 3, calendar, open threads | 2.25h/wk | [`morning-brief/SKILL.md`](morning-brief/SKILL.md) |
| `/diarize-person` | 1-page stakeholder dossier with full history | (part of 5.7h/wk meeting prep) | [`diarize-person/SKILL.md`](diarize-person/SKILL.md) |
| `/draft-by-channel` | Voice-locked drafts per recipient + channel | 2.7h/wk | [`draft-by-channel/SKILL.md`](draft-by-channel/SKILL.md) |
| `/weekly-review` | Friday 7-day review across all your domains | 1.3h/wk (90→10 min) | [`weekly-review/SKILL.md`](weekly-review/SKILL.md) |
| `/memory-curator` | Weekly memory hygiene cron | maintenance | [`memory-curator/SKILL.md`](memory-curator/SKILL.md) |

### Domain examples (show the pattern, adapt to your vertical)

| Skill | For who | Pattern to copy | File |
|---|---|---|---|
| `/audit-process` | Advisors / COOs / ops consultants | Diagnostic + Impact-Effort matrix + top-3 | [`audit-process/SKILL.md`](audit-process/SKILL.md) |
| `/sales-script-rewriter` | Sales founders / SDR managers | Transcript-in + 6-dim score + rewritten section | [`sales-script-rewriter/SKILL.md`](sales-script-rewriter/SKILL.md) |
| `/property-pricing` | Real estate / daily-priced goods | API-in + decision-out + daily cron | [`property-pricing/SKILL.md`](property-pricing/SKILL.md) |

---

## How to use these (3 ways)

### A. Read first
Each `SKILL.md` is a complete specification: purpose, inputs, outputs, non-negotiable rules, setup. Read the one closest to your work first.

### B. Fork into your local Claude Code
```bash
# After cloning the repo
cp -r skills/morning-brief ~/.claude/skills/
# Edit the SKILL.md to match your context
```

### C. Adapt the pattern to your domain
The 3 domain examples are templates. Take `audit-process`, swap "process" for "pipeline" / "content" / "stack", and you have a new diagnostic skill.

---

## What you need before forking

- Claude Code installed: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview)
- A `~/.claude/projects/<your-project>/` directory with `memory/` subfolder (see [`templates/`](../templates/))
- The MCP servers each skill needs (Gmail, Calendar, etc.) — see [`solutions/integration-mcp/mcp-cookbook.md`](../solutions/integration-mcp/mcp-cookbook.md)

---

## Important context

These 8 SKILL.md files are **starter templates** based on what Chris demoed live at Event #1. The exact instructions match the demo descriptions. The implementation details (how Claude actually wires them) are filled in following the `ev-assistant` SKILL.md structure shown on slide 38 of [`chris-demo.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html).

Chris's actual production versions of these skills contain personal data (real client names, real pricing rules, real voice patterns) and are not pushed to this public repo. The templates here capture the *pattern* that produces the *outcomes* shown in the demo.

---

## How to contribute a skill

PRs welcome. See [CONTRIBUTING.md](../CONTRIBUTING.md). Each contribution should follow the same structure:

```
skills/<your-skill-name>/
├── SKILL.md            ← the full spec (purpose / inputs / outputs / rules / setup)
├── examples/           ← optional: sample inputs + outputs
└── scripts/            ← optional: helper scripts
```

The spec in `SKILL.md` matters more than the implementation — the goal is patterns others can fork, not bespoke code that only works for you.

---

*Last updated: 2026-05-14. 8 starter skills live. Community-contributed skills follow.*
