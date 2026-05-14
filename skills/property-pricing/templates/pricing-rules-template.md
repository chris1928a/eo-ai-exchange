# Pricing rules template

> Customize and save to `memory/real-estate/pricing_rules.md`. The skill enforces these rules as hard constraints.

---

## Per-unit floor and ceiling

| Unit | Floor (EUR) | Ceiling (EUR) | Notes |
|---|---|---|---|
| Unit-1 | 100 | 220 | Studio, low-season floor |
| Unit-2 | 100 | 220 | Same as Unit-1, identical |
| Unit-3 | 120 | 240 | 1-bed, premium |
| Unit-4 | 100 | 220 | Studio |
| Unit-5 | 100 | 220 | Studio |
| Unit-6 | 120 | 240 | 1-bed, premium |

Floor = lowest price ever, even on a dead Tuesday. Below this, you're losing margin or attracting bad guests.
Ceiling = highest ever, even on Pfingsten Saturday. Above this, you stop converting.

---

## Max-move-per-day rule

Hard limit on how much the price can change in 24 hours, to avoid algorithmic whiplash:

- **Default:** ±10% per day
- **Conservative (first 30 days of automation):** ±5% per day
- **Aggressive (mature setup, well-tested):** ±20% per day

Set the max-move per unit if some units are more volatile than others.

---

## Event overrides

For known events that the algorithm cannot infer from velocity alone:

| Date(s) | Event | Override | Apply to units |
|---|---|---|---|
| 2026-05-16 to 2026-05-19 | Pfingsten long weekend | Floor +30%, ceiling +20% | All |
| 2026-09-19 to 2026-10-05 | Oktoberfest | Floor +50%, ceiling +30% | All in München region |
| 2026-12-22 to 2026-12-30 | Weihnachten | Floor +20% | All |
| 2026-12-31 to 2027-01-01 | Silvester | Floor +60% | All |
| Custom: school holidays {state} | Per-state holidays | Floor +15% | All |

Update yearly. Old overrides auto-expire after the date passes.

---

## Confidence thresholds

When the skill scores confidence, what to do:

| Confidence | Auto-apply? | Notify? |
|---|---|---|
| HIGH | Yes, within band | No (just log) |
| MEDIUM, ≤±5% from current | Yes | No |
| MEDIUM, >±5% from current | No, flag | Telegram alert |
| LOW | Never | Telegram alert + email |

---

## Comp set freshness

Comp set data older than this = pretend it doesn't exist:

- **Default:** 7 days
- **Aggressive:** 3 days (refresh comp set scrape more often)
- **Conservative:** 14 days (less reliance on comp set)

If comp set is stale AND velocity signal is weak → flag the unit, don't auto-price.

---

## Manual override respect

If a price was set manually in the last N hours, the skill does NOT override:

- **Default:** 24 hours
- **Aggressive:** 12 hours
- **Conservative:** 72 hours (give yourself more time to think)

---

## Special-case rules

### Repeat guest discount
If a guest is returning (matched by email in last 12 months), apply a 5% discount on top of the auto-price.

### Length-of-stay discount
If booking is 7+ nights, apply -5%. If 14+ nights, apply -10%.

### Cancellation cluster response
If 3+ cancellations land for the same date across multiple units, do NOT auto-raise prices that date, flag instead. Cancellations may signal something you don't know about (event canceled, weather warning, etc).

### Last-minute discount
For nights within 48h of arrival with <50% occupancy across the cluster, apply a -10% last-minute discount (encourage fill).

---

## Calibration: how to set these rules

1. Look at last 12 months of your manual pricing decisions
2. Plot price vs occupancy per unit
3. Find the natural floor (price below which you almost never sold)
4. Find the natural ceiling (price above which conversion dropped >50%)
5. Set floor = 5% above the natural floor
6. Set ceiling = 5% below the natural ceiling
7. Run `--dry-run` for 14 days, compare auto-decisions to your manual choices
8. Adjust rules where the skill consistently disagrees with your judgment
9. Once 80% alignment, switch to `--apply`
10. Re-calibrate quarterly as your market shifts
