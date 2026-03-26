---
name: mise
description:
  mise dev tools manager for the 95octane monorepo. Use when running tasks,
  managing tool versions, or working with project dependencies, dev servers,
  tests, builds, or releases via mise run.
skill_version: 1.0.0
updated_at: 2026-03-22T00:00:00Z
tags: [mise, dev-tools, tasks, build, test, deploy, dependencies, toolchain]
progressive_disclosure:
  entry_point:
    summary: "mise manages tools and tasks for the 95octane monorepo"
    when_to_use:
      "Running dev servers, builds, tests, linting, releasing, or managing
      dependencies in the 95octane monorepo"
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
Config is at `.config/mise.toml`.

**IMPORTANT**: Always use `mise run <task>` instead of running pnpm scripts
directly when an equivalent task exists. Tasks handle setup dependencies
(starting Docker services, installing packages, etc.) automatically.

## Tool Management

```sh
mise install          # Install all tools defined in mise.toml
mise upgrade --bump   # Upgrade all tools to latest
mise reshim           # Rebuild shims after tool changes
mise doctor           # Check mise health
mise list             # List installed tools
mise which <tool>     # Show path to tool binary
```

## Task Reference

Run any task with: `mise run <task-name>`

### Setup & Maintenance

| Task              | Description                                         |
| ----------------- | --------------------------------------------------- |
| `setup`           | Full project setup (install tools, deps, precommit) |
| `pnpm:install`    | Clean + upgrade + outdated check + audit            |
| `pnpm:upgrade`    | Upgrade pnpm packages                               |
| `pnpm:outdated`   | Check for outdated packages                         |
| `pnpm:audit`      | Run security audit                                  |
| `pnpm:cleanup`    | Clean pnpm cache                                    |
| `doppler:setup`   | Configure Doppler secrets                           |
| `all:turbo:clean` | Clean all turbo build artifacts                     |

### Dependencies (Docker services, Firebase emulators)

| Task            | Description                              |
| --------------- | ---------------------------------------- |
| `deps:start`    | Start Docker Compose services (detached) |
| `deps:stop`     | Stop Docker Compose services             |
| `deps:restart`  | Restart Docker Compose services          |
| `deps:update`   | Update Docker images                     |
| `deps:packages` | Build `@95octane/common` package         |

### Service (`projects/service` - Hono API)

| Task              | Description                                    |
| ----------------- | ---------------------------------------------- |
| `s:dev`           | Start dev server (lints, starts deps, imports) |
| `s:build`         | Build the service                              |
| `s:start`         | Start the built service                        |
| `s:test:all`      | Run full test suite (internal mode)            |
| `s:test:external` | Run external integration tests                 |
| `s:test:users`    | Run user module tests only                     |
| `s:test:rides`    | Run ride module tests only                     |
| `s:test:routes`   | Run route module tests only                    |
| `s:test:places`   | Run place module tests only                    |
| `s:test:watch`    | Run tests in watch mode                        |
| `s:cov:internal`  | Generate internal coverage report              |
| `s:cov:external`  | Generate external coverage report              |

### Worker (`projects/worker` - Temporal)

| Task      | Description       |
| --------- | ----------------- |
| `k:dev`   | Start worker dev  |
| `k:build` | Build the worker  |
| `k:check` | Type-check worker |
| `k:lint`  | Lint worker       |
| `k:start` | Start the worker  |

### Web (`projects/web` - Astro)

| Task      | Description       |
| --------- | ----------------- |
| `w:dev`   | Start web dev     |
| `w:build` | Build the web app |

### All Projects

| Task            | Description                    |
| --------------- | ------------------------------ |
| `all:build`     | Build all projects & packages  |
| `all:check`     | Type-check all (turbo check)   |
| `all:lint`      | Lint & format all (pnpm lint)  |
| `all:leaks`     | Run gitleaks secret scan       |
| `all:precommit` | Run pre-commit hooks           |
| `all:versions`  | Show all tool/package versions |

### Release

| Task                     | Description                 |
| ------------------------ | --------------------------- |
| `release:service:tag`    | Tag service release         |
| `release:service:image`  | Build service Docker image  |
| `release:service:deploy` | Deploy service to Cloud Run |
| `release:worker:tag`     | Tag worker release          |
| `release:worker:image`   | Build worker Docker image   |
| `release:worker:deploy`  | Deploy worker to Cloud Run  |

### Git Workflows

| Task         | Description                     |
| ------------ | ------------------------------- |
| `dev:merge`  | Merge current branch to develop |
| `prod:merge` | Merge current branch to main    |

### Data Import

| Task           | Description            |
| -------------- | ---------------------- |
| `import:local` | Import local seed data |
| `import:prod`  | Import production data |

### Utilities

| Command      | Description              |
| ------------ | ------------------------ |
| `mise tasks` | List all available tasks |

## Shell Aliases

These aliases are available in a mise-activated shell (set in `mise.toml`):

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

## Common Workflows

```sh
# First-time project setup
mise run setup

# Start developing (service)
mise run s:dev        # lints, starts Docker deps, imports data, starts server

# Run tests
mise run s:test:all           # full suite
mise run s:test:users         # users module only
mise run s:test:rides         # rides module only

# Lint & type-check everything
mise run all:lint
mise run all:check

# Build all projects
mise run all:build

# Update dependencies
mise run pnpm:install

# Release service
mise run release:service:tag
mise run release:service:image
mise run release:service:deploy
```

## Key Rules

1. **Always run `mise run all:lint` before committing** — enforced via a
   `PreToolUse` hook on Bash that intercepts `git commit` commands. This runs
   BiomeJS lint + markdownlint across all workspaces and auto-fixes issues.
2. **Never run vitest directly** — use `mise run s:test:*` tasks or pnpm scripts
   from `projects/service/package.json` (which inject Doppler secrets).
3. **Tests require Doppler** — all test tasks handle this via pnpm scripts.
4. **`deps:packages`** builds `@95octane/common` and is called automatically by
   test tasks to ensure the shared package is compiled before tests run.
5. **Task files** live in `.config/mise/tasks/<group>/<name>` as executable
   scripts. New tasks follow this convention.
6. **`mise tasks`** lists all available tasks if unsure what exists.
