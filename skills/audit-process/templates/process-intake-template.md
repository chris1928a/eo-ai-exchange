# Process intake template

> Use during the 60-90 minute intake interview with your client. Fill in one block per process. Fork this file into `memory/projects/{engagement}/processes.md`.

---

## Intake checklist for each process

Before you can score, you need ALL of these for each process:

- [ ] **Process name** — what people call it internally
- [ ] **Owner** — who is currently responsible (name + role)
- [ ] **Frequency** — how often does it run (daily / weekly / per-deal / etc.)
- [ ] **Current time cost** — minutes/hours per occurrence × frequency = total time/week
- [ ] **Current money cost** — vendor fees, tool costs, opportunity cost
- [ ] **Current quality cost** — error rate, customer complaints, rework cycles
- [ ] **What's broken** — the specific pain in concrete language (not "it's slow")
- [ ] **What people have tried** — past attempts at fixing, what worked / didn't
- [ ] **Constraints** — anything that limits possible fixes (compliance, vendor lock-in, internal politics)
- [ ] **Who has authority to change it** — sometimes ≠ the owner

If any field is empty after the intake interview, skip the process — the audit can't score it without complete data.

---

## Template — copy this block per process

```markdown
## Process: {name}

- **Owner:** {name + role}
- **Frequency:** {daily / weekly / per-deal / etc.}
- **Current time cost:** {N min × frequency = N h/wk}
- **Current money cost:** {currency / "minimal" / "unknown"}
- **Current quality cost:** {error rate / complaints / rework cycles}
- **What's broken:**
  {1-3 sentences in concrete language. Avoid "slow" or "inefficient". Use specifics:
   "4-day average delay between submission and approval" instead of "slow".}
- **What people have tried:**
  - {Attempt 1, year, outcome}
  - {Attempt 2, year, outcome}
  - (or "no prior attempts" if true)
- **Constraints:**
  {Compliance, vendor lock-in, political reality, capital available, etc.}
- **Authority to change:**
  {Name + role of decision-maker, if different from owner}
- **Notes from intake conversation:**
  {Free-form. The off-the-record stuff that shapes how a fix would land.
   Often the most useful section.}
```

---

## Common intake questions to ask

For each process, ask the owner:

1. "Walk me through this end-to-end. Don't skip steps."
2. "Where does it slow down or break, and how often?"
3. "What's the cost when it goes wrong? (Money? Time? Customer trust?)"
4. "What did you try to fix this in the last 12 months? Why did it stick or not?"
5. "If you could change one thing about this with no constraints, what would it be?"
6. "What's stopping you from doing exactly that?"

The 6th question is where the real audit value lives — the constraint, not the wish.

---

## Anti-patterns to avoid in intake

- **Don't accept "it's slow" as a problem statement.** Push for the number.
- **Don't accept "we don't have data" as an excuse.** Walk through one example end-to-end and reverse-engineer the cost.
- **Don't audit a process the client doesn't want to fix.** Political reality kills good audits.
- **Don't audit < 5 processes.** Too narrow, no comparative weight in the matrix.
- **Don't audit > 30 processes.** Too broad, audit becomes shallow.
- **Sweet spot: 12-20 processes per engagement.**

---

## After intake

1. Save the filled file to `memory/projects/{engagement}/processes.md`
2. Save org context to `memory/projects/{engagement}/org.md`
3. Run `/audit-process`
4. Review output, edit, deliver to client
