#!/bin/bash
# /morning-brief cron setup
# Tested on AWS Lightsail Ubuntu 24.04 LTS, Frankfurt region.
# Adapt paths for your VM.

# ============================================================
# 1. Verify prerequisites
# ============================================================
command -v claude >/dev/null 2>&1 || { echo "ERROR: claude CLI not installed. See https://docs.claude.com/en/docs/claude-code/overview"; exit 1; }
command -v crontab >/dev/null 2>&1 || { echo "ERROR: cron not installed. apt install cron -y"; exit 1; }

PROJECT_DIR="$HOME/.claude/projects/my-brain"
[ -d "$PROJECT_DIR" ] || { echo "ERROR: project dir $PROJECT_DIR does not exist. Fork templates/ first."; exit 1; }

SKILL_DIR="$HOME/.claude/skills/morning-brief"
[ -f "$SKILL_DIR/SKILL.md" ] || { echo "ERROR: morning-brief skill not installed. cp -r skills/morning-brief $HOME/.claude/skills/"; exit 1; }

echo "[OK] All prerequisites present"

# ============================================================
# 2. Test the skill manually first (DRY RUN)
# ============================================================
echo "Running /morning-brief manually as a dry run..."
cd "$PROJECT_DIR" || exit 1
claude --skill morning-brief --output stdout --dry-run

read -p "Did the dry-run output look correct? (y/N) " confirm
[ "$confirm" = "y" ] || { echo "Aborting cron install. Fix the skill output first."; exit 1; }

# ============================================================
# 3. Install the cron job
# ============================================================
CRON_LINE="0 7 * * * cd $PROJECT_DIR && /usr/local/bin/claude --skill morning-brief --output telegram --log $PROJECT_DIR/memory/morning_brief_log.md"

# Append to crontab if not already present
( crontab -l 2>/dev/null | grep -v "morning-brief" ; echo "$CRON_LINE" ) | crontab -

echo "[OK] Installed cron line:"
echo "     $CRON_LINE"

# ============================================================
# 4. Verify cron is active and the daemon is running
# ============================================================
crontab -l | grep "morning-brief" >/dev/null && echo "[OK] crontab confirms entry" || echo "[FAIL] entry not found in crontab"
systemctl is-active --quiet cron && echo "[OK] cron daemon is running" || { echo "[FAIL] cron daemon not running. systemctl start cron"; exit 1; }

# ============================================================
# 5. Print next 5 cron firing times for sanity-check
# ============================================================
echo ""
echo "Next 5 firing times for the morning brief:"
# Requires the 'cronie' or 'next' utility — fall back to a printed message
echo "  Tomorrow at 07:00 local time (and every day after)"
echo ""
echo "Done. Check your Telegram tomorrow at 07:00."
echo "If no brief lands, check $PROJECT_DIR/memory/morning_brief_log.md for the cron error trace."
