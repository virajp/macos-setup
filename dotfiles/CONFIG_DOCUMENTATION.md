# Configuration Documentation

This document explains the less-obvious settings and customizations in the
dotfiles configuration. Each top-level directory under `dotfiles/` groups one
app's config; `mise.toml`'s `[dotfiles]` map symlinks them into `$HOME` (see
[`readme.md`](./readme.md)).

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
| `pnpm/`       | Global pnpm settings (`config.yaml`); auth stays in `~/.npmrc`     |
| `homebrew/`   | The `brewfile` (source of truth for installed packages)            |
| `dprint/`     | `dprint` / `taplo` formatter configuration                         |
| `gem/`        | RubyGems configuration                                             |
| `1Password/`  | 1Password SSH agent configuration                                  |
| `ai-tools/`   | Claude Code (`claude/`) and GitHub Copilot (`copilot/`) config     |
| `mempalace/`  | mempalace/qdrant docker compose stack (see below)                  |
| `pitchfork/`  | Pitchfork daemon config — supervises the mempalace stack           |

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

`dotfiles/mise/config.toml` is the global `mise` config. It pins language/CLI
tool versions, sets `pnpm` as the npm package manager, enables `uvx` for pipx,
and defines a large set of `[shell_alias]` shortcuts — including `updateall`,
`osx-upgrade`, IP helpers (`ipv4`, `gateway`, …), and cleanup tasks. The task
scripts themselves live under `mise/tasks/`.

## mempalace (MCP memory server)

`dotfiles/mempalace/` holds the `docker compose` stack for the mempalace MCP
server (HTTP, `127.0.0.1:8765`) and its qdrant backend, with data bind-mounted
from `~/.local/share/mempalace` and `~/.local/share/qdrant`. The image is built
locally from PyPI rather than pulled, since `ghcr.io/mempalace/mempalace` is not
anonymously pullable.

[Pitchfork](https://pitchfork.jdx.dev/) supervises the stack as a global daemon
(`dotfiles/pitchfork/config.toml`) and starts it at login. `mempalace:*` mise
tasks (`dotfiles/mise/tasks/mempalace/`) wrap the pitchfork/compose lifecycle;
`mempalace:update` rebuilds the images weekly and is called from `updateall`.
There is deliberately no local `mempalace` CLI install — the `mempalace` shell
alias runs `status` inside the container instead (see `docs/mempalace.md`'s "CLI
access" section for why). See [`docs/mempalace.md`](../docs/mempalace.md) for
one-time setup.

## Git

`git/root/gitconfig` includes host-specific configs conditionally
(`git/git/gitconfig-github`, `gitconfig-gitlab`) and uses a global ignore file
(`git/root/gitignore_global`). Commit signing keys live in `ssh/` and are
referenced via `ssh/allowed_signers`.

## Link map

`dotfiles/mise.toml` is the single source of truth for what gets linked where.
Only paths listed there are symlinked, so repo metadata is never linked by
accident. `mode = "symlink"` links the source itself; `mode = "symlink-each"`
links each entry inside the source directory individually (used for `~/.ssh` and
`~/.config/gh`, where other tools write sibling files).
