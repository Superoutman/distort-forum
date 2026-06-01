#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${DATABASE_HOST:-}" ]]; then
  echo "Waiting for MariaDB at ${DATABASE_HOST}:3306..."
  until mariadb-admin ping -h"${DATABASE_HOST}" -P3306 -u"${MARIADB_USER:-lobsters}" -p"${MARIADB_PASSWORD:-}" --silent; do
    sleep 2
  done
fi

case "${1:-web}" in
  web)
    bundle exec rails db:prepare
    bundle exec rails assets:precompile
    exec bundle exec rails server -b 0.0.0.0 -p "${PORT:-3000}"
    ;;
  worker)
    exec bundle exec bin/jobs
    ;;
  cron)
    exec docker/cron.sh
    ;;
  *)
    exec "$@"
    ;;
esac
