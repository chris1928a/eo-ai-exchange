#!/bin/bash
# /property-pricing cron setup — daily 06:00
# Tested on AWS Lightsail Ubuntu 24.04 LTS

PROJECT_DIR="$HOME/.claude/projects/my-brain"
SKILL_DIR="$HOME/.claude/skills/property-pricing"
RE_MEMORY="$PROJECT_DIR/memory/real-estate"

# ============================================================
# 1. Verify prerequisites
# ============================================================
command -v claude >/dev/null 2>&1 || { echo "ERROR: claude CLI not installed"; exit 1; }
[ -d "$PROJECT_DIR" ] || { echo "ERROR: $PROJECT_DIR does not exist"; exit 1; }
[ -f "$SKILL_DIR/SKILL.md" ] || { echo "ERROR: property-pricing skill not installed"; exit 1; }
[ -f "$RE_MEMORY/properties.md" ] || { echo "ERROR: properties.md missing in $RE_MEMORY"; exit 1; }
[ -f "$RE_MEMORY/pricing_rules.md" ] || { echo "ERROR: pricing_rules.md missing. Copy from templates/"; exit 1; }
[ -f "$RE_MEMORY/comp_set.md" ] || { echo "WARN: comp_set.md missing. Skill will run without comp data."; }

# ============================================================
# 2. Verify channel manager API connection
# ============================================================
echo "Testing channel manager API connection..."
# Replace with your actual API test command
# E.g. for Holidu: curl -H "Authorization: Bearer $HOLIDU_API_KEY" https://api.holidu.com/...
# This is a placeholder:
[ -n "$HOLIDU_API_KEY" ] || { echo "ERROR: HOLIDU_API_KEY env var not set"; exit 1; }

# ============================================================
# 3. Run a dry-run for the first 14 days
# ============================================================
echo "Running /property-pricing dry-run (no API push)..."
cd "$PROJECT_DIR" || exit 1
claude --skill property-pricing --dry-run --report telegram

read -p "Did the dry-run output look correct? Compare to what you'd manually decide. (y/N) " confirm
[ "$confirm" = "y" ] || { echo "Aborting cron install. Tune rules first."; exit 1; }

# ============================================================
# 4. Decide: dry-run cron OR live cron
# ============================================================
echo ""
echo "RECOMMENDATION: run --dry-run for the first 14 days. Switch to --apply only after"
echo "you confirm the skill matches your manual decisions ~80% of the time."
read -p "Install cron in --dry-run mode? (y for dry-run, N for live --apply) " mode
if [ "$mode" = "y" ]; then
  CRON_LINE="0 6 * * * cd $PROJECT_DIR && /usr/local/bin/claude --skill property-pricing --dry-run --report telegram"
  echo "[OK] Installing in DRY-RUN mode (no API push)"
else
  CRON_LINE="0 6 * * * cd $PROJECT_DIR && /usr/local/bin/claude --skill property-pricing --apply --report telegram"
  echo "[OK] Installing in LIVE mode (will push to channel manager API)"
  read -p "Are you SURE? Live mode pushes real prices. (yes/N) " sure
  [ "$sure" = "yes" ] || { echo "Aborted."; exit 1; }
fi

( crontab -l 2>/dev/null | grep -v "property-pricing" ; echo "$CRON_LINE" ) | crontab -

echo "[OK] Installed cron line:"
echo "     $CRON_LINE"

# ============================================================
# 5. Verify
# ============================================================
crontab -l | grep "property-pricing" >/dev/null && echo "[OK] crontab confirms entry"
systemctl is-active --quiet cron && echo "[OK] cron daemon running" || { echo "[FAIL] cron daemon not running"; exit 1; }

echo ""
echo "Done. Next firing: tomorrow 06:00 local time."
echo "All decisions logged to $RE_MEMORY/pricing_log.md"
echo "Telegram summary lands ~06:03 each morning."
echo ""
echo "Audit weekly: revenue per available night should be flat or up vs prior period."
echo "If revenue drops, your rules need tightening — do not blame the skill."
