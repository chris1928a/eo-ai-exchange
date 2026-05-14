# Skills

Forkable Claude Code Skills, contributed by the EO AI Productivity Exchange community.

Each skill is a folder with:
- **`SKILL.md`**, full spec (purpose / inputs / outputs / worked example / non-negotiable rules / the actual prompt under the hood / setup / cost+latency / variations / common modifications / migration playbook / what won't do / when to delete / why it's universal)
- **`prompts/`**, the LLM prompt template the skill actually sends (forkable separately)
- **`examples/`**, concrete sample outputs you can use as calibration target
- **`scripts/`**, cron setup snippets (where applicable)
- **`templates/`**, supporting input templates (rubrics, intake forms, where applicable)

Each `SKILL.md` is ~280-380 lines. Each skill folder ships 3-5 supporting files for plug-and-play.

---

## The 8 skills demoed at Event #1 (2026-05-11)

Same structure as Chris demoed live. Five universal, three domain examples.

### Universal (5), fork as-is, edit personal data

| Skill | What it does | Tracked saved time | Files |
|---|---|---|---|
| [`/morning-brief`](morning-brief/) | Daily 7am brief: inbox top 3, calendar, open threads | 2.25h/wk | SKILL + 1 prompt + 2 examples + 1 cron script |
| [`/diarize-person`](diarize-person/) | 1-page stakeholder dossier with full history | (5.7h/wk meeting prep) | SKILL + 1 prompt + 1 example |
| [`/draft-by-channel`](draft-by-channel/) | Voice-locked drafts per recipient + channel | 2.7h/wk | SKILL + 1 prompt + 1 example |
| [`/weekly-review`](weekly-review/) | Friday 7-day review across all "hats" | 1.3h/wk (90→10 min) | SKILL + 1 prompt + 1 example + 1 cron script |
| [`/memory-curator`](memory-curator/) | Weekly memory hygiene cron | maintenance | SKILL + 1 prompt + 1 example + 1 cron script |

### Domain examples (3), show the pattern, adapt to your vertical

| Skill | For who | Pattern to copy | Files |
|---|---|---|---|
| [`/audit-process`](audit-process/) | Advisors / COOs / ops consultants | Diagnostic + Impact-Effort matrix + top-3 | SKILL + 1 prompt + 1 intake template |
| [`/sales-script-rewriter`](sales-script-rewriter/) | Sales founders / SDR managers | Transcript-in + 6-dim score + rewritten section | SKILL + 1 prompt + 1 rubric template |
| [`/property-pricing`](property-pricing/) | Real estate / daily-priced goods | API-in + decision-out + daily cron | SKILL + 1 prompt + 1 rules template + 1 cron script |

---

## Skill folder structure (consistent across all 8)

```
skills/{skill-name}/
├── SKILL.md                    ← full spec (forkable)
├── prompts/
│   └── {name}-prompt.md        ← the LLM prompt the skill sends
├── examples/
│   └── sample-{scenario}.md    ← concrete output, calibration target
├── scripts/                    ← (universal cron skills only)
│   └── cron-{day}.sh           ← cron install script with safety checks
└── templates/                  ← (domain examples only)
    └── {input}-template.md     ← supporting input templates
```

---

## How to use these (3 ways)

### A. Read first
Each `SKILL.md` is a complete specification. Read the one closest to your work first. ~10 minutes per skill.

### B. Fork into your local Claude Code
```bash
# After cloning the repo
cp -r skills/morning-brief ~/.claude/skills/
# Edit the SKILL.md and prompts/ files to match your context
```

### C. Adapt the pattern to your domain
The 3 domain examples are templates. Take `audit-process`, swap "process" for "pipeline" / "content" / "stack", and you have a new diagnostic skill.

---

## What you need before forking

- Claude Code installed: [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview)
- A `~/.claude/projects/<your-project>/` directory with `memory/` subfolder (see [`templates/`](../templates/))
- The MCP servers each skill needs (Gmail, Calendar, etc.), see [`solutions/integration-mcp/mcp-cookbook.md`](../solutions/integration-mcp/mcp-cookbook.md)

---

## Cost summary (steady-state, monthly, all 8 skills running)

| Skill | Frequency | Monthly cost |
|---|---|---|
| `/morning-brief` | Daily cron | ~$0.30-0.90 |
| `/diarize-person` | ~80/mo | ~$4-12 |
| `/draft-by-channel` | ~240/mo | ~$1.50-4 |
| `/weekly-review` | 4/mo cron | ~$1.60-3.20 |
| `/memory-curator` | 4-5/mo cron | ~$2-6 |
| `/audit-process` | per engagement | ~$5-15 |
| `/sales-script-rewriter` | 200 calls/mo | ~$160-500 |
| `/property-pricing` | Daily cron | ~$15-45 |
| **Total (universal only)** | | **~$10-30/mo** |
| **Total (with domain examples scaled)** | | **~$200-700/mo depending on scale** |

Cost is meaningful for the high-volume domain skills (sales coaching). Universal skills are cheap.

---

## Important context

These 8 SKILL.md files are **starter templates** based on what Chris demoed live at Event #1. The exact instructions match the demo descriptions. The implementation details (how Claude actually wires them) are filled in following the `ev-assistant` SKILL.md structure shown on slide 38 of [`chris-demo.html`](https://chris1928a.github.io/eo-ai-exchange/events/01-2026-05-11-setup-trap/chris-demo.html).

Chris's actual production versions of these skills contain personal data (real client names, real pricing rules, real voice patterns) and are not pushed to this public repo. The templates here capture the *pattern* that produces the *outcomes* shown in the demo.

---

## How to contribute a skill

PRs welcome. See [CONTRIBUTING.md](../CONTRIBUTING.md). Each contribution should follow the same structure:

```
skills/<your-skill-name>/
├── SKILL.md            ← full spec following the 11-section pattern of the 8 above
├── prompts/            ← optional: the LLM prompt template
├── examples/           ← optional: sample inputs + outputs
├── scripts/            ← optional: helper scripts (cron, setup)
└── templates/          ← optional: supporting input templates
```

The `SKILL.md` 11-section pattern:
1. Frontmatter (name, type, load_when)
2. Pitch quote
3. Purpose
4. Inputs
5. Outputs
6. Worked example
7. Non-negotiable rules
8. The actual prompt under the hood
9. Setup
10. Cost + latency
11. Variations / Common modifications / Migration playbook / What won't do / When to delete / Why it matters

---

*Last updated: 2026-05-14. 8 starter skills live, each with full SKILL.md + supporting files. Community-contributed skills follow.*
