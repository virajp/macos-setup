---
name: git-workflow
description: Use this skill to manage git workflows, including creating
  worktrees, branches, making commits, merging and pushing changes. Follow the
  repository's commit message conventions and branching strategy.
allowed-tools: Bash(git:*) Bash(mise:*) Read
---

# Git Workflow

## Core Rules

- Use `git worktree` for all substantive changes — never work directly in the
  main worktree
- Use `merge` (not PRs) to land changes: `mise x -- mise run merge:develop` or
  `mise x -- mise run merge:main`
- Never push without explicit user request — always ask after a successful
  commit
- Check `no-commit-to-branch` hook in `.config/pre-commit-config.yaml` before
  committing to any branch

## Commit Format

```text
<type>(<scope>): <description>
```

- Lowercase, imperative mood, under 72 characters, no trailing period
- Scope is optional — omit when change spans multiple areas
- **Authoritative types and scopes**: always read
  `.config/git-conventional-commits.yaml` — do not invent scopes

Common types: `feat`, `fix`, `refactor`, `wip`, `spec`, `test`, `ops`, `docs`,
`merge`

## Commit Workflow

1. Work from **repository root**
2. `mise x -- mise run code:precommit` — auto-fix lint/format, re-stage
3. `git status` → `git add <files>` (never `git add -A`)
4. `git diff --cached` — review staged changes
5. Determine type/scope from `.config/git-conventional-commits.yaml`
6. `git commit -m "<type>(<scope>): <description>"`
7. If hooks fail: fix, then **new commit** (never `--amend` after hook failure)
8. Ask user whether to push

## Useful Commands (use when appropriate)

| Situation                             | Command                             |
| ------------------------------------- | ----------------------------------- |
| Save unfinished work temporarily      | `git stash` / `git stash pop`       |
| Clean up WIP commits before merge     | `git rebase -i <base>`              |
| Find which commit introduced a bug    | `git bisect start` / `good` / `bad` |
| Inspect a file's change history       | `git log -p -- <file>`              |
| Undo last commit, keep changes staged | `git reset --soft HEAD~1`           |
| View branch divergence                | `git log --oneline --graph --all`   |

## Safety Rules

- NEVER: `--force`, `--no-verify`, `reset --hard`, force-push to
  `main`/`develop`, update git config
- Only destructive operations with explicit user request
