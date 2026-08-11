# CLAUDE.md

Guidance for working in this repo. This is a personal macOS provisioning repo —
a Homebrew `brewfile`, dotfiles managed with `mise bootstrap dotfiles`, and a
`mise` task runner.

## Layout

- `setup` — top-level installer (Homebrew → brewfile → dotfiles → macOS
  defaults).
- `utils/macos-setup` — `defaults`/`pmset`/`nvram` macOS system settings.
- `dotfiles/` — one directory per app (`fish/`, `git/`, `mise/`, `homebrew/`,
  `ai-tools/`, …).
- `dotfiles/mise.toml` — the `[dotfiles]` link map: which source file lands at
  which `$HOME` path, and in which mode.
- `dotfiles/homebrew/brewfile` — source of truth for installed packages.
- `dotfiles/mise/` — global mise config + task scripts (shell aliases like
  `updateall`, `osx-upgrade`, IP helpers).
- `.config/mise/tasks/` — repo-local mise tasks (`brew:*`, `dotfiles:*`,
  `code:*`).
- `docs/` — manual setup steps.

## Commands

Prefer `mise` for everything (`mise tasks` to list):

```shell
mise run dotfiles:install # symlink dotfiles (dotfiles:status to see what's missing)
mise run brew:gen         # regenerate brewfile from installed packages
mise run brew:check       # diff system against brewfile
mise run code:format      # format (dprint/taplo)
mise run code:lint        # lint
```

## Conventions

- **Commits**: conventional commits, types limited to `spec`, `ops`, `docs`,
  `merge` (see `.config/git-conventional-commits.yaml`). Most changes are
  `ops:`.
- **Formatting**: dprint + taplo; pre-commit hooks run via `mise run code:lint`.
- **Secrets**: managed by `fnox` via the macOS Keychain — never commit plaintext
  secrets.
- **Dotfiles edits**: edit the file under `dotfiles/<pkg>/...`; it is symlinked
  into `$HOME`, so changes take effect immediately. New files need an entry in
  `dotfiles/mise.toml`, then `dotfiles:install`.
- Keep `dotfiles/CONFIG_DOCUMENTATION.md` accurate when adding/removing
  packages.
