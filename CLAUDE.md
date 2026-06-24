# CLAUDE.md

Guidance for working in this repo. This is a personal macOS provisioning repo —
a Homebrew `brewfile`, dotfiles managed with GNU Stow, and a `mise` task runner.

## Layout

- `setup` — top-level installer (Homebrew → brewfile → stow → macOS defaults).
- `utils/macos-setup` — `defaults`/`pmset`/`nvram` macOS system settings.
- `dotfiles/` — one GNU Stow package per app (`fish/`, `git/`, `mise/`,
  `homebrew/`, `ai-tools/`, …). Contents symlink into `$HOME`.
- `dotfiles/homebrew/brewfile` — source of truth for installed packages.
- `dotfiles/mise/.config/mise/` — global mise config + task scripts (shell
  aliases like `updateall`, `osx-upgrade`, IP helpers).
- `.config/mise/tasks/` — repo-local mise tasks (`brew:*`, `stow:*`, `code:*`).
- `docs/` — manual setup steps.

## Commands

Prefer `mise` for everything (`mise tasks` to list):

```shell
mise run stow:install    # symlink dotfiles (stow:simulate for a dry run)
mise run brew:gen        # regenerate brewfile from installed packages
mise run brew:check      # diff system against brewfile
mise run code:format     # format (dprint/taplo)
mise run code:lint       # lint
```

## Conventions

- **Commits**: conventional commits, types limited to `spec`, `ops`, `docs`,
  `merge` (see `.config/git-conventional-commits.yaml`). Most changes are
  `ops:`.
- **Formatting**: dprint + taplo; pre-commit hooks run via `mise run code:lint`.
- **Secrets**: managed by `fnox` via the macOS Keychain — never commit plaintext
  secrets.
- **Dotfiles edits**: edit the file under `dotfiles/<pkg>/...`; it is symlinked
  into `$HOME`, so changes take effect after `stow:install`.
- Keep `dotfiles/CONFIG_DOCUMENTATION.md` accurate when adding/removing
  packages.
