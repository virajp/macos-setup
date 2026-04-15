---
name: mise
description:
  mise dev tools manager. Use when running tasks, managing tool versions, or
  working with project dependencies, dev servers, tests, builds, or releases via
  mise run.
skill_version: 2.0.0
updated_at: 2026-04-15T02:30:00Z
tags:
  [
    mise,
    dev-tools,
    tasks,
    build,
    test,
    deploy,
    dependencies,
    toolchain,
    environment-variables,
  ]
progressive_disclosure:
  entry_point:
    summary: "mise manages tools and tasks"
    when_to_use:
      "Running dev servers, builds, tests, linting, releasing, or managing
      dependencies, environment variables or tool versions."
    quick_start:
      "Use `mise run <task>` for any project operation. Config lives in
      .config/mise.toml and tasks in .config/mise/tasks/"
  references: []
context_limit: 800
---

# mise - Dev Tools & Task Runner (95octane)

## Overview

mise manages tool versions (Node, pnpm, Doppler, gcloud, etc.) and runs all
project tasks. Tasks live in `.config/mise/tasks/` as executable shell scripts.
Config is at `.config/mise.toml`. Environment wise config may exist in
`.config/mise.*.toml`, and environment is set via `MISE_ENV=dev|prod` or
`.config/miserc.toml`

**IMPORTANT**: Always use `mise run <task>` instead of running npm/pnpm/bun
scripts directly when an equivalent task exists. Tasks handle setup dependencies
(starting Docker services, installing packages, etc.) automatically.

## Tool Management

```sh
mise install          # Install all tools defined in mise.toml
mise upgrade --local  # Upgrade all tools to latest versions
mise reshim           # Rebuild shims after tool changes
mise doctor           # Check mise health
mise list             # List installed tools
mise which <tool>     # Show path to tool binary
```

## Tasks

> ALWAYS refer to `mise tasks` output for the list of tasks, and their
> descriptions, configured in the project.

Run any task with: `mise run <task-name>`

## Shell Aliases

These aliases are available in a mise-activated shell (set in mise config):

### Examples

| Alias           | Expands to                 |
| --------------- | -------------------------- |
| `setup`         | `mise run setup`           |
| `upgrade`       | `mise run pnpm:install`    |
| `lint`          | `mise run all:lint`        |
| `check`         | `mise run all:check`       |
| `dev`           | `mise run s:dev`           |
| `web-dev`       | `mise run web:dev`         |
| `test-all`      | `mise run s:test:all`      |
| `test-external` | `mise run s:test:external` |
| `dev-merge`     | `mise run dev:merge`       |
| `prod-merge`    | `mise run prod:merge`      |
| `pkg`           | `mise run deps:packages`   |
| `pnpm-install`  | `mise run pnpm:install`    |
| `npx`           | `pnpm dlx`                 |

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
