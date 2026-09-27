---
type: vwf-change-plan
title: Adoption mechanism for friends
requires: [ docs/plans/2026-09-27-personal-values-overlay ]
backlog: []
backlog_pieces: []
---

# Plan — Adoption mechanism for friends (2026-09-27)

## Status

**APPROVED**

APPROVED 2026-09-27 by the user

## Consent

| Action                                                                            | Granted |
| --------------------------------------------------------------------------------- | ------- |
| Merge to the integration branch and push on green                                 | no      |
| After landing: `mise install`, `mise run setup:precommit`, `mise run adopt:check` | run     |
| Release macos-setup publicly                                                      | none    |

**The mode recorded here is the consent.** A `run` step runs on a green landing
without a prompt; an `ask` step stops the run once before it, reports what it
would do, and waits. The mode is the interview's answer (item 17), and a release
step recorded `run` is authorised by the interview's release question (item 18)
— a release recorded `ask`, or with no step at all, is intent, not
authorisation. Where a step stages something this session already loaded, it is
picked up only by a **restarted** session.

macos-setup has no version file and no release process; "none" is the recorded
release intent, with no bump command. Pushing to main is what publishes
`llms.txt` to friends — landing is therefore `no` (ask).

## Goal

A friend pastes one prompt from the owner's readme into any AI tool and gets a
new or existing macOS setup repo set up — or later synced — to this repo's
current design, with their own personal values and their chosen modules, without
asking the owner.

Framing: friends clone this repo and ask their own AI tools to adapt to the
owner's frequent changes, which costs the owner support time. The mechanism has
three parts: a description of how the repo is built (guide), a machine-readable
module map separating core from optional and marking personal fields (manifest),
and a record of adopter-relevant changes since a given commit (changelog), plus
a sync record in each friend's repo. Plan 2 of 2 — requires
`docs/plans/2026-09-27-personal-values-overlay`, which moves personal values
into identity files this plan's manifest points at. No reversal of a standing
decision.

## Facts the survey established

- After plan 1 lands, personal values live only in: `dotfiles/git/identity`
  (linked `~/.config/git/identity`), `dotfiles/ssh/config.identity`,
  `dotfiles/mise/conf.d/identity.toml` (`GITHUB_EMAIL`, `GITHUB_SIGNING_KEY`,
  `GITHUB_USER_NAME`, `GITLAB_EMAIL`, `GITLAB_SIGNING_KEY`, `GITLAB_USER_NAME`),
  `dotfiles/ssh/signingkeys/*`, `dotfiles/ssh/allowed_signers`; plus
  `dotfiles/mise/conf.d/mempalace.toml` (literal
  `project_dir = "/Users/<user>/.config/mempalace"` — mise cannot template it;
  an adopter substitutes their username) and
  `dotfiles/ai-tools/claude/settings.json` (absolute local marketplace paths,
  `virajp-plugins` marketplace, `autoMode` block describing another repo —
  whole-file personal). `dotfiles/mise/conf.d/claude.toml` holds the public
  `virajp/tap` + `claude-status`.
- Values left in place on purpose (the guide must tell the friend's AI what to
  do): starship palette `viraj_dark` (cosmetic; rename optional);
  `@askviraj/linter` (in `code:lint`, the `linter` pre-commit hook,
  `eslint.config.mjs`, `.config/linter.yaml`) and `@askviraj/*`, `@virajp.dev/*`
  in `dotfiles/pnpm/config.yaml`; `@virajp.dev/claude-plugins` in
  `dotfiles/mise/tasks/upgrade/ai`; repo-meta URLs in
  `.config/git-conventional-commits.yaml`, `docs/setup.md`, and `setup`
  (`GITHUB_USER` default `virajp`, overridable); `.config/statusline.json`
  `$schema` URL; the `mas:` App Store list in `conf.d/packages.toml` (public
  ids, taste); `docs/ai-tools/readme.md` link to `virajp/ai-plugins`.
- The `GITHUB_*` / `GITLAB_*` identity variables are required by the owner's
  `vwf` plugin: "part of gitconfig, like the env variables to support multiple
  SCM (github, gitlab, etc). These are programmed in my `vwf` plugin so are
  mandatory".
- Tracked files outside `dotfiles/`: `.claude/settings.json`,
  `.config/{git-conventional-commits.yaml,gitleaks.toml,linter.yaml,mise.lock,mise.toml,pre-commit-config.yaml,statusline.json,taplo.toml}`,
  `.config/mise/tasks/{_scripts/_helpers,code/*,dotfiles/*,setup/*,system/symlinks}`,
  `.gitignore`, `.vscode/*`, `CLAUDE.md`, `LICENSE`, `TASKS.md`, `docs/*.md`,
  `docs/ai-tools/readme.md`, `docs/plans/**`, `dprint.json` (symlink),
  `eslint.config.mjs`, `readme.md`, `setup`. `graphify-out/` is untracked.
- `dotfiles/` packages: `1Password`, `ai-tools/{claude,copilot}`, `dprint`,
  `fish`, `fnox`, `gem`, `ghostty`, `git`, `github`, `homebrew` (brewfile:
  casks + VS Code extensions), `mempalace`, `mise` (config.toml, mise.lock,
  conf.d/*, tasks/**), `oh-my-posh`, `pnpm`, `ssh`, `starship`, `zsh`; plus
  `dotfiles/mise.toml` (link map), `dotfiles/readme.md`,
  `dotfiles/CONFIG_DOCUMENTATION.md`. Global tasks under `dotfiles/mise/tasks/`:
  `_scripts/helpers`, `brew/casks`, `cleanupDS`, `cleanupTelegram`, `func/*`,
  `ips/*`, `macos/{appstore,power}`, `mempalace/*`, `tailscale/daemon`,
  `updateall`, `upgrade/*`.
- Repo-task conventions: `#!/usr/bin/env bash`; `#MISE description="…"`,
  optional `#MISE dir=…`/`hide=`; `#USAGE flag "--x" help="…"` read as
  `${usage_x:-false}`; `set -e` (or `set -euo pipefail`);
  `source
  "${MISE_PROJECT_ROOT}/.config/mise/tasks/_scripts/_helpers"`
  (functions `print_header`, `print_subheader`, `print_ok`, `print_warn`,
  `print_error`, `print_yellow`, `print_green`, `line_sep`, …).
  `.config/mise.toml` `[tasks.init]` chmods every task file to 755.
- `.config/mise/tasks/code/graph` is the model for a background post-commit
  task: skips in a linked worktree (compares `git rev-parse --git-dir` and
  `--git-common-dir`), skips during rebase/merge/cherry-pick markers, skips a
  commit that only touched its own output (loop guard), honours a
  `*_SKIP_HOOK=1` env var, logs to `~/.cache/<name>.log`, detaches with
  `nohup … &` + `disown`.
- `.config/pre-commit-config.yaml` has
  `default_install_hook_types:
  [pre-commit, commit-msg, post-commit]` and a
  local `graphify-refresh` hook (`entry: mise x -- mise run code:graph`,
  `stages: [ post-commit ]`, `always_run: true`, `pass_filenames: false`).
  `setup:precommit` runs
  `pre-commit install --config .config/pre-commit-config.yaml --all
  --install-hooks --overwrite`,
  which installs every type in `default_install_hook_types`.
- `code:lint` runs `pnpm dlx @askviraj/linter` from `$MISE_PROJECT_ROOT`.
  `.config/mise.toml` `[tools]` pins `dprint`, `node`, `pnpm`, `pre-commit`,
  `taplo` (all `latest`, `lockfile = true` in effect via `.config/mise.lock`).
  `yq` is a global tool only.
- `TASKS.md` mirrors every repo task's `#MISE description` and `#USAGE` flags,
  hand-maintained (no generator found).
- Gates: `mise run code:format`, `mise run code:lint`, pre-commit hooks (see
  plan 1 facts). No CI. Commit types: `spec`, `ops`, `docs`, `merge`; no scopes.
- The raw URL friends fetch:
  `https://raw.githubusercontent.com/virajp/macos-setup/main/llms.txt`. The repo
  is public.
- Backlog: no `macos-setup` GitHub Project — backlog unreadable (no project
  yet); this plan covers no backlog item.

## Assumed decisions — confirm or override at review

| #  | Decision              | Ruling                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Rejected                                                                                | Unit       |
| -- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | ---------- |
| 1  | Sync model            | Hybrid: friends' repos are independent and AI-synced from guide + changelog; personal values already isolated by plan 1.                                                                                                                                                                                                                                                                                                                                                                                            | Git fork/upstream merges; AI-regenerated with no overlay                                | U3         |
| 2  | Audience              | Tool-agnostic plain markdown fetched by URL — friends use mixed AI tools.                                                                                                                                                                                                                                                                                                                                                                                                                                           | A Claude Code plugin/skill                                                              | U3         |
| 3  | Entry point           | `llms.txt` at the repo root in llmstxt.org format (H1, blockquote summary, `## Docs` link list) linking `docs/adopt/guide.md`, `docs/adopt/modules.toml`, `docs/adopt/changelog.md` by raw GitHub URL.                                                                                                                                                                                                                                                                                                              | One long single file                                                                    | U3         |
| 4  | Guide modes           | Three modes: **new** (no repo) — pick modules, collect personal values, generate, write `.config/upstream.toml`; **reconcile** (existing repo, no `.config/upstream.toml`) — compare module by module against upstream HEAD, propose differences, write the record; **sync** — apply changelog entries whose commit is after `last_synced`, filtered to the friend's modules, skipping `declined`. Every mode asks for personal values rather than copying them, and shows a diff before writing.                   | —                                                                                       | U3         |
| 5  | Sync record           | Friend-side `.config/upstream.toml`: `[upstream]` `repo`, `last_synced` (full commit sha of upstream HEAD at sync), `synced_at` (ISO date), `modules` (array of module ids), `declined` (array of commit shas whose entries the friend declined).                                                                                                                                                                                                                                                                   | Date-based pointer                                                                      | U3         |
| 6  | Manifest schema       | `docs/adopt/modules.toml`: top-level `exclude` (globs) and `[[module]]` tables with `id`, `description`, `tier` (`"core"` / `"optional"`), `files` (globs, repo-relative), `depends` (ids), `personal` (array of inline tables `{ file, what, ask }`).                                                                                                                                                                                                                                                              | Per-package granularity                                                                 | U1         |
| 7  | Core set              | Core: `homebrew`, `mise`, `fish`, `fnox`, `code-quality` (dprint/taplo, pre-commit, linter, gitleaks, commit convention), `repo` (setup, repo tasks, link map, repo docs), `identity` (git identity + per-SCM `GITHUB_*`/`GITLAB_*`, required by vwf; at least one SCM). Everything else optional.                                                                                                                                                                                                                  | Promoting git config, ssh + 1Password, macOS defaults to core                           | U1, U3     |
| 8  | claude settings       | `dotfiles/ai-tools/claude/settings.json` is whole-file personal; the guide has the friend's AI build their own, offering the `virajp-plugins` marketplace as opt-in via its GitHub source.                                                                                                                                                                                                                                                                                                                          | Copying it with edits                                                                   | U1, U3     |
| 9  | Changelog format      | `docs/adopt/changelog.md`, newest first; each entry `## <YYYY-MM-DD> — <title>` followed by bullets `- **Modules:** <ids>`, `- **Commit:** <full sha>`, `- **Change:** <what changed>`, `- **Adopter action:** <what a friend's AI should do>`. One baseline entry dated at landing with `Commit: baseline` meaning "the state at the commit that adds this file".                                                                                                                                                  | Commit-log-as-changelog                                                                 | U4, U6     |
| 10 | Drafting engine       | `adopt:changelog` bash task drafts via `claude -p`; only the owner runs it.                                                                                                                                                                                                                                                                                                                                                                                                                                         | Manual only; draft file                                                                 | U6         |
| 11 | Drafting trigger      | Background pre-commit hook `adopt-changelog` at `post-commit` and `post-merge` stages; drafts land uncommitted in `changelog.md`; approving = editing and committing; discarding = `git checkout -- docs/adopt/changelog.md`.                                                                                                                                                                                                                                                                                       | Gitignored draft file; manual only                                                      | U5, U6     |
| 12 | Hook guard            | The task drafts only when the current branch is `main`; it covers every qualifying commit reachable from HEAD after the newest `Commit:` sha in the working-tree `changelog.md` (so uncommitted drafts count and nothing is drafted twice). Qualifying = subject starts `ops:` and touches a file some module's `files` matches. Skips when `ADOPT_SKIP_HOOK=1`, during rebase/merge/cherry-pick, and when there is nothing qualifying. `post-merge` is needed because a fast-forward merge fires no `post-commit`. | Draft on every branch (would dirty the plan run's worktree); linked-worktree guard only | U6         |
| 13 | Check                 | `adopt:check` fails when a tracked file (`git ls-files`) matches neither a module's `files` nor `exclude`, or a module `files` glob / `personal.file` matches nothing. Wired into `code:lint` (runs first) and a local `adopt-check` pre-commit hook.                                                                                                                                                                                                                                                               | Coverage of `dotfiles/` only                                                            | U5         |
| 14 | TOML parser           | Pin `yq` in `.config/mise.toml` `[tools]`; update `.config/mise.lock` with `mise lock`. Tasks read TOML via `yq -p toml -o json`.                                                                                                                                                                                                                                                                                                                                                                                   | taplo only; python tomllib                                                              | U2, U5, U6 |
| 15 | Deliverable ownership | `llms.txt` and `docs/adopt/guide.md` are the plan's deliverables, owned by U3 alone, not by the docs unit.                                                                                                                                                                                                                                                                                                                                                                                                          | Docs unit writes them                                                                   | U3, U8     |
| 16 | Readme prompt         | `readme.md` gains an "Adopt this setup" section with the copy-paste prompt: `Follow https://raw.githubusercontent.com/virajp/macos-setup/main/llms.txt to set up or sync my macOS setup repo in this directory.`                                                                                                                                                                                                                                                                                                    | —                                                                                       | U8         |
| 17 | Review row            | One `review` row (U7) covering U5 and U6 — they land runnable bash tasks.                                                                                                                                                                                                                                                                                                                                                                                                                                           | No review                                                                               | U7         |
| 18 | Dry runs              | No automated dry runs; the owner or a friend tests by hand after landing.                                                                                                                                                                                                                                                                                                                                                                                                                                           | Claude Code / Codex scratch runs                                                        | none       |
| 19 | Model                 | `opus` on every unit.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | —                                                                                       | all        |

## New dependencies

- `yq` — reads `modules.toml` / `changelog.md`-adjacent TOML in the `adopt:*`
  tasks; preferred over `taplo get` (awkward over arrays of tables) and python
  (not pinned in the repo). Already a global tool on the owner's machine. Added
  by U2.

## Units

| Id | Wave | Unit file                                      | Kind   | Owns                                                                                                                                                                                | Depends on                 | Status  | Commit |
| -- | ---- | ---------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ------- | ------ |
| U1 | 1    | [01-manifest.md](01-manifest.md)               | edit   | `docs/adopt/modules.toml`                                                                                                                                                           | —                          | pending |        |
| U2 | 1    | [02-yq-pin.md](02-yq-pin.md)                   | edit   | `.config/mise.toml`, `.config/mise.lock`                                                                                                                                            | —                          | pending |        |
| U3 | 1    | [03-guide.md](03-guide.md)                     | edit   | `docs/adopt/guide.md`, `llms.txt`                                                                                                                                                   | —                          | pending |        |
| U4 | 1    | [04-changelog.md](04-changelog.md)             | edit   | `docs/adopt/changelog.md`                                                                                                                                                           | —                          | pending |        |
| U5 | 2    | [05-check-and-hooks.md](05-check-and-hooks.md) | edit   | `.config/mise/tasks/adopt/check`, `.config/mise/tasks/code/lint`, `.config/pre-commit-config.yaml`                                                                                  | U1, U2                     | pending |        |
| U6 | 2    | [06-changelog-task.md](06-changelog-task.md)   | edit   | `.config/mise/tasks/adopt/changelog`                                                                                                                                                | U1, U2, U4                 | pending |        |
| U7 | 3    | [07-review.md](07-review.md)                   | review | —                                                                                                                                                                                   | U5, U6                     | pending |        |
| U8 | 4    | [08-docs.md](08-docs.md)                       | edit   | `readme.md`, `CLAUDE.md`, `TASKS.md`, `dotfiles/CONFIG_DOCUMENTATION.md`, `dotfiles/readme.md`, `docs/**` except `docs/plans/**` and `docs/adopt/**`, any doc `vwf:docs-sync` names | U1, U2, U3, U4, U5, U6, U7 | pending |        |
| U9 | 5    | [09-gates-and-bump.md](09-gates-and-bump.md)   | edit   | — (no version file, no generator)                                                                                                                                                   | U8                         | pending |        |

## Shared-file rule

| File                                     | Why it collides                                           | Owner   |
| ---------------------------------------- | --------------------------------------------------------- | ------- |
| `.config/pre-commit-config.yaml`         | both new hooks live here                                  | U5 only |
| `.config/mise.toml`, `.config/mise.lock` | tool pin + lockfile                                       | U2 only |
| `docs/adopt/changelog.md`                | U6's task writes it at run time; only U4 edits it in-tree | U4 only |
| `llms.txt`, `docs/adopt/guide.md`        | the deliverables                                          | U3 only |
| every other human-facing doc             | n units editing one doc                                   | U8 only |
| `graphify-out/`                          | post-commit hook output, untracked                        | nobody  |

## Waves

- Wave 1 — U1, U2, U3, U4: four disjoint new/changed files; U3 writes the guide
  against the schemas fixed in decisions 5, 6, 9 rather than reading U1/U4's
  output.
- Wave 2 — U5, U6: disjoint files; both read U1's manifest and U2's `yq`. U5's
  hook entry calls `mise run adopt:changelog`, which U6 creates in the same wave
  — the name is fixed here.
- Wave 3 — U7: review of U5 + U6.
- Wave 4 — U8: docs.
- Wave 5 — U9: final gate.

## Wave gate

```shell
mise run code:format
mise run code:lint
mise x -- pre-commit run --config .config/pre-commit-config.yaml --all-files
```

plus the wave review, plus every report read for `UNRESOLVED:`. Every line here
must be green before wave 1. `adopt:check` joins `code:lint` in U5 and is then
part of the gate from wave 2 on.

The `adopt-changelog` hook must never fire during this run: every commit the run
makes happens on a non-`main` branch in a linked worktree, which decision 12's
guard skips. The orchestrator also exports `ADOPT_SKIP_HOOK=1` for its commits
as a belt-and-braces guard.

## After landing

| Step                                                                                     | Mode | Notes                                                                                                                                                                        |
| ---------------------------------------------------------------------------------------- | ---- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| In the main checkout: `mise install`, `mise run setup:precommit`, `mise run adopt:check` | run  | Installs the pinned `yq`; reinstalls hooks so the `post-merge` type is active; checks the manifest covers the repo. A failure is reported with its output, never auto-fixed. |

## Gates the orchestrator keeps

- Before landing, in the worktree: `mise run adopt:check` exits 0; a scratch
  copy with one untracked-then-added file outside every module makes it exit
  non-zero (then discard the scratch copy).
- After landing, in the main checkout on `main`:
  `mise run adopt:changelog
  --dry-run --since <plan-1 landing sha>` prints
  drafted entries to stdout without writing, in decision 9's format (the task's
  branch guard makes this a no-op inside the run's worktree). If `claude` is
  unavailable, record it and continue.
- After landing:
  `curl -fsS
  https://raw.githubusercontent.com/virajp/macos-setup/main/llms.txt`
  returns the file (only once the owner has pushed).

## Unit contract

Every unit prompt carries, in order: its ruling quoted from this file, its owned
paths plus "touch nothing outside this list", the facts section, the shared-file
rule, and the return block below. A unit never bumps a version, never runs a
generator (except U2's `mise lock`, which this plan names), never edits a doc it
does not own, never adds a dependency this file does not list, never commits. A
unit deletes with plain `rm`, never `git rm` — it stages nothing.

A unit returns exactly this block and nothing else — no file contents, no diff:

    CHANGED: <path> — <one line>            (one per file)
    DECIDED: <what> — <why>                 (choices made inside scope, or none)
    DOCS FALSIFIED: <path> — <passage>      (reported, never edited; or none)
    GAP: <what the plan left unspecified and the assumption taken>   (or none)
    UNRESOLVED: <the ruling needed>         (or none)

A `GAP:` is a hole in the plan the unit could proceed past on a stated
assumption; it is recorded and the run continues. An `UNRESOLVED:` is a ruling
the unit could not proceed without; it blocks the unit and its dependents.

## Out of scope

- Automated AI dry runs (Claude Code / Codex in scratch repos) — the owner chose
  to test by hand.
- A Claude Code plugin/skill form of the guide — friends use mixed AI tools.
- Changing the values plan 1 left in place (starship palette, npm packages,
  repo-meta URLs, App Store list, claude settings.json) — the guide documents
  them instead.
- A GitHub Project backlog for macos-setup — none exists; not created here.

## Parked

- Automated dry runs of the readme prompt with `claude -p` (and optionally
  `codex exec`): (1) empty scratch dir → new mode; (2) scratch copy with
  `.config/upstream.toml` `last_synced` at an older commit → sync mode applies
  only the expected entries.

## Run log

| Wave | Unit | Model | Round | Outcome | Detail | Commit |
| ---- | ---- | ----- | ----- | ------- | ------ | ------ |

## Launch

This folder is already committed and pushed on the branch it was planned on, so
the fresh session's worktree — cut from the integration branch — can see it.

Run in a fresh session, whichever kind the plan is:

/vwf:execute docs/plans/2026-09-27-adoption-mechanism

or let the queue pick it, by priority:

/vwf:execute next
