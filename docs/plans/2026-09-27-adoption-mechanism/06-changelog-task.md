# U6 — adopt:changelog drafting task

- **Wave:** 2
- **Depends on:** U1, U2, U4
- **Owns:** `.config/mise/tasks/adopt/changelog`
- **Model:** opus
- **Kind:** edit
- **Read first:** `.config/mise/tasks/code/graph` (the model for guards, logging
  and backgrounding), `.config/mise/tasks/_scripts/_helpers`,
  `docs/adopt/modules.toml`, `docs/adopt/changelog.md`.

## Ruling

> 9 — each entry `## <YYYY-MM-DD> — <title>` followed by bullets
> `- **Modules:** <ids>`, `- **Commit:** <full sha>`,
> `- **Change:** <what
> changed>`,
> `- **Adopter action:** <what a friend's AI should do>`.
>
> 10 — `adopt:changelog` bash task drafts via `claude -p`; only the owner runs
> it.
>
> 11 — Background pre-commit hook `adopt-changelog` at `post-commit` and
> `post-merge` stages; drafts land uncommitted in `changelog.md`; approving =
> editing and committing; discarding =
> `git checkout -- docs/adopt/changelog.md`.
>
> 12 — The task drafts only when the current branch is `main`; it covers every
> qualifying commit reachable from HEAD after the newest `Commit:` sha in the
> working-tree `changelog.md` (so uncommitted drafts count and nothing is
> drafted twice). Qualifying = subject starts `ops:` and touches a file some
> module's `files` matches. Skips when `ADOPT_SKIP_HOOK=1`, during
> rebase/merge/cherry-pick, and when there is nothing qualifying. `post-merge`
> is needed because a fast-forward merge fires no `post-commit`.
>
> 14 — Tasks read TOML via `yq -p toml -o json`.

## Edits

1. **`.config/mise/tasks/adopt/changelog`** (new, executable) — repo-task
   conventions (`#!/usr/bin/env bash`,
   `#MISE description="Draft adoption
   changelog entries for new ops: commits on main"`,
   `set -euo pipefail`, source `_helpers`). Flags via `#USAGE`:
   - `--since <sha>` — start after this commit instead of the newest `Commit:`
     sha (backfill);
   - `--dry-run` — print drafts to stdout, write nothing, run in the foreground;
   - `--foreground` — write, but do not detach. Behaviour:
   1. Exit 0 silently when `ADOPT_SKIP_HOOK=1`; when the branch is not `main`
      (`git symbolic-ref --short -q HEAD`); during rebase/merge/cherry-pick
      (same markers as `code:graph`).
   2. Range start: `--since`, else the newest full-sha `Commit:` value in the
      working-tree `docs/adopt/changelog.md` (ignore `baseline`); if none, the
      commit that added `docs/adopt/changelog.md`
      (`git log --diff-filter=A --format=%H -- docs/adopt/changelog.md | tail -1`).
   3. Candidates: `git rev-list --reverse <start>..HEAD`, keeping commits whose
      subject starts `ops:` and whose changed files
      (`git diff-tree
      --no-commit-id --name-only -r <sha>`) match at least
      one module's `files` (same glob semantics as `adopt:check` — reuse by
      extracting a shared helper function into this file, not by editing U5's).
      Map each commit to its module ids. Exit 0 when none.
   4. If `claude` is not on PATH, `print_warn` and exit 0.
   5. Unless `--dry-run`/`--foreground`, re-exec itself detached with
      `nohup … >>"$HOME/.cache/adopt-changelog.log" 2>&1 </dev/null &` +
      `disown`, printing one `print_yellow` line with the log path, and exit 0 —
      the commit returns at once.
   6. For each candidate (oldest first): build a prompt containing the entry
      format (decision 9), the commit's subject, body, full sha, date, module
      ids, and `git show --stat` plus a size-capped diff (first ~400 lines);
      instruct: output exactly one entry in the format, `Commit:` = the full
      sha, `Adopter action:` addressed to a friend's AI, no preamble; call
      `claude -p` with it. Validate the output has the four bullets and the
      right sha; on failure log and skip that commit.
   7. Insert the entries newest-first directly under the file's intro (before
      the first existing `##` entry). With `--dry-run`, print them instead.
   8. Never `git add` or commit anything.

## Verification

- `bash -n .config/mise/tasks/adopt/changelog` passes;
  `mise tasks | grep adopt:changelog` lists it.
- On the worktree branch (not `main`): `mise run adopt:changelog` exits 0 and
  writes nothing (guard).
- `mise run adopt:changelog --dry-run --since HEAD~5` on the worktree branch
  also exits 0 without output because of the `main` guard — document in a
  comment that `--dry-run` still honours the branch guard; the orchestrator's
  pre-landing check runs it with `--since` from the main checkout after landing.
  (If you judge `--dry-run` should bypass the branch guard, return `DECIDED:`
  with the reason.)
- `ADOPT_SKIP_HOOK=1 mise run adopt:changelog` exits 0 immediately.
- `git status --short docs/adopt/changelog.md` is empty after all of the above.
- The wave gate lines pass.

## Guardrails

- Do not edit `.config/pre-commit-config.yaml` or `adopt/check` (U5).
- Never write outside `docs/adopt/changelog.md` and the log file.
- Never stage or commit.

## Commit

`ops: add adopt:changelog, drafting adoption entries with claude -p`
