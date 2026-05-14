#!/bin/bash
# /memory-curator cron setup — Sunday 14:00
# Tested on AWS Lightsail Ubuntu 24.04 LTS

PROJECT_DIR="$HOME/.claude/projects/my-brain"
SKILL_DIR="$HOME/.claude/skills/memory-curator"

# ============================================================
# 1. Verify prerequisites
# ============================================================
command -v claude >/dev/null 2>&1 || { echo "ERROR: claude CLI not installed"; exit 1; }
[ -d "$PROJECT_DIR" ] || { echo "ERROR: $PROJECT_DIR does not exist"; exit 1; }
[ -f "$SKILL_DIR/SKILL.md" ] || { echo "ERROR: memory-curator skill not installed"; exit 1; }

mkdir -p "$PROJECT_DIR/memory/_meta"
mkdir -p "$PROJECT_DIR/memory/_archive"

[ -f "$PROJECT_DIR/memory/_meta/curator_rules.md" ] || { echo "ERROR: curator_rules.md missing. Copy from templates/"; exit 1; }

# ============================================================
# 2. Test the skill manually first (DRY RUN, do not modify files)
# ============================================================
echo "Running /memory-curator manually as a dry run (no file changes)..."
cd "$PROJECT_DIR" || exit 1
claude --skill memory-curator --dry-run --output stdout

read -p "Did the dry-run output look correct? (y/N) " confirm
[ "$confirm" = "y" ] || { echo "Aborting cron install. Fix the skill output first."; exit 1; }

# ============================================================
# 3. Install the cron job (start in --dry-run for first 4 weeks)
# ============================================================
read -p "Use --auto mode (apply safe auto-actions)? RECOMMEND NO for first 4 weeks. (y/N) " auto_mode
if [ "$auto_mode" = "y" ]; then
  CRON_LINE="0 14 * * SUN cd $PROJECT_DIR && /usr/local/bin/claude --skill memory-curator --auto --report telegram"
else
  CRON_LINE="0 14 * * SUN cd $PROJECT_DIR && /usr/local/bin/claude --skill memory-curator --dry-run --report telegram"
fi

( crontab -l 2>/dev/null | grep -v "memory-curator" ; echo "$CRON_LINE" ) | crontab -

echo "[OK] Installed cron line:"
echo "     $CRON_LINE"

# ============================================================
# 4. Verify
# ============================================================
crontab -l | grep "memory-curator" >/dev/null && echo "[OK] crontab confirms entry"
systemctl is-active --quiet cron && echo "[OK] cron daemon running" || { echo "[FAIL] cron daemon not running"; exit 1; }

echo ""
echo "Done. Next firing: Sunday 14:00 local time."
echo "Audit report will land in your Telegram + memory/_meta/last_audit.md (append mode)."
echo ""
echo "RECOMMENDATION: keep --dry-run for the first 4 audits. Switch to --auto only after"
echo "you trust the suggestions. Edit the cron line manually when ready."
