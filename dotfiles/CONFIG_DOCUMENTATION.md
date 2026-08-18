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

The default interactive shell is **fish**; `zsh` is kept in sync as a fallback.
Set fish as the login shell via the steps in
[`docs/shell.md`](../docs/shell.md).

Both shells activate `mise` exactly once, with the same split: interactive
shells get a full `mise activate`, non-interactive shells get `--shims`. In fish
this is the if/else in `conf.d/51-mise.fish`; in zsh it is split across two
files, because `.zshrc` is interactive-only — `.zshenv` handles the
non-interactive half behind an `[[ ! -o interactive ]]` guard.

`mise` must activate **after** `brew shellenv` in both shells. mise wins
precedence by prepending to `PATH`, so anything that touches `PATH` afterwards
takes it back — and tools present in both Homebrew and mise (`jq`, `yq`) would
silently resolve to the Homebrew copy.

### Fish loading sequence

1. `conf.d/*.fish` — sorted by filename across **all** conf.d directories,
   including Homebrew's `vendor_conf.d`
2. `config.fish` — main configuration

Homebrew's `mise` formula ships `vendor_conf.d/mise-activate.fish`, which sorts
after `51-mise.fish` and would re-run a full `mise activate`, overriding the
shims branch. `51-mise.fish` sets `MISE_FISH_AUTO_ACTIVATE=0` to suppress it.

`fish_add_path` writes to **universal** scope, which persists in
`~/.config/fish/fish_variables` independently of any config file. Removing a
`fish_add_path` line does not remove the path — that needs an explicit
`set --erase --universal fish_user_paths`.

### Prompt

**Starship** is the active prompt (`06-prompt.fish` calls `starship init`). The
Oh My Posh themes are kept as an alternative — the `oh-my-posh init` block in
`06-prompt.fish` is commented out and can be swapped in if preferred.

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
