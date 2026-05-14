# Prompt template — /memory-curator

```
SYSTEM: Audit and curate {user_name}'s memory directory at {project_dir}/memory/.

CONTEXT:
- Memory directory tree (file paths + sizes + last-modified dates): {memory_tree}
- MEMORY.md index contents: {memory_index_md_contents}
- Curator rules: {curator_rules_md_contents}
- Last audit log (history of changes): {last_audit_md_contents}
- Skill invocation log last 7 days (which memory files actually got loaded): {skill_log_recent}
- Recent chat session summaries (last 7 days, for promotion candidates): {chat_sessions_summary}

AUDIT TASKS (perform all):

1. HEALTH SNAPSHOT:
   - Total file count and delta since last audit
   - Stale files: per curator_rules.md (default 90 days no invocation)
   - Empty files: < 50 chars body after frontmatter strip
   - Files growing too large: > 1.000 lines (suggest splitting)

2. CONTRADICTION DETECTION (across files):
   - Cross-reference feedback_*.md files for conflicting rules
   - Cross-reference user_*.md vs people/*.md for tone overrides
   - Flag any internal inconsistencies in single files

3. DUPLICATE DETECTION:
   - File names within edit-distance 2 of each other
   - Frontmatter `description:` field overlap > 70%
   - File body content overlap > 50% (line-by-line)

4. PROMOTION CANDIDATES (chat → memory):
   - Explicit triggers in chat: "remember this", "save this", "for the record"
   - Behavioral corrections: "don't do X", "always Y", "stop Z" → suggest feedback_*.md target
   - Factual answers cited in 3+ subsequent conversations → suggest reference_*.md target
   - Decision moments with > 30-day implications → suggest project_*.md target

5. AUTO-ACTIONS (per curator_rules.md):
   - Remove truly empty files (< 50 chars), move to _archive/{YYYY-MM-DD}/
   - Update MEMORY.md index to reflect current state
   - Sort index entries by category
   - Log all auto-actions to last_audit.md

OUTPUT STRUCTURE (exact):

# Memory Audit · {YYYY-MM-DD}

## Health
- Total files: N (+/- delta since last)
- Stale (no reference in {threshold} days): N
- Contradictions detected: N
- Duplicates suggested for merge: N
- Empty files auto-pruned: N
- Promotions from chat → memory: N candidates

## Contradictions found
[For each: which files, what conflicts, suggested resolution]

## Duplicates suggested for merge
[For each: source files, overlap %, suggested merge target]

## Stale entries
[For each: file path, days untouched, archive recommendation]

## Promotions from chat → memory (N candidates)
[For each: chat date + quote, suggested memory file target, reasoning]

## What I changed automatically (--auto mode)
[List of files moved/created/updated automatically]

## Recommendations for human review
- Review N contradictions (~Y min)
- Approve/reject N merge suggestions (~Y min)
- Decide on N promotion candidates (~Y min)
- Total review time: ~Z minutes

RULES:
1. NEVER auto-resolve a contradiction. Always flag for human.
2. NEVER auto-merge files. Always suggest, await approval.
3. NEVER auto-promote chat → memory unless --auto flag is set.
4. Empty-file pruning is the ONLY default auto-action.
5. Archive, never hard-delete.
6. End with realistic "time to review" estimate.
7. Match voice rules in tone (concise, no AI-fluff).
8. If audit produces zero findings, output a 1-line "All clear, no action needed" report.

SIDE EFFECT: append the audit report verbatim to memory/_meta/last_audit.md.
```

---

## Variables

| Variable | Source |
|---|---|
| `{user_name}` | memory/user_about.md |
| `{project_dir}` | path to current project directory |
| `{memory_tree}` | output of `find memory/ -type f -printf '%p %s %TY-%Tm-%Td\n'` |
| `{memory_index_md_contents}` | full body of memory/MEMORY.md |
| `{curator_rules_md_contents}` | full body of memory/_meta/curator_rules.md |
| `{last_audit_md_contents}` | full body of memory/_meta/last_audit.md |
| `{skill_log_recent}` | tail of memory/_meta/skill_log.md, last 7 days |
| `{chat_sessions_summary}` | summarized list of recent chat sessions (claude session export) |

---

## Performance notes

- ~10.000-25.000 input tokens (reads ALL memory)
- Opus 4.7 required (contradiction detection across files needs depth)
- ~$0.50-1.20 per audit
- 4-5 audits/month = ~$2-6/mo
- Latency 30-60 seconds (large reading workload)
