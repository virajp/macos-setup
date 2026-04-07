---
name: git-commit-macos-setup
description:
  'Execute git commits in the macos-setup repository using conventional commit
  messages with intelligent diff analysis and message generation. Use this skill
  whenever the user asks to commit changes, create a git commit, stage files, or
  mentions "/commit" in the macos-setup repo. Handles: (1) Analyzing diffs to
  auto-detect commit type, (2) Generating conventional commit messages, (3)
  Running pre-commit hooks before committing, (4) Enforcing project-specific
  commit types and scope rules from git-conventional-commits.yaml.'
---

# Git Commit — macos-setup

Create standardized, semantic git commits for the `macos-setup` repository
following Conventional Commits and the project-specific rules defined in
`git-conventional-commits.yaml`.

## Key Files

- `git-conventional-commits.yaml` — Defines allowed commit types, scopes, and
  issue/URL patterns. Always read this file before committing to pick up any
  changes.
- `.pre-commit-config.yaml` — Defines all pre-commit and commit-msg hooks.

## Conventional Commit Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

The 4 types below are defined in `convention.commitTypes` within
`git-conventional-commits.yaml`. Any type not listed here (e.g., `refactor`,
`test`, `style`, `perf`, `wip`) will be **rejected** by the
`conventional-commits` commit-msg hook.

**Built-in defaults:** `feat` (new features), `fix` (bug fixes)

**Project-specific types from `git-conventional-commits.yaml`:**

| Type    | Purpose                                              |
| ------- | ---------------------------------------------------- |
| `spec`  | OpenSpec artifacts (proposals, specs, design, tasks) |
| `ops`   | Tooling, config, CI, dependencies, operational work  |
| `docs`  | Documentation (markdown files or inline comments)    |
| `merge` | Merge commits (programmatic only, never manual)      |

## Scopes

This repository has **no scopes** defined in `git-conventional-commits.yaml`. Do
not apply a scope to commit messages. If scopes are added later, they will
appear under `convention.commitScopes` in the yaml file — each scope will have
comments indicating which directories it applies to. Only use a scope when the
changed files fall within that scope's designated directories.

**Rule: if `commitScopes` is empty or a change does not match any scope's
directory rules, omit the scope entirely.**

## Type Selection Rules

When analyzing a diff, pick the type that best matches. Only the 4
project-specific types (`spec`, `ops`, `docs`, `merge`) and the 2 built-in
defaults (`feat`, `fix`) are valid — any other type will be rejected.

1. Changes ONLY in markdown or inline documentation → `docs`
2. OpenSpec artifacts (proposals, specs, design docs) → `spec`
3. Config, tooling, CI, dependencies, or adhoc → `ops`
4. Merge commits (programmatic only) → `merge`
5. New user-facing or technical feature → `feat` (built-in default)
6. Bug fix of any kind → `fix` (built-in default)

## Breaking Changes

Use `!` after the type (and scope, if present) to flag a breaking change. Add a
`BREAKING CHANGE:` footer to explain the impact:

```
ops!: remove deprecated config key

BREAKING CHANGE: `extends` key in config file is no longer supported
```

## Pre-Commit Hooks

This repository uses `pre-commit` with hooks that run on **pre-commit** and
**commit-msg** stages. You must run pre-commit before every commit to catch
formatting and linting issues early:

```bash
pre-commit run --all-files
```

Then re-stage any files that were modified by the hooks before committing.

### Hooks in this repository

**Pre-commit stage:**

| Hook                                   | What it does                                     |
| -------------------------------------- | ------------------------------------------------ |
| `check-shebang-scripts-are-executable` | Ensures scripts with shebangs are executable     |
| `check-merge-conflict`                 | Detects merge conflict markers                   |
| `detect-private-key`                   | Blocks private keys from being committed         |
| `end-of-file-fixer`                    | Ensures files end with a newline                 |
| `trailing-whitespace`                  | Removes trailing whitespace                      |
| `check-added-large-files`              | Blocks files larger than 1024 KB                 |
| `check-symlinks`                       | Validates symlinks                               |
| `block-local-identity-configs`         | Prevents local git config user/signing overrides |
| `prettier` (local)                     | Formats `.md`, `.yaml`, `.yml` files             |
| `markdownlint` (local)                 | Lints and fixes markdown files                   |
| `gitleaks`                             | Scans for secrets and credentials                |

**Commit-msg stage:**

| Hook                   | What it does                                         |
| ---------------------- | ---------------------------------------------------- |
| `conventional-commits` | Validates commit message against conventional format |

### Branch protection

This repository does **not** have `no-commit-to-branch` configured in
`.pre-commit-config.yaml`. However, you should still follow the branching
strategy below to maintain a clean history.

## Branching Strategy

- Never commit directly to `main` or `develop` — use feature branches.
- Local branches (other than `main` or `develop`) must be merged to `develop`
  before they are deleted.

## Workflow

### 1. Analyze Changes

```bash
git status --porcelain
git diff --staged
git diff
```

### 2. Run Pre-Commit Hooks

```bash
pre-commit run --all-files
```

If hooks modify files (e.g., prettier reformats a yaml file), re-stage:

```bash
git add <modified-files>
```

### 3. Stage Files

```bash
git add path/to/file1 path/to/file2
```

Never stage secrets (`.env`, credentials, private keys). The
`detect-private-key` and `gitleaks` hooks provide a safety net, but don't rely
on them alone.

### 4. Generate Commit Message

Analyze the staged diff to determine:

- **Type** — match against the type selection rules above
- **Scope** — only include if `commitScopes` defines a matching scope (currently
  none)
- **Description** — one-line summary, present tense, imperative mood, under 72
  characters
- **Body** — for larger commits, list each change prefixed with `-`
- **Footer** — breaking changes, issue references, or other metadata

### 5. Execute Commit

```bash
# Simple commit
git commit -m "<type>: <description>"

# Multi-line commit with body/footer
git commit -m "$(cat <<'EOF'
<type>: <description>

- change detail one
- change detail two

Closes #123
EOF
)"
```

## Best Practices

- One logical change per commit
- Present tense: "add" not "added"
- Imperative mood: "fix bug" not "fixes bug"
- Reference issues (optional): `Closes #123`, `Refs #456`
- Keep description under 72 characters

## Git Safety Protocol

- NEVER update git config
- NEVER run destructive commands (--force, hard reset) without explicit request
- NEVER skip hooks (--no-verify) unless user asks
- NEVER force push to main/develop branches
- NEVER create pull request, use merge script instead
- If commit fails due to hooks, fix and create NEW commit (don't amend)
