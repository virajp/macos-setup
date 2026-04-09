---
name: pre-commit
description: >
  Pre-commit hook configuration and workflow for the 95octane apiService
  monorepo. Use this skill whenever the user encounters pre-commit failures,
  wants to commit code, asks about linting or formatting errors (Biome,
  Prettier, Markdownlint), asks about gitleaks or secret scanning, asks about
  commit message format or conventional commits, wants to skip or run hooks
  manually, or asks how to install or update pre-commit hooks. Also use when the
  user asks why a commit was rejected or what hooks are running.
version: 1.0.0
---

# Pre-Commit Hooks — 95octane apiService

This project uses [`pre-commit`](https://pre-commit.com) with hooks for two
stages: `pre-commit` (runs on `git commit`) and `commit-msg` (validates the
commit message).

## Installed Hooks

### pre-commit stage

| Hook ID                                | What it checks                                                                            |
| -------------------------------------- | ----------------------------------------------------------------------------------------- |
| `no-commit-to-branch`                  | Blocks direct commits to `main` or `develop`                                              |
| `check-shebang-scripts-are-executable` | Shell scripts with shebangs must be executable                                            |
| `check-merge-conflict`                 | Rejects files with unresolved merge markers (`<<<<<<<`)                                   |
| `detect-private-key`                   | Blocks PEM/RSA private keys from being committed                                          |
| `end-of-file-fixer`                    | Ensures every file ends with a newline                                                    |
| `forbid-submodules`                    | Prevents git submodules                                                                   |
| `trailing-whitespace`                  | Strips trailing whitespace from all files                                                 |
| `check-added-large-files`              | Blocks files over 1 MB (1024 KB)                                                          |
| `check-symlinks`                       | Validates symlinks                                                                        |
| `block-local-identity-configs`         | Prevents local `.git/config` from overriding global `user.*` / `gpg.*` / signing settings |
| `local-run-prettier`                   | Prettier format (`--write`) on `.md/.yaml/.yml`                                           |
| `local-run-markdownlint`               | Markdownlint (`--fix`) on `.md` files                                                     |
| `gitleaks`                             | Scans staged content for secrets using `.gitleaks.toml`                                   |
| `local-run-biome`                      | BiomeJS lint + format (`--write`) on `.js/.jsx/.ts/.tsx/.json`                            |

> NOTE that some of the hooks are repository specific, like `local-run-biome`
> above.

### commit-msg stage

| Hook ID                | What it checks                                          |
| ---------------------- | ------------------------------------------------------- |
| `conventional-commits` | Enforces conventional commit message format (see below) |

## Commit Message Format

> Use `git-commit` skill for commit message

## Common Commands

```sh
# Install hooks (run once after cloning or after updating config)
pre-commit install

# Run all hooks manually against all files
pre-commit run --all-files

# Run a single hook by ID
pre-commit run local-run-biome
pre-commit run gitleaks
pre-commit run conventional-commits

# Run hooks on staged files only (what git commit does)
pre-commit run

# Update hook versions to latest
pre-commit autoupdate
```

## Fixing Common Failures

### Biome errors (JS/TS/JSON)

> Use `biome` skill

Check `biome.jsonc` for project-specific rules.

### Prettier errors (MD/YAML/YML)

Prettier runs with `--write` automatically. To fix manually:

```sh
pnpm dlx prettier --config ./.prettierrc.yaml --write "**/*.{md,yaml,yml}"
```

### Markdownlint errors (MD)

Markdownlint runs with `--fix`. To fix manually:

```sh
pnpm dlx markdownlint-cli2 --fix --format "**/*.md"
```

### Trailing whitespace / end-of-file

These auto-fix on the first failed commit attempt — just `git add` the modified
files and commit again.

### Gitleaks secret detected

> Use `gitleaks` skill

### Conventional commit rejected

> Use `git-commit` skill

### Block-local-identity-configs

This hook prevents `.git/config` from containing `user.name`, `user.email`,
`user.signingkey`, `commit.gpgsign`, `tag.gpgsign`, `gpg.*` settings. These must
live in the global `~/.gitconfig`.

To remove them:

```sh
git config --local --unset user.name
git config --local --unset user.email
# etc.
```

### No-commit-to-branch

Direct commits to `main` or `develop` are blocked. Always work on the `work`
branch (for small changes) or a feature branch. Use `mise run dev:merge` to
promote to `develop`.

## Skipping Hooks (Emergency Only)

Skip a specific hook without disabling others:

```sh
SKIP=gitleaks git commit -m "ops: ..."
SKIP=local-run-biome,local-run-prettier git commit -m "wip: ..."
```

Bypass all pre-commit hooks (use only as a last resort):

```sh
git commit --no-verify -m "..."
```

> Never use `--no-verify` for gitleaks bypasses on real secrets. Rotate the
> secret and clean the history instead.
