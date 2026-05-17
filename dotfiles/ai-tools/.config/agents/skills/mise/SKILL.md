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

**IMPORTANT**: Always use `mise x --` to run any command that interacts with the
repository (git, file edits, etc.) to ensure that environment setup is applied.
This is critical for maintaining consistent environment across all tasks and
agents.

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

## Examples of Common tasks

```sh
mise run setup:all   # First-time project setup
mise run code:format # Format code
mise run code:lint   # Lint code
mise run code:check  # Type-check code
mise run code:sec    # Security checks
```

## Key Rules

1. **Always run `mise x -- mise run code:precommit` before committing**. This
   runs code formater, linter, type-checker, etc across repository and
   auto-fixes issues.
2. **ALWAYS run mise tasks** — use `mise x -- mise run {tasks:name}` instead of
   any direct command.
3. **Task files** live in `.config/mise/tasks/<group>/<name>` as executable
   scripts. New tasks follow this convention.
4. **`mise tasks`** lists all available tasks if unsure what exists.
5. **Use Bash**: All task scripts are `bash`. Use `bash` for any new scripts to
   maintain consistency.
