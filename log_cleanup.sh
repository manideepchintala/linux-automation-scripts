#!/usr/bin/env bash
# log_cleanup.sh - Delete old .log files from a directory
# Usage: ./log_cleanup.sh <directory> [days] [--dry-run]
# Example: ./log_cleanup.sh /var/log/myapp 7 --dry-run

DIR="${1:-}"
DAYS="${2:-7}"
MODE="${3:-}"

if [[ -z "$DIR" || ! -d "$DIR" ]]; then
  echo "Usage: $0 <directory> [days] [--dry-run]"
  exit 1
fi

if [[ "$DIR" == "/" ]]; then
  echo "Refusing to run on /"
  exit 1
fi

if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
  echo "Days must be a number"
  exit 1
fi

echo "Log files older than $DAYS days in $DIR:"
find "$DIR" -type f -name "*.log" -mtime +"$DAYS" -print

if [[ "$MODE" == "--dry-run" ]]; then
  echo "Dry run: nothing was deleted."
  exit 0
fi

COUNT=$(find "$DIR" -type f -name "*.log" -mtime +"$DAYS" | wc -l)
find "$DIR" -type f -name "*.log" -mtime +"$DAYS" -delete
echo "Deleted $COUNT file(s)."
