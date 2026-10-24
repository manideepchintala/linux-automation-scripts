#!/usr/bin/env bash
# disk_alert.sh - Warn when any filesystem crosses a usage threshold
# Usage: ./disk_alert.sh [threshold_percent]   (default 80)
# Exit code: 0 = all OK, 1 = at least one filesystem over threshold

THRESHOLD="${1:-80}"
ALERT=0

while read -r fs size used avail pct mount; do
  usage="${pct%\%}"
  if (( usage >= THRESHOLD )); then
    echo "ALERT: $mount is ${usage}% full (threshold ${THRESHOLD}%)"
    ALERT=1
  fi
done < <(df -hP -x tmpfs -x devtmpfs | tail -n +2)

if (( ALERT == 0 )); then
  echo "OK: all filesystems are below ${THRESHOLD}%"
fi

exit $ALERT
