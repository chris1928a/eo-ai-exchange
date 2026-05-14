---
name: property-pricing
type: domain-example
audience: For real-estate operators, daily-priced goods (hotels, rentals, flights, dynamic SKUs)
load_when: property pricing, daily pricing, revenue management, holidu, airbnb pricing, set price
---

# /property-pricing

> **Domain-example skill from Event #1, Demo 1 (Chris). For real estate operators / daily-priced goods.**
> Daily revenue management cron. Pulls velocity, pushes optimal price, logs to Notion. Runs at 06:00 daily. Tracked saved time: ~5h/week (was 60 min/day manual, now 0 min). One of the most concrete "AI as infrastructure" examples in Chris's setup.

---

## Purpose

Daily-priced assets (short-term rentals, hotel rooms, flight seats, dynamic SKUs) require daily revenue-management decisions: what should each unit cost tomorrow, given booking velocity, lead time, season, competitor moves, and weather? This skill runs that decision automatically every morning at 06:00, posts the decisions to your Notion log + your channel manager (Holidu / Airbnb / Booking.com), and surfaces flags for your manual review.

The pattern is: **pull velocity + comp set + rules → decide per unit → push to channel manager → log + flag exceptions for human review**. Reusable for any "daily decision automation" use case.

---

## Inputs

1. **Property list** — `memory/real-estate/properties.md` (each unit: name, channel manager ID, base price band, capacity, location)
2. **Booking velocity** — last 14 days of bookings via Holidu GraphQL (or your channel manager's API)
3. **Forward bookings** — next 60 days of confirmed reservations
4. **Comp set** — `memory/real-estate/comp_set.md` (named competitor units in same area, with their current prices)
5. **Pricing rules** — `memory/real-estate/pricing_rules.md` (your floor / ceiling / event-day overrides)
6. **Season + event calendar** — `memory/real-estate/calendar.md` (school holidays, conferences, local events)
7. **Past decisions log** — `memory/real-estate/pricing_log.md` (so we trend)
8. **Voice rules** — for the Telegram summary tone

---

## Outputs

### A. Per-unit price decision (each morning, per property)

```markdown
# Pricing Decision · {Property} · {YYYY-MM-DD}

## Tomorrow ({YYYY-MM-DD+1})
- Current price: 145 EUR
- Recommended: 165 EUR (+14%)
- Reason: 5 bookings in last 24h (vs 14d avg of 1.2), 60% occupancy at lead time 7d, comp set median 158 EUR
- Confidence: HIGH

## Next 7 days
| Date | Current | Recommended | Δ | Reason |
|---|---|---|---|---|
| 2026-05-15 | 145 | 165 | +14% | Velocity surge |
| 2026-05-16 | 145 | 175 | +21% | Long weekend + low supply |
| ...

## Flags for your review (do NOT auto-apply)
- Sat 2026-05-23: comp set jumped 30% overnight, possible event you don't know about
- Mon 2026-06-02: 3 cancellations on same date, price floor hit, demand signal weak

## Auto-applied changes (logged)
- 5 prices pushed to Holidu API
- 3 prices unchanged (within recommendation tolerance)
```

### B. Daily summary to Telegram (one line per property)

```
06:03 · Pricing run complete · 6 units
Unit-1: +12% next 7d (velocity surge)
Unit-2: -5% (cancellation cluster)
Unit-3: hold (within tolerance)
...
2 flags need your review · pricing_log.md updated
```

---

## Worked example — daily pricing run on a 6-unit short-term rental cluster

**Context:** Friday 2026-05-15, 06:00 cron. 6 studio units, all in same town. Last week's velocity was strong on weekends.

**Output (full per-unit detail for unit 1, summary for the rest):**

```markdown
# Pricing Decision · Unit-1 · 2026-05-15

## Tomorrow (2026-05-16)
- Current price: 145 EUR
- Recommended: 175 EUR (+21%)
- Reason: 3 bookings in last 24h (vs 14d avg of 0.8) for the weekend. 
  Comp set median 168 EUR. Long weekend approaching (Pfingsten).
  Floor 100 EUR, ceiling 220 EUR — recommendation within band.
- Confidence: HIGH

## Next 7 days
| Date | Current | Recommended | Δ | Reason |
|---|---|---|---|---|
| 2026-05-16 (Sat) | 145 | 175 | +21% | Weekend + Pfingsten approach |
| 2026-05-17 (Sun) | 145 | 180 | +24% | Pfingsten weekend |
| 2026-05-18 (Mon) | 145 | 195 | +34% | Pfingstmontag holiday |
| 2026-05-19 (Tue) | 145 | 145 | 0% | Hold — back to normal |
| 2026-05-20 (Wed) | 145 | 145 | 0% | Hold |
| 2026-05-21 (Thu) | 145 | 150 | +3% | Slight lead-time adjustment |
| 2026-05-22 (Fri) | 145 | 165 | +14% | Weekend approach |

## Flags for your review (do NOT auto-apply)
- Sat 2026-05-23: comp set jumped 30% overnight (one comp unit went from 150 to 195)
  → Unknown event in town? Investigate before adjusting.
- Mon 2026-06-02: 3 forward cancellations on same date for Unit-1, Unit-3, Unit-5
  → Demand signal weak. Floor already hit at 100 EUR. Marketing push?

## Auto-applied changes (logged)
- 5 prices pushed to Holidu API (Sat-Tue)
- 2 prices unchanged (within tolerance)
- 0 prices outside floor/ceiling band

## Daily Telegram summary
06:03 · Pricing run complete · 6 units
Unit-1: +21% Sat, +34% Mon (Pfingsten boost)
Unit-2: +18% Sat (similar pattern)
Unit-3: hold (already at peak from manual override Mon)
Unit-4: -5% Tue (cancellation impact)
Unit-5: +20% weekend
Unit-6: hold (within tolerance)
2 flags need your review · pricing_log.md updated · cron complete 06:03
```

That's the shape. 6 units priced for 7 days each = 42 decisions, 2 flagged for human, 35 auto-pushed to Holidu, 5 left alone. Total: ~3 minutes of cron + Claude time. Replaces 60 minutes of manual daily revenue management.

---

## Non-negotiable rules

- **Floor and ceiling are sacred.** Never push outside `pricing_rules.md` floor/ceiling. Period.
- **Confidence < HIGH = surface a flag, do not auto-apply.** Auto-apply only on HIGH confidence decisions.
- **Comp set freshness check.** If comp set data is older than 7 days, surface a flag instead of auto-applying.
- **Channel manager idempotency.** If a price was set manually in Holidu in the last 24h, skill respects it (does not override).
- **Logged forever.** Every decision goes to `pricing_log.md` with the input data, the recommendation, the reason, and the action taken (applied / flagged).
- **No AI-fluff** in flags. Plain language, plain reason.

---

## The actual prompt under the hood

```
SYSTEM: Generate daily pricing decisions for {user_name}'s rental units.

CONTEXT:
- Property list: {properties_md_contents}
- Pricing rules (floors, ceilings, event overrides): {pricing_rules_md_contents}
- Comp set (competitor units + recent prices): {comp_set_md_contents}
- Season + event calendar: {calendar_md_contents}
- Past 14 days of pricing decisions: {pricing_log_recent}
- Voice rules: {feedback_voice_md_contents}

LIVE DATA (from channel manager API, e.g. Holidu GraphQL):
- Booking velocity per unit, last 14 days: {velocity_data}
- Forward bookings per unit, next 60 days: {forward_bookings_data}
- Manual overrides per unit, last 24 hours: {recent_manual_overrides}

DECISION LOGIC (per unit, per night for next 7 nights):
1. Calculate current occupancy at relevant lead time
2. Compare to 14-day moving average velocity
3. Check comp set median for the date
4. Apply event calendar adjustments (school holidays, conferences, local events)
5. Apply pricing rules (floor, ceiling, event overrides)
6. Score confidence: HIGH (clear signal), MEDIUM (mixed), LOW (unusual)
7. If LOW: flag for human review, do NOT auto-apply
8. If MEDIUM: auto-apply only if within ±5% of current; else flag
9. If HIGH: auto-apply within floor/ceiling band

OUTPUT (per unit):

# Pricing Decision · {Unit Name} · {YYYY-MM-DD}

## Tomorrow ({date+1})
- Current price: ...
- Recommended: ... (Δ%)
- Reason: [specific drivers cited]
- Confidence: HIGH/MEDIUM/LOW

## Next 7 days
[Table: Date | Current | Recommended | Δ | Reason]

## Flags for your review (do NOT auto-apply)
- ...

## Auto-applied changes (logged)
- N prices pushed to Holidu API
- M prices unchanged (within tolerance)

## Daily Telegram summary (one line per unit, plus flag count)
[1-line per unit summary]
[N flags need your review]

RULES:
1. NEVER push outside floor/ceiling. EVER.
2. NEVER auto-apply LOW confidence — flag instead.
3. NEVER override a manual price set in last 24h.
4. Reason MUST cite specific signals (velocity numbers, comp set numbers, event names).
5. Apply voice rules.
6. If comp set data is > 7 days stale, flag the unit instead of auto-pricing.
7. If channel manager API returns an error, log it and SKIP the unit, do not invent a price.

SIDE EFFECTS:
- Push approved prices to channel manager API
- Append every decision to memory/real-estate/pricing_log.md
- Send Telegram summary
- Log invocation to memory/_meta/skill_log.md
```

Full template at [`prompts/pricing-prompt.md`](prompts/pricing-prompt.md). Pricing rules template at [`templates/pricing-rules-template.md`](templates/pricing-rules-template.md).

---

## Setup (60-90 minutes — this is the most setup-heavy of the 8)

1. Drop SKILL.md + prompts + templates at `~/.claude/skills/property-pricing/`
2. Create `~/.claude/projects/<your-project>/memory/real-estate/` with all input files
3. Get a channel-manager API key (Holidu / Airbnb / Booking.com / Smoobu)
4. Test the API connection in isolation before connecting the skill
5. Set conservative initial pricing rules (narrow floor/ceiling, ±5% max move per day)
6. Run in `--dry-run` mode for 14 days. Log every decision but do NOT push.
7. Compare dry-run decisions to what you would have done manually. Tighten rules.
8. Switch to live mode only after 14 days of dry-run alignment.

Full cron setup in [`scripts/cron-daily.sh`](scripts/cron-daily.sh).

---

## Make it daily cron

```cron
0 6 * * * cd /path/to/project && claude --skill property-pricing --apply --report telegram
```

Fires daily 06:00. Pulls overnight booking velocity, decides, pushes, reports.

For first 14 days, use `--dry-run` instead of `--apply`:

```cron
0 6 * * * cd /path/to/project && claude --skill property-pricing --dry-run --report telegram
```

---

## Cost + latency

| Metric | Value |
|---|---|
| Tokens per invocation | ~5.000-15.000 (depends on unit count) |
| Model | Claude Opus 4.7 (the multi-signal decision-making benefits from depth) |
| Cost per invocation | **~$0.50-1.50** |
| Latency | 20-40 seconds (mostly waiting on channel manager API) |
| Monthly cost (daily cron) | **~$15-45** |

Cheap relative to the value: replaces a part-time revenue manager (~30-60k EUR/yr in DACH).

---

## Variations + extensions

| Variation | What changes | When to use |
|---|---|---|
| `/inventory-restock` | Daily restock decisions for ecom SKUs based on velocity | E-commerce ops |
| `/ad-bid-adjuster` | Daily ad bid adjustments based on conversion velocity | Performance marketing |
| `/pricing-saas` | Usage-based SaaS pricing for enterprise contracts | Pricing strategy |
| `/property-cleaning-schedule` | Daily cleaning roster based on bookings | Hospitality ops |
| `/property-maintenance-trigger` | Trigger maintenance work when occupancy gaps allow | Property management |

Same pattern (pull velocity → decide → push to system of record → log + surface exceptions), different domain.

---

## Common modifications

**1. Add weather data.** For outdoor-experience properties, pull weather forecast and adjust pricing accordingly.

**2. Multi-channel arbitrage.** If you list on Airbnb + Booking.com + direct, set channel-specific pricing rules. Direct gets a small discount to incentivize.

**3. Length-of-stay discounts.** Add a rule: if booking is for 7+ nights, auto-apply a 5% discount during low-velocity weeks.

**4. Refund / dispute prevention.** If price changed significantly between bookings, flag a customer-service prep step.

**5. Per-unit confidence weighting.** Some units are easier to price (well-known, lots of data). Others are new. Confidence threshold per unit, not global.

---

## Migration playbook (manual → automated)

| Day | What you do |
|---|---|
| 1-3 | Set up channel manager API connection. Test pulls in isolation. |
| 4-7 | Run skill in `--dry-run`. Compare decisions to your manual choices. Track gaps. |
| 8-14 | Tighten rules until dry-run matches your manual decisions ~80%. |
| 15-21 | Switch to `--apply` but with NARROW pricing band (±5% max move). |
| 22-30 | Widen the band gradually as you trust the skill. |
| 30+ | Audit weekly: revenue per available night vs prior period. Should be flat or up. |

If revenue drops after switching to auto, your rules are wrong. Don't blame the skill — fix the rules.

---

## What this won't do (failure modes)

- **API quotas matter.** Holidu / Airbnb have rate limits. If you have 20+ units, batch carefully.
- **Comp set scraping is fragile.** Competitor pricing data sources break. Have a fallback when comp set is unavailable.
- **Big events break the model.** Add explicit `event_overrides.md` for known dates (Oktoberfest, Christmas markets, etc.).
- **Refunds and disputes from auto-pricing.** Edge case: a booking comes in at the new (higher) price, then comp set drops, guest sees the unit cheaper next door, requests refund. Have a service-level rule.
- **Compliance:** dynamic pricing is not regulated in most jurisdictions, but consumer-protection rules vary. Check yours.
- **Will not understand "you can't raise prices on returning guests."** Add a rule for repeat-guest detection if relevant.

---

## When to delete this skill

If you have <3 units OR your prices barely move (long-term rentals), **delete it** — overkill. Reasons it might not work:
- Single property, manual is fine
- Long-term lease model, no daily pricing
- Channel manager API doesn't support automated price updates (rare but exists)
- You don't trust your own pricing rules — fix that first, then automate

---

## Why this is a domain example (not universal)

This skill is shaped for real estate / daily-priced goods. The pattern (pull velocity → decide → push to system of record → log + surface exceptions) reuses for any "daily decision automation":
- `/inventory-restock` — daily restock decisions for ecom SKUs
- `/ad-bid-adjuster` — daily ad bid adjustments
- `/pricing-saas` — usage-based SaaS pricing for enterprise contracts

Fork this skill, swap the data sources + the rules, keep the structure (dry-run → tighten → go-live).

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Tracked saved time: 5h/week (was 60 min/day manual, now fully automated). The most concrete "AI as infrastructure replaces a job" example in Chris's setup.*
