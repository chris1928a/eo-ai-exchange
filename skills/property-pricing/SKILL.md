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

---

## Inputs

1. **Property list** — `memory/real-estate/properties.md` (each unit: name, channel manager ID, base price band, capacity, location)
2. **Booking velocity** — last 14 days of bookings via Holidu GraphQL (or your channel manager's API)
3. **Forward bookings** — next 60 days of confirmed reservations
4. **Comp set** — `memory/real-estate/comp_set.md` (named competitor units in same area, with their current prices)
5. **Pricing rules** — `memory/real-estate/pricing_rules.md` (your floor / ceiling / event-day overrides)
6. **Season + event calendar** — `memory/real-estate/calendar.md` (school holidays, conferences, local events)
7. **Past decisions log** — `memory/real-estate/pricing_log.md` (so we trend)

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

## Non-negotiable rules

- **Floor and ceiling are sacred.** Never push outside `pricing_rules.md` floor/ceiling. Period.
- **Confidence < HIGH = surface a flag, do not auto-apply.** Auto-apply only on HIGH confidence decisions.
- **Comp set freshness check.** If comp set data is older than 7 days, surface a flag instead of auto-applying.
- **Channel manager idempotency.** If a price was set manually in Holidu in the last 24h, skill respects it (does not override).
- **Logged forever.** Every decision goes to `pricing_log.md` with the input data, the recommendation, the reason, and the action taken (applied / flagged).
- **No AI-fluff** in flags. Plain language, plain reason.

---

## Setup (60-90 minutes — this is the most setup-heavy of the 8)

1. Drop this file at `~/.claude/skills/property-pricing/SKILL.md`
2. Create `~/.claude/projects/<your-project>/memory/real-estate/` with all input files
3. Get a channel-manager API key (Holidu / Airbnb / Booking.com / Smoobu)
4. Test the API connection in isolation before connecting the skill
5. Set conservative initial pricing rules (narrow floor/ceiling, ±5% max move per day)
6. Run in `--dry-run` mode for 14 days. Log every decision but do NOT push.
7. Compare dry-run decisions to what you would have done manually. Tighten rules.
8. Switch to live mode only after 14 days of dry-run alignment.

---

## Make it daily cron

```cron
0 6 * * * cd /path/to/project && claude --skill property-pricing --apply --report telegram
```

Fires daily 06:00. Pulls overnight booking velocity, decides, pushes, reports.

---

## Honest caveats

- **API quotas matter.** Holidu / Airbnb have rate limits. If you have 20+ units, batch carefully.
- **Comp set scraping is fragile.** Competitor pricing data sources break. Have a fallback when comp set is unavailable.
- **Big events break the model.** Chris experienced this with Legoland school-holiday spikes — added explicit `event_overrides.md` for known dates. Plan to do the same for your context.
- **Refunds and disputes from auto-pricing.** Edge case: a booking comes in at the new (higher) price, then comp set drops, guest sees the unit cheaper next door, requests refund. Have a service-level rule.
- **Compliance:** dynamic pricing is not regulated in most jurisdictions, but consumer-protection rules vary. Check yours.

---

## Why this is a domain example (not universal)

This skill is shaped for real estate / daily-priced goods. The pattern (pull velocity → decide → push to system of record → log + surface exceptions) reuses for any "daily decision automation":
- `/inventory-restock` — daily restock decisions for ecom SKUs
- `/ad-bid-adjuster` — daily ad bid adjustments
- `/pricing-saas` — usage-based SaaS pricing for enterprise contracts

Fork this skill, swap the data sources + the rules, keep the structure (dry-run → tighten → go-live).

---

*Source: demoed at [EO AI Productivity Exchange #1](../../events/01-2026-05-11-setup-trap/README.md) on 2026-05-11. Tracked saved time: 5h/week (was 60 min/day manual, now fully automated). The most concrete "AI as infrastructure replaces a job" example in Chris's setup.*
