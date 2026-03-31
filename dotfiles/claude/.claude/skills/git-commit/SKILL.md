---
name: git-commit
description:
  'Execute git commit with conventional commit message analysis, intelligent
  staging, and message generation. Use when user asks to commit changes, create
  a git commit, or mentions "/commit". Supports: (1) Auto-detecting type and
  scope from changes, (2) Generating conventional commit messages from diff, (3)
  Interactive commit with optional type/scope/description overrides, (4)
  Intelligent file staging for logical grouping'
license: MIT
allowed-tools: Bash
---

# Git Commit with Conventional Commits

## Overview

Create standardized, semantic git commits using the Conventional Commits
specification. Analyze the actual diff to determine appropriate type, scope, and
message.

## Key Files

- `git-conventional-commits.yaml`: Configuration for commit types, scopes, and rules. 
  Read this file to detect the defined commit types, scopes, and selection rules.

## Conventional Commit Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

| Type       | Purpose                                              | In Changelog |
| ---------- | ---------------------------------------------------- | ------------ |
| `feat`     | New features or functionality                        | Yes          |
| `fix`      | Any change that fixes something                      | Yes          |
| `refactor` | Refactoring of code or system                        | Yes          |
| `test`     | Changes that are ONLY for tests                      | No           |
| `docs`     | Documentation (markdown or inline code comments)     | No           |
| `spec`     | OpenSpec artifacts (proposals, specs, design, tasks) | No           |
| `style`    | Code formatting changes                              | No           |
| `ops`      | Adhoc tasks, tooling, config, or operational work    | No           |
| `wip`      | Work in progress (anything, use sparingly)           | No           |
| `merge`    | Merge commits (programmatic only, never manual)      | No           |

## Scopes

Scope MUST only be used when changes are within directories from scope's comments

If changes are outside these directories, do NOT include a scope.

## Type Selection Rules

- Changes in `omc/` → always use `spec`
- Changes ONLY in test files → use `test`
- Changes ONLY in markdown or inline docs → use `docs`
- New feature or functionality (user-facing or technical) → use `feat`
- Bug fix of any kind → use `fix`
- Code restructuring without behavior change → use `refactor`
- Config, tooling, CI, dependencies, or adhoc → use `ops`
- Incomplete work → use `wip`

## Breaking Changes

```
feat!: remove deprecated endpoint

BREAKING CHANGE: `extends` key behavior changed
```

## Workflow

### 1. Analyze Diff

```bash
git diff --staged
git diff
git status --porcelain
```

### 2. Stage Files (if needed)

```bash
git add path/to/file1 path/to/file2
```

**Never commit secrets** (.env, credentials.json, private keys).

### 3. Generate Commit Message

Analyze the diff to determine:

- **Type**: Match against the type selection rules above
- **Scope**: Only include if changes are in folders specified in scope comments
- **Description**: One-line summary (present tense, imperative mood, <72 chars)
- **Body**: For large commit, specify each change in the body prefixed with `-`
- **Footer**: Add footer in case required, as specified in the 
  `git-conventional-commits.yaml` file

### 4. Execute Commit

```bash
git commit -m "<type>[scope]: <description>"

git commit -m "$(cat <<'EOF'
<type>[scope]: <description>

<optional body>

<optional footer>
EOF
)"
```

## Best Practices

- One logical change per commit
- Present tense: "add" not "added"
- Imperative mood: "fix bug" not "fixes bug"
- Reference issues: `Closes #123`, `Refs #456`
- Keep description under 72 characters

## Git Safety Protocol

- NEVER update git config
- NEVER run destructive commands (--force, hard reset) without explicit request
- NEVER skip hooks (--no-verify) unless user asks
- NEVER force push to main/master
- NEVER create pull request, use merge script instead
- If commit fails due to hooks, fix and create NEW commit (don't amend)
