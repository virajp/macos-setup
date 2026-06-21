# Configuration Documentation

This document explains the less-obvious settings and customizations in the
dotfiles configuration. Each top-level directory under `dotfiles/` is a
[GNU Stow](https://www.gnu.org/software/stow/) package whose contents are
symlinked into `$HOME` (see [`readme.md`](./readme.md)).

## Directory Structure

| Package       | What it configures                                                 |
| ------------- | ------------------------------------------------------------------ |
| `fish/`       | Fish shell — the default interactive shell (`conf.d/*.fish`)       |
| `zsh/`        | Zsh configuration (legacy / fallback shell)                        |
| `nushell/`    | Nushell configuration with a custom vendor autoload system         |
| `starship/`   | Starship prompt (the active prompt, initialised from fish)         |
| `oh-my-posh/` | Oh My Posh prompt themes (`shell.yaml`, `claude.yaml`) — alternate |
| `ghostty/`    | Ghostty terminal configuration                                     |
| `git/`        | Git config, ignores, and conditional includes for GitHub/GitLab    |
| `github/`     | GitHub CLI (`gh`) configuration and hosts                          |
| `ssh/`        | SSH client config and commit-signing public keys                   |
| `fnox/`       | Secret management via the macOS Keychain (see below)               |
| `mise/`       | Global `mise` tool versions, env, and task runner shortcuts        |
| `homebrew/`   | The `brewfile` (source of truth for installed packages)            |
| `dprint/`     | `dprint` / `taplo` formatter configuration                         |
| `gem/`        | RubyGems configuration                                             |
| `1Password/`  | 1Password SSH agent configuration                                  |
| `ai-tools/`   | Claude Code, OpenCode, Gemini CLI, and shared agent skills         |

## Shells & Prompt

The default interactive shell is **fish**; `zsh` and `nushell` are also kept in
sync. Set fish as the login shell via the steps in
[`docs/shell.md`](../docs/shell.md).

### Fish loading sequence

1. `conf.d/*.fish` — sorted by their numeric prefix (`01-env`, `02-path`, …)
2. `config.fish` — main configuration

### Prompt

**Starship** is the active prompt (`06-prompt.fish` calls `starship init`). The
Oh My Posh themes are kept as an alternative — the `oh-my-posh init` block in
`06-prompt.fish` is commented out and can be swapped in if preferred.

### Nushell vendor autoload

Files in `vendor/autoload/` load in sorted order, e.g. `00-env.nu`,
`01-aliases.nu`, `02-homebrew.nu`, `99-zoxide.nu`, `99-oh-my-posh.nu`.

## Secret Management (fnox)

Secrets are stored in the **macOS Keychain** and surfaced as environment
variables by [`fnox`](https://github.com/jdx/fnox), activated in
`fish/conf.d/52-fnox.fish` and wired into `mise` via the `fnox-env` plugin.
`dotfiles/fnox/fnox.toml` defines the mapped secrets (e.g. `GITHUB_API_TOKEN`,
`HOMEBREW_GITHUB_API_TOKEN`). There is no plaintext secret file in this repo.

## Tooling via mise

`dotfiles/mise/.config/mise/config.toml` is the global `mise` config. It pins
language/CLI tool versions, sets `pnpm` as the npm package manager, enables
`uvx` for pipx, and defines a large set of `[shell_alias]` shortcuts — including
`updateall`, `osx-upgrade`, IP helpers (`ipv4`, `gateway`, …), and cleanup
tasks. The task scripts themselves live under `mise/.config/mise/tasks/`.

## Git

`git/.gitconfig` includes host-specific configs conditionally
(`.gitconfig-github`, `.gitconfig-gitlab`) and uses a global ignore file
(`.gitignore_global`). Commit signing keys live in `ssh/.ssh/` and are
referenced via `ssh/.ssh/allowed_signers`.

## Stow ignore rules

`dotfiles/.stow-local-ignore` keeps stow from symlinking repo metadata (`.git`,
`.gitignore`, `.DS_Store`, the ignore file itself, and `history.*` files).
