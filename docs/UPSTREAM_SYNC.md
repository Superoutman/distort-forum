# Upstream Sync

The local site should track Lobsters upstream carefully instead of auto-deploying
new upstream commits.

## Remotes

Use your fork as `origin` and official Lobsters as `upstream`:

```sh
git remote add origin git@github.com:YOUR_ACCOUNT/lobsters.git
git remote add upstream https://github.com/lobsters/lobsters.git
```

If this repository was cloned directly from official Lobsters, rename the
existing remote first:

```sh
git remote rename origin upstream
git remote add origin git@github.com:YOUR_ACCOUNT/lobsters.git
```

## Manual Sync

```sh
git fetch upstream
git checkout -b upstream-sync/$(date +%Y-%m-%d) main
git merge upstream/main
bundle exec rspec
bundle exec standardrb
bundle exec brakeman --ensure-ignore-notes
bundle exec database_consistency --config .database_consistency.ignore.yml
```

Before merging, verify `app/views/layouts/application.html.erb` still loads
`site_theme.css` after the upstream theme stylesheet.
