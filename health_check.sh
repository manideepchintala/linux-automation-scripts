#!/usr/bin/env bash
# health_check.sh - Basic Linux server health check
# Usage: ./health_check.sh [service1 service2 ...]
# Example: ./health_check.sh ssh cron

LOG_DIR="${LOG_DIR:-$HOME/health_logs}"
LOG_FILE="$LOG_DIR/health_$(date +%F).log"
SERVICES=("$@")

mkdir -p "$LOG_DIR"

{
  echo "===== Health Check: $(date '+%F %T') ====="
  echo "Hostname : $(hostname)"
  echo "Uptime   : $(uptime -p)"
  echo "Load avg : $(cut -d' ' -f1-3 /proc/loadavg)"
  free -m | awk '/Mem:/ {printf "Memory   : %d/%d MB used (%.1f%%)\n", $3, $2, $3*100/$2}'
  df -h / | awk 'NR==2 {print "Disk (/) : " $3 "/" $2 " used (" $5 ")"}'

  for svc in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$svc" 2>/dev/null; then
      echo "Service  : $svc is RUNNING"
    else
      echo "Service  : $svc is NOT running"
    fi
  done
  echo
} | tee -a "$LOG_FILE"
