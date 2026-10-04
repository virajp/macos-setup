# CLAUDE.md

Guidance for working in this repo. This is a personal macOS provisioning repo —
everything declared in the global mise config for `mise bootstrap` (packages,
dotfiles, macOS defaults, login shell, Touch ID), and a `mise` task runner.

## Layout

- `setup` — top-level installer (Homebrew → mise → `mise bootstrap`).
- `dotfiles/` — a mirror of `$HOME`: each file sits at the path it is linked to
  (`dotfiles/.config/fish/` → `~/.config/fish/`, `dotfiles/.zshrc` → `~/.zshrc`,
  `dotfiles/.claude/` → `~/.claude/`, …).
- `dotfiles/.config/mise/` — the global mise config, linked to `~/.config/mise`.
  `config.toml` holds settings (including `dotfiles.root`, the source root for
  every link) and `lockfile = false`; `conf.d/*.toml` holds one file per topic,
  each carrying that topic's `[tools]`, `[env]`, `[shell_alias]`,
  `[bootstrap.*]` packages/files/services and `[dotfiles]` links, all applied by
  `mise bootstrap` from any directory: `shell.toml` (login shell, Touch ID
  `/etc/pam.d/sudo_local`, `/etc/shells` lines, zsh/fish links),
  `macos-defaults.toml` (`[bootstrap.macos.defaults]` + the `post-defaults`
  hook), `devtools.toml`, `git.toml` (incl. `~/.config/gh/config.yml`),
  `node.toml`, `python.toml`, `claude.toml` (taps, `claude-status`, `~/.claude`
  links), `mempalace.toml` (qdrant compose + the `mempalace-hub` service),
  `terminal.toml` (ghostty, warp, starship, fonts), `cli.toml`, `network.toml`,
  `containers.toml`, `security.toml` (1Password, fnox, SSH), `macos-apps.toml`,
  `system.toml` (system utility apps, Homebrew env, mise link, maintenance
  aliases).
- Identity — personal values live only in `[vars]` of
  `dotfiles/.config/mise/conf.d/identity.toml`. The identity files are Tera
  templates rendered from them by `mise bootstrap` (`mode = "template"`):
  `.config/git/identity` (`[user]`, included by `.config/git/config`),
  `github.config`, `gitlab.config`, `allowed_signers`, and
  `.ssh/config.identity` (`User`, included in `Host *`). Their rendered copies
  in `$HOME` are not symlinks: edit the template or the vars, then
  `mise bootstrap --only dotfiles`. Keep new personal values in `[vars]`, not in
  shared files.
- `dotfiles/.config/mise/tasks/` — global mise tasks: `updateall`, `upgrade:*`
  (incl. `upgrade:power`, the `pmset`/`nvram` profile), `mempalace:*`,
  `tailscale:daemon`, `func:*`, IP helpers.
- `dotfiles/.config/brewfile` — VS Code extensions (and the `1password` cask);
  its `[dotfiles]` link is off and `updateall` no longer runs it.
- `.config/mise/tasks/` — repo-local mise tasks (`dotfiles:*`, `code:*`,
  `setup:*`, `system:symlinks`).
- `docs/` — manual setup steps.

## Commands

Prefer `mise` for everything (`mise tasks` to list):

```shell
mise run dotfiles:install       # (re)link dotfiles only (dotfiles:status shows drift)
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
- **Dotfiles edits**: edit the file under `dotfiles/` at its `$HOME` path; it is
  symlinked into `$HOME`, so changes take effect immediately. New files need a
  `[dotfiles]` entry in the matching `conf.d/<topic>.toml`, then
  `mise run dotfiles:install`.
- **Packages**: formulae, casks and App Store apps → `"brew:<formula>"`,
  `"brew-cask:<cask>"`, `"mas:<id>"` in `[bootstrap.packages]` of the matching
  `conf.d/<topic>.toml`, then `mise bootstrap packages apply`. Versioned dev
  tools → `[tools]`, never a formula. Third-party taps need
  `api/formula/<name>.json` published in the tap repo.
- Keep `dotfiles/CONFIG_DOCUMENTATION.md` accurate when adding/removing
  packages.
