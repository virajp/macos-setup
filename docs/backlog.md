# Backlog

Parked work in this repo. Everything here is currently commented out or dormant
— nothing is broken.

## Disabled config

| Item                                                  | Location                    | Note                                                                                   |
| ----------------------------------------------------- | --------------------------- | -------------------------------------------------------------------------------------- |
| `oh-my-pi` tool                                       | `dotfiles/mise/config.toml` | Commented out in `[tools]`; decide whether to adopt or drop                            |
| `mempalace` shell alias (`mise run mempalace:status`) | `dotfiles/mise/config.toml` | Commented out in `[shell_alias]`; the `mempalace:*` tasks still exist                  |
| `backup` / `zipf` shell aliases                       | `dotfiles/mise/config.toml` | Commented out; task scripts `tasks/func/backup` and `tasks/func/zip` are still present |

## Known issues

- **`bclm` block is fish syntax in a zsh script** — `utils/macos-setup`, the
  optional hardware charge-limit section. It reads `if type -q bclm … end`,
  which is fish; the script runs under `#!/usr/bin/env zsh`. Uncommenting it
  as-is is a syntax error. Rewrite as
  `if command -v bclm > /dev/null; then … fi` before enabling.
