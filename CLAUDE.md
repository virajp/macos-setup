# CLAUDE.md

Guidance for working in this repo. This is a personal macOS provisioning repo —
everything declared in the global mise config for `mise bootstrap` (packages,
dotfiles, macOS defaults, login shell, Touch ID), and a `mise` task runner.

## Layout

- `setup` — top-level installer (Homebrew → mise → `mise bootstrap`).
- `dotfiles/` — one directory per app (`fish/`, `git/`, `mise/`, `ai-tools/`,
  …).
- `dotfiles/mise/` — the global mise config, linked to `~/.config/mise`.
  `config.toml` holds settings, `[tools]`, `[env]` and shell aliases;
  `mise.lock` + `locks/` pin what `latest` resolved to (`lockfile = true`;
  `updateall`'s `mise upgrade` moves them — commit the diff); `conf.d/*.toml`
  holds the machine declaration `mise bootstrap` applies (from any directory):
  `packages.toml` (`[bootstrap.packages]` — Homebrew formulae and App Store
  apps), `macos.toml` (`[bootstrap.macos.defaults]`, hooks, the `bootstrap`
  task), `system.toml` (`[bootstrap.files]` Touch ID, `[bootstrap.user]` login
  shell + `/etc/shells` lines, `[bootstrap.compose]`).
- `dotfiles/mise.toml` — the `[dotfiles]` link map: which source file lands at
  which `$HOME` path, in which mode. A project config on purpose (it changes
  with the repo, not the machine), applied with `mise run dotfiles:install`;
  sources are relative to `dotfiles/`.
- `dotfiles/mise/tasks/` — global mise tasks: `updateall`, `upgrade:*`,
  `mempalace:*`, IP helpers, and the bootstrap hook tasks `macos:power`
  (`pmset`/`nvram`, run as the `bootstrap` task), `macos:appstore`
  (pre-packages), `brew:casks` and `tailscale:daemon` (post-packages).
- `dotfiles/homebrew/brewfile` — casks and VS Code extensions only; these stay
  on Homebrew (mise's cask support is narrow). Formulae never go here.
- `.config/mise/tasks/` — repo-local mise tasks (`dotfiles:*`, `code:*`,
  `setup:*`, `system:symlinks`).
- `docs/` — manual setup steps.

## Commands

Prefer `mise` for everything (`mise tasks` to list):

```shell
mise run dotfiles:install       # (re)link dotfiles (dotfiles:status shows drift)
mise bootstrap status           # machine vs declared state (any directory)
mise bootstrap --dry-run        # preview a full converge
mise bootstrap packages status  # system vs [bootstrap.packages]
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
  `dotfiles/mise.toml`, then `mise run dotfiles:install`.
- **Packages**: formulae and App Store apps → `"brew:<formula>"` / `"mas:<id>"`
  in `[bootstrap.packages]` (`dotfiles/mise/conf.d/packages.toml`), then
  `mise bootstrap packages apply`. Casks and VS Code extensions →
  `dotfiles/homebrew/brewfile`, then `mise run brew:casks`. Versioned dev tools
  → `[tools]` in `dotfiles/mise/config.toml`, never a formula. Third-party taps
  need `api/formula/<name>.json` published in the tap repo.
- Keep `dotfiles/CONFIG_DOCUMENTATION.md` accurate when adding/removing
  packages.
