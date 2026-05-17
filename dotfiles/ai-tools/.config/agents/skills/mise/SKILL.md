---
name: mise
description:
  mise dev tools manager. Use when running tasks, managing tool versions, or
  working with project dependencies, dev servers, tests, builds, or releases via
  mise run. Triggers on `mise`, `dev-tools`, `tasks`, `build`, `test`, `deploy`,
  `dependencies`, `toolchain`, and `environment-variables` topics.
allowed-tools: Bash(git:*) Bash(mise:*) Read
---

# mise — Dev Tools & Task Runner

Config: `.config/mise.toml` | Tasks: `.config/mise/tasks/` | Env:
`MISE_ENV=dev|prod` or `.config/miserc.toml`

## Hard Rules

- **Always** use `mise x --` to run any command interacting with the repo —
  ensures env is applied
- **Always** use `mise run <task>` over direct npm/pnpm/tool invocations when an
  equivalent task exists
- **Always** run `mise x -- mise run code:precommit` before committing
- **Always** check `mise tasks` first — don't assume task names
- New task scripts go in `.config/mise/tasks/<group>/<name>` as executable
  `bash` scripts

## Tool Management

```sh
mise install          # install all tools
mise upgrade --local  # upgrade to latest
mise reshim           # rebuild shims after tool changes
mise doctor           # health check
mise list             # list installed tools
mise which <tool>     # path to binary
```

## Tasks

Run with: `mise x -- mise run <task-name>`

Always check `mise tasks` for the authoritative list. Common examples:

```sh
mise run setup:all       # first-time setup
mise run code:format     # format
mise run code:lint       # lint
mise run code:check      # type-check
mise run code:sec        # security scan
mise run code:precommit  # full pre-commit suite (format + lint + check)
```
