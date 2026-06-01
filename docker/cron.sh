#!/usr/bin/env bash
set -euo pipefail

echo "Starting Lobsters cron loop"

while true; do
  bundle exec script/expire_page_cache || true

  minute="$(date +%M)"
  if (( 10#$minute % 5 == 0 )); then
    bundle exec script/lobsters-cron || true
  fi

  sleep 60
done
