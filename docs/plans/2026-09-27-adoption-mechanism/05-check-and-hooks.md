# U5 — adopt:check task and pre-commit hooks

- **Wave:** 2
- **Depends on:** U1, U2
- **Owns:** `.config/mise/tasks/adopt/check`, `.config/mise/tasks/code/lint`,
  `.config/pre-commit-config.yaml`
- **Model:** opus
- **Kind:** edit
- **Read first:** every owned file that exists, `.config/mise/tasks/code/graph`
  (hook-task model), `.config/mise/tasks/_scripts/_helpers`,
  `docs/adopt/modules.toml`.

## Ruling

> 11 — Background pre-commit hook `adopt-changelog` at `post-commit` and
> `post-merge` stages; drafts land uncommitted in `changelog.md`; approving =
> editing and committing; discarding =
> `git checkout -- docs/adopt/changelog.md`.
>
> 13 — `adopt:check` fails when a tracked file (`git ls-files`) matches neither
> a module's `files` nor `exclude`, or a module `files` glob / `personal.file`
> matches nothing. Wired into `code:lint` (runs first) and a local `adopt-check`
> pre-commit hook.
>
> 14 — Tasks read TOML via `yq -p toml -o json`.

## Edits

1. **`.config/mise/tasks/adopt/check`** (new, executable) — repo-task
   conventions: `#!/usr/bin/env bash`,
   `#MISE description="Check that docs/adopt/modules.toml covers every tracked file"`,
   `#MISE dir="{{ config_root }}"`, `set -euo pipefail`, source `_helpers`.
   Logic:
   - read `docs/adopt/modules.toml` with `yq -p toml -o json`;
   - glob matching: repo-relative, `**` = any depth, `*` = within one path
     segment; implement with bash `globstar` + `extglob` or a translation to a
     regex — documented in a comment;
   - fail (non-zero, one `print_error` line per problem) when: a `git ls-files`
     entry matches no module `files` and no `exclude`; a module `files` glob
     matches no tracked file; a `personal[].file` glob matches no tracked file;
     two modules list the same file; a `depends` id is unknown;
   - print a one-line summary (`N files, M modules`) with `print_ok` on success.
2. **`.config/mise/tasks/code/lint`** — before the `pnpm dlx` call, run
   `mise run adopt:check` (fails the lint when it fails). Nothing else changes.
3. **`.config/pre-commit-config.yaml`**:
   - `default_install_hook_types` gains `post-merge`.
   - A local hook `adopt-check` (`entry: mise x -- mise run adopt:check`,
     `language: system`, `pass_filenames: false`, `always_run: true`, default
     `pre-commit` stage), placed next to the other local hooks, with a
     `description` like its neighbours.
   - A local hook `adopt-changelog`
     (`entry: mise x -- mise run adopt:changelog`, `language: system`,
     `pass_filenames: false`, `always_run: true`,
     `stages: [ post-commit, post-merge ]`), placed right after
     `graphify-refresh`, with a `description` saying it drafts adoption
     changelog entries in the background on `main`, uncommitted, for review.

## Verification

- `mise run adopt:check` exits 0 on the worktree.
- Add a scratch tracked file outside every module
  (`git add -N scratch-adopt-probe`), confirm `mise run adopt:check` exits
  non-zero and names it, then
  `git reset -q -- scratch-adopt-probe && rm scratch-adopt-probe`. (The index is
  restored; nothing is staged.)
- `mise x -- pre-commit validate-config .config/pre-commit-config.yaml` passes.
- The wave gate lines pass (now including `adopt:check` via `code:lint`).

## Guardrails

- Do not create `.config/mise/tasks/adopt/changelog` (U6 owns it).
- Do not run `pre-commit install` — that is the after-landing step.
- Match the repo's task header and helper conventions exactly.

## Commit

`ops: add adopt:check and the adoption pre-commit hooks`
