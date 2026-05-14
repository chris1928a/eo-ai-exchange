#!/bin/bash
# /weekly-review cron setup — Friday 17:00
# Tested on AWS Lightsail Ubuntu 24.04 LTS

PROJECT_DIR="$HOME/.claude/projects/my-brain"
SKILL_DIR="$HOME/.claude/skills/weekly-review"
ARCHIVE_DIR="$PROJECT_DIR/weekly-reviews"

# ============================================================
# 1. Verify prerequisites
# ============================================================
command -v claude >/dev/null 2>&1 || { echo "ERROR: claude CLI not installed"; exit 1; }
[ -d "$PROJECT_DIR" ] || { echo "ERROR: $PROJECT_DIR does not exist"; exit 1; }
[ -f "$SKILL_DIR/SKILL.md" ] || { echo "ERROR: weekly-review skill not installed"; exit 1; }
[ -d "$PROJECT_DIR/memory/hats" ] || { echo "ERROR: hats/ folder not initialized"; exit 1; }

mkdir -p "$ARCHIVE_DIR"

# ============================================================
# 2. Test the skill manually first (DRY RUN, do not archive)
# ============================================================
echo "Running /weekly-review manually as a dry run..."
cd "$PROJECT_DIR" || exit 1
claude --skill weekly-review --output stdout --dry-run

read -p "Did the dry-run output look correct? (y/N) " confirm
[ "$confirm" = "y" ] || { echo "Aborting cron install. Fix the skill output first."; exit 1; }

# ============================================================
# 3. Install the cron job
# ============================================================
CRON_LINE="0 17 * * FRI cd $PROJECT_DIR && /usr/local/bin/claude --skill weekly-review --output telegram --archive $ARCHIVE_DIR"

( crontab -l 2>/dev/null | grep -v "weekly-review" ; echo "$CRON_LINE" ) | crontab -

echo "[OK] Installed cron line:"
echo "     $CRON_LINE"

# ============================================================
# 4. Verify
# ============================================================
crontab -l | grep "weekly-review" >/dev/null && echo "[OK] crontab confirms entry"
systemctl is-active --quiet cron && echo "[OK] cron daemon running" || { echo "[FAIL] cron daemon not running"; exit 1; }

echo ""
echo "Done. Next firing: Friday 17:00 local time."
echo "Archive will land at $ARCHIVE_DIR/{YYYY-MM-DD}.md each Friday."
echo "Trend detection becomes useful after 4 archived reviews accumulate (~1 month)."
