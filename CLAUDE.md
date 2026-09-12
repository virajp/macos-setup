# CLAUDE.md

Guidance for working in this repo. This is a personal macOS provisioning repo —
everything declared in `dotfiles/mise.toml` for `mise bootstrap` (packages,
dotfiles, macOS defaults, login shell, Touch ID), and a `mise` task runner.

## Layout

- `setup` — top-level installer (Homebrew → mise → `mise bootstrap`).
- `dotfiles/` — one directory per app (`fish/`, `git/`, `mise/`, `ai-tools/`,
  …).
- `dotfiles/mise.toml` — the bootstrap declaration: `[bootstrap.packages]`
  (source of truth for installed Homebrew/App Store packages),
  `[bootstrap.macos.defaults]`, `[bootstrap.files]` (Touch ID),
  `[bootstrap.user]` (login shell), hooks, and the `[dotfiles]` link map (which
  source file lands at which `$HOME` path, in which mode). Run it with
  `mise --cd dotfiles bootstrap`.
- `.config/mise/tasks/macos/power` — `pmset`/`nvram` (no mise equivalent), run
  as the `bootstrap` task. `brew:extras` and `vscode:extensions` cover what
  `[bootstrap.packages]` cannot (see the comment atop `dotfiles/mise.toml`).
- `dotfiles/mise/` — global mise config + task scripts (shell aliases like
  `updateall`, `osx-upgrade`, IP helpers).
- `.config/mise/tasks/` — repo-local mise tasks (`dotfiles:*`, `code:*`,
  `macos:*`, `brew:extras`, `vscode:extensions`).
- `docs/` — manual setup steps.

## Commands

Prefer `mise` for everything (`mise tasks` to list):

```shell
mise run dotfiles:install # symlink dotfiles (dotfiles:status to see what's missing)
mise --cd dotfiles bootstrap status           # everything vs declared state
mise --cd dotfiles bootstrap packages status  # system vs [bootstrap.packages]
mise --cd dotfiles bootstrap --dry-run        # preview a full converge
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
- **Packages**: add `"brew:<formula>"`, `"brew-cask:<cask>"` or `"mas:<id>"` to
  `[bootstrap.packages]` in `dotfiles/mise.toml`, then
  `mise --cd dotfiles bootstrap packages apply`. Never run
  `mise bootstrap packages prune` — the tap items from `brew:extras` are not
  declared there and would be removed.
- Keep `dotfiles/CONFIG_DOCUMENTATION.md` accurate when adding/removing
  packages.
