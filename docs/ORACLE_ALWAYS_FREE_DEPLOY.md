# Oracle Always Free Deployment

This project keeps Lobsters as the dynamic Rails forum and uses Planet only for
static entry and archive publishing.

## Server

1. Create an Oracle Always Free VM, preferably Ampere A1 with Ubuntu.
2. Point `dst.imim.im` to the VM in Cloudflare DNS.
3. Install Docker and the Docker Compose plugin on the VM.
4. Clone your fork of this repository.
5. Copy `.env.production.example` to `.env.production` and fill real values.
6. Start the stack:

```sh
docker compose -f docker-compose.production.yml --env-file .env.production up -d --build
```

## First Admin User

After the stack is healthy, create an admin user from the Rails console:

```sh
docker compose -f docker-compose.production.yml exec web bundle exec rails console
```

Inside the console, create your user, set `is_admin = true`, then create at
least one `Category` and one `Tag` so the site can accept submissions.

## Backups

Create a database dump:

```sh
script/backup_mariadb
```

Restore a dump into the running database:

```sh
FORCE=1 script/restore_mariadb backups/lobsters-YYYYMMDDTHHMMSSZ.sql.gz
```

Run `script/backup_mariadb` from host cron daily. Keep a weekly copy outside the
VM, such as NAS, cloud drive, or object storage.

## Planet Export

Export public forum content to a static folder:

```sh
docker compose -f docker-compose.production.yml exec web bundle exec script/export_planet_static
```

Publish `planet-public/` with Planet's folder publishing feature. Static pages
link back to `https://$SITE_DOMAIN` for login, posting, comments, and voting.
