# Git Commit Guidelines

This repository follows
[Conventional Commits](https://www.conventionalcommits.org/) enforced by
`git-conventional-commits` and pre-commit hooks.

## Commit Message Format

```text
<type>: <description>

[optional body]

[optional footer(s)]
```

- **No scopes** are defined for this repository. Do not include a scope.
- Description must be under 72 characters, present tense, imperative mood (e.g.,
  "add feature" not "added feature").

## Allowed Commit Types

Only the following types are accepted. Any other type (e.g., `refactor`, `test`,
`style`, `perf`, `chore`, `wip`) will be **rejected** by the commit-msg hook.

| Type    | Purpose                                              |
| ------- | ---------------------------------------------------- |
| `spec`  | OpenSpec artifacts (proposals, specs, design, tasks) |
| `ops`   | Tooling, config, CI, dependencies, operational work  |
| `docs`  | Documentation (markdown files or inline comments)    |
| `merge` | Merge commits (programmatic only, never manual)      |

### Type Selection Rules

1. Changes **only** in markdown or inline documentation -> `docs`
2. OpenSpec artifacts (proposals, specs, design docs) -> `spec`
3. Config, tooling, CI, dependencies, or ad hoc -> `ops`
4. Merge commits (programmatic only) -> `merge`

## Breaking Changes

Flag breaking changes with `!` after the type and add a `BREAKING CHANGE:`
footer:

```text
ops!: remove deprecated config key

BREAKING CHANGE: `extends` key in config file is no longer supported
```

## Body and Footer

- For larger commits, list each change in the body prefixed with `-`.
- Reference issues in footers: `Closes #123`, `Refs #456`.

## Examples

```text
ops: add Homebrew tap for custom formulae
```

```text
docs: update setup instructions for macOS Sequoia

- revise shell configuration section
- add note about Xcode CLI tools
```

```text
ops: upgrade pre-commit hooks to latest versions
```

## Pre-Commit Hooks

This repository runs hooks on both **pre-commit** and **commit-msg** stages. The
`conventional-commits` commit-msg hook validates the message format
automatically. Additional hooks enforce formatting (prettier, markdownlint),
security (gitleaks, detect-private-key), and file hygiene (trailing whitespace,
end-of-file newline).
