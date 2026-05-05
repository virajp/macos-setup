---
name: mise
description:
  mise dev tools manager. Use when running tasks, managing tool versions, or
  working with project dependencies, dev servers, tests, builds, or releases via
  mise run. Triggers on `mise`, `dev-tools`, `tasks`, `build`, `test`, `deploy`,
  `dependencies`, `toolchain`, and `environment-variables` topics.
allowed-tools: Bash(git:*) Bash(mise:*) Read
---

# mise - Dev Tools & Task Runner (95octane)

## Overview

mise manages tool versions (Node, pnpm, Doppler, gcloud, etc.) and runs all
project tasks. Tasks live in `.config/mise/tasks/` as executable shell scripts.
Config is at `.config/mise.toml`. Environment wise config may exist in
`.config/mise.*.toml`, and environment is set via `MISE_ENV=dev|prod` or
`.config/miserc.toml`

**IMPORTANT**: Always use `mise run <task>` instead of running npm/pnpm scripts
directly when an equivalent task exists. Tasks handle setup dependencies
(starting Docker services, installing packages, etc.) automatically.

## Tool Management

```sh
mise install          # Install all tools defined in mise.toml
mise upgrade --local  # Upgrade all tools to latest versions
mise reshim           # Rebuild shims after tool changes
mise doctor           # Check mise health
mise list             # List installed tools
mise which <tool>     # Show path to tool binary
mise registry <tool>  # Show tool registry info
```

## Tasks

> ALWAYS refer to `mise tasks` output for the list of tasks, and their
> descriptions, configured in the project.

Run any task with: `mise run <task-name>`

## Examples of Common Workflows

```sh
# First-time project setup
mise run setup

# Format, lint & type-check everything
mise run code:format
mise run code:lint
mise run code:check
mise run code:sec

# Run format, lint, type-check, and security checks together
mise run code:all
```

## Key Rules

1. **Always run `mise run code:all` before committing** — enforced via a
   `PreToolUse` hook on Bash that intercepts `git commit` commands. This runs
   code formater, linter, type-checker, etc across all repository and auto-fixes
   issues.
2. **ALWAYS run mise tasks** — use `mise run {tasks:name}` instead of any direct
   command.
3. **Task files** live in `.config/mise/tasks/<group>/<name>` as executable
   scripts. New tasks follow this convention.
4. **`mise tasks`** lists all available tasks if unsure what exists.
