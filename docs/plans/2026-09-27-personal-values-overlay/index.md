---
type: vwf-change-plan
title: Personal values overlay
requires: []
backlog: []
backlog_pieces: []
---

# Plan — Personal values overlay (2026-09-27)

## Status

**RUNNING**

RUNNING since 2026-09-27 in
/Users/virajpatel/Projects/github.com/virajp/macos-setup/.worktrees/2026-09-27-personal-values-overlay

## Consent

| Action                                                 | Granted |
| ------------------------------------------------------ | ------- |
| Merge to the integration branch and push on green      | no      |
| After landing: link dotfiles and check nothing drifted | run     |
| Release macos-setup publicly                           | none    |

**The mode recorded here is the consent.** A `run` step runs on a green landing
without a prompt; an `ask` step stops the run once before it, reports what it
would do, and waits. The mode is the interview's answer (item 17), and a release
step recorded `run` is authorised by the interview's release question (item 18)
— a release recorded `ask`, or with no step at all, is intent, not
authorisation. Where a step stages something this session already loaded, it is
picked up only by a **restarted** session.

macos-setup has no version file and no release process; "none" is the recorded
release intent, with no bump command.

## Goal

Every personal value that sits inside an otherwise shareable file moves into a
whole-file, tracked identity or module file, so a friend adopting this repo can
copy the shared files untouched and replace only the identity files — while the
owner's machine converges to exactly the state it has today.

This is plan 1 of 2 for the friends' adoption mechanism. The second plan (the
module manifest, adoption guide, changelog, `llms.txt` and `adopt:*` tasks)
requires this one and is written separately. No standing decision is reversed:
the mempalace compose `project_dir` stays a literal `/Users/virajpatel/...`
path, per the 2026-09-13 finding that mise expands neither `~`, `$HOME` nor
templates there — it only moves file.

**Precondition (checked at preflight):** the owner's uncommitted work on main at
planning time — `dotfiles/mise/conf.d/system.toml` (adds
`[bootstrap.macos.launchd.agents.mempalace-hub]`), the mempalace tasks,
`_scripts/helpers`, and `ai-tools/claude/settings.json` — is committed on main
before the run starts. U3 moves the launchd block; a worktree cut without it
would silently drop it. If `git -C <main checkout> status --short` is not empty,
or `dotfiles/mise/conf.d/system.toml` on the integration branch has no
`mempalace-hub` table, stop and ask.

## Facts the survey established

- Personal values inside shared files (the only ones this plan moves):
  - `dotfiles/git/gitconfig:1-4` — `[user]` block: `name = Viraj Patel`,
    `signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPWDmaVfV3kK6TWH8Kd+H4ePlsg8ywwGNRbGPnSICGo`,
    `email = 3125954+virajp@users.noreply.github.com`. Lines 6-15 are commented
    `includeIf` stanzas — leave them.
  - `dotfiles/ssh/config:11` — `User virajp` as the first line of the `Host *`
    block (lines 10-22). Line 8 already has `Include ~/.ssh/config.local` for
    untracked machine-local hosts. `dotfiles/ssh` is linked with
    `mode = "symlink-each"` (`dotfiles/mise.toml`), so any new file in
    `dotfiles/ssh/` lands in `~/.ssh/` on `dotfiles:install` with no link-map
    edit.
  - `dotfiles/mise/config.toml:143-152` — in `[env]`: `# GitHub related`,
    `GITHUB_EMAIL`, `GITHUB_SIGNING_KEY`, `GITHUB_USER_NAME`, blank line,
    `# GitLab related`, `GITLAB_EMAIL`, `GITLAB_SIGNING_KEY`,
    `GITLAB_USER_NAME`. Nothing in the repo reads these six variables; they are
    exported for the user's shell only.
  - `dotfiles/mise/conf.d/system.toml` — `[bootstrap.compose.mempalace]` with
    its comment (literal `project_dir = "/Users/virajpatel/.config/mempalace"`)
    and `[bootstrap.macos.launchd.agents.mempalace-hub]` (see precondition).
  - `dotfiles/mise/conf.d/packages.toml:16` —
    `"virajp/tap" = "https://github.com/virajp/homebrew-tap.git"` under
    `[bootstrap.brew.taps]` (with the comment above it about third-party taps
    needing published API metadata); `:53` —
    `"brew:virajp/tap/claude-status" = "latest" # Claude Code status line`.
  - `dotfiles/fish/conf.d/02-path.fish:31` —
    `set -gx PNPM_HOME '/Users/virajpatel/Library/pnpm'` (a bug; every other
    fish file uses `$HOME`).
  - `docs/account.md:20,38` — example account name `virajpatel` in prose and in
    the visudo line.
- mise loads every non-hidden `~/.config/mise/conf.d/*.toml` in alphabetical
  order and merges them; `[env]`, `[bootstrap.*]` and `[bootstrap.brew.taps]`
  tables merge across files (mise docs, configuration.md; mise 2026.9.14
  installed). Each existing conf.d file starts with the same 3-line header
  comment ("Global mise config, loaded from ~/.config/mise/conf.d/. Machine
  state applied by `mise bootstrap` (from any directory); settings/tools/env
  stay in ../config.toml.").
- Git resolves an `[include] path` starting with `~/` against `$HOME`.
  `~/.gitconfig` is a symlink into this repo, so a relative include path is not
  used.
- Live links point at the **main checkout**, not the run's worktree:
  `~/.config/mise`, `~/.gitconfig`, `~/.ssh/*`, fish conf.d. So nothing a unit
  changes is visible to `mise bootstrap`, git or ssh on this machine until the
  change lands on main and `dotfiles:install` runs — the after-landing step
  holds the machine-level check.
- Gates: `mise run code:format` (dprint check), `mise run code:lint`
  (`@askviraj/linter`), and the pre-commit hooks in
  `.config/pre-commit-config.yaml` (pre-commit-hooks incl. `check-symlinks`,
  `detect-private-key`, trailing whitespace/EOF fixers, dprint, linter,
  gitleaks, conventional commits on commit-msg). `mise run code:precommit`
  swallows failures (`|| true`), so the gate calls pre-commit directly. No CI.
- Commit convention: `.config/git-conventional-commits.yaml` allows `spec`,
  `ops`, `docs`, `merge`; no scopes.
- Docs that describe the touched layout: `CLAUDE.md` Layout section (lists
  `conf.d/` files by name: `packages.toml`, `macos.toml`, `system.toml`),
  `readme.md:6`, `dotfiles/CONFIG_DOCUMENTATION.md` "Machine declaration
  (`mise/conf.d/`)" section (itemises each conf.d file) and its directory table,
  `dotfiles/readme.md` "Adding a dotfile".
- Backlog: no `macos-setup` GitHub Project exists — backlog unreadable (no
  project yet); this plan covers no backlog item.

## Assumed decisions — confirm or override at review

| #  | Decision                     | Ruling                                                                                                                                                                          | Rejected                                                                                                  | Unit     |
| -- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | -------- |
| 1  | Where personal values go     | "Tracked `identity` files": each tool includes a whole-personal, tracked file; a friend's AI replaces those files wholesale, never merges.                                      | Untracked local files — the owner's values would leave the repo and a fresh machine would need re-entry   | U1,U2,U3 |
| 2  | git identity mechanism       | `[user]` block moves to `dotfiles/git/identity`, linked to `~/.config/git/identity`; `gitconfig` gets `[include]` `path = ~/.config/git/identity` at the top.                   | Relative include path — resolution through the `~/.gitconfig` symlink is unclear                          | U1       |
| 3  | ssh identity mechanism       | `User virajp` moves to `dotfiles/ssh/config.identity`; `Host *` gets `Include ~/.ssh/config.identity` as its first line, where `User` was.                                      | Deleting `User` — changes the owner's behaviour                                                           | U2       |
| 4  | mise identity env            | The six `GITHUB_*` / `GITLAB_*` `[env]` entries (with their two comments) move to `dotfiles/mise/conf.d/identity.toml`.                                                         | Leaving them in `config.toml`                                                                             | U3       |
| 5  | mempalace machine state      | `[bootstrap.compose.mempalace]` and `[bootstrap.macos.launchd.agents.mempalace-hub]` move, byte-for-byte with their comments, to `dotfiles/mise/conf.d/mempalace.toml`.         | Templating `project_dir` — mise rejects `~`, `$HOME` and templates there                                  | U3       |
| 6  | Personal tap + claude-status | `"virajp/tap"` (under its own `[bootstrap.brew.taps]`) and `"brew:virajp/tap/claude-status"` (under its own `[bootstrap.packages]`) move to `dotfiles/mise/conf.d/claude.toml`. | `conf.d/identity.toml` — the tap is public and useful to friends who use Claude Code                      | U3       |
| 7  | PNPM_HOME                    | `set -gx PNPM_HOME "$HOME/Library/pnpm"`.                                                                                                                                       | — (bug fix)                                                                                               | U4       |
| 8  | docs/account.md example      | `virajpatel` → `<your-username>` in both places.                                                                                                                                | —                                                                                                         | U5       |
| 9  | claude/settings.json         | Untouched. Plan 2's manifest marks it whole-file personal; a friend's AI builds their own.                                                                                      | Switch marketplaces to GitHub sources (loses the local plugin dev loop); try `~` in `path` (undocumented) | none     |
| 10 | Review row                   | None. The change is config and docs; the only shell edit is a one-line path fix. The wave review and the after-landing drift check are the checks.                              | A `Kind: review` row                                                                                      | none     |
| 11 | Model                        | `opus` on every unit.                                                                                                                                                           | —                                                                                                         | all      |

## New dependencies

none

## Units

| Id | Wave | Unit file                                          | Kind | Owns                                                                                                                                                                                                                   | Depends on     | Status  | Commit  |
| -- | ---- | -------------------------------------------------- | ---- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------- | ------- |
| U1 | 1    | [01-git-identity.md](01-git-identity.md)           | edit | `dotfiles/git/gitconfig`, `dotfiles/git/identity`, `dotfiles/mise.toml`                                                                                                                                                | —              | green   | 99a3cb1 |
| U2 | 1    | [02-ssh-identity.md](02-ssh-identity.md)           | edit | `dotfiles/ssh/config`, `dotfiles/ssh/config.identity`                                                                                                                                                                  | —              | green   | dede874 |
| U3 | 1    | [03-mise-conf-d-split.md](03-mise-conf-d-split.md) | edit | `dotfiles/mise/config.toml`, `dotfiles/mise/conf.d/system.toml`, `dotfiles/mise/conf.d/packages.toml`, `dotfiles/mise/conf.d/identity.toml`, `dotfiles/mise/conf.d/mempalace.toml`, `dotfiles/mise/conf.d/claude.toml` | —              | green   | 0634262 |
| U4 | 1    | [04-fish-pnpm-home.md](04-fish-pnpm-home.md)       | edit | `dotfiles/fish/conf.d/02-path.fish`                                                                                                                                                                                    | —              | green   |         |
| U5 | 2    | [05-docs.md](05-docs.md)                           | edit | `docs/account.md`, `CLAUDE.md`, `readme.md`, `dotfiles/CONFIG_DOCUMENTATION.md`, `dotfiles/readme.md`, `docs/**` except `docs/plans/**`, any doc `vwf:docs-sync` names                                                 | U1, U2, U3, U4 | pending |         |
| U6 | 3    | [06-gates-and-bump.md](06-gates-and-bump.md)       | edit | — (no version file, no generator)                                                                                                                                                                                      | U5             | pending |         |

## Shared-file rule

| File                      | Why it collides                                                            | Owner         |
| ------------------------- | -------------------------------------------------------------------------- | ------------- |
| `dotfiles/mise.toml`      | the link map; only U1 adds a link (U2's file is covered by `symlink-each`) | U1 only       |
| every human-facing doc    | n units editing one doc                                                    | U5 only       |
| `dotfiles/mise/mise.lock` | lockfile; no unit changes `[tools]`, so nothing may touch it               | nobody        |
| `graphify-out/`           | generated by the post-commit hook                                          | nobody (hook) |

## Waves

- Wave 1 — U1, U2, U3, U4: disjoint owned paths (git, ssh, mise conf.d, fish);
  no unit reads another's output.
- Wave 2 — U5: docs reconcile the whole wave-1 delta.
- Wave 3 — U6: final full gate.

## Wave gate

```shell
mise run code:format
mise run code:lint
mise x -- pre-commit run --config .config/pre-commit-config.yaml --all-files
```

plus the wave review, plus every report read for `UNRESOLVED:`. Every line here
must be green before wave 1.

## After landing

| Step                                                                                                                                                                                                                                                                                                                                                                                                              | Mode | Notes                                                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| In the main checkout: `mise run dotfiles:install`, then check — `mise bootstrap status` reports nothing to change; `git config --global user.email` = `3125954+virajp@users.noreply.github.com` and `git config --global user.name` = `Viraj Patel`; `ssh -G github.com \| grep '^user '` = `user virajp`; `mise env \| grep GITHUB_USER_NAME` shows `virajp`; `fish -c 'echo $PNPM_HOME'` = `$HOME/Library/pnpm` | run  | Links `~/.config/git/identity` and `~/.ssh/config.identity`, then read-only checks. A failed check is reported with its output, never auto-fixed. |

## Gates the orchestrator keeps

- The after-landing drift check above — pass: every listed value matches and
  `mise bootstrap status` is clean. A diff cannot prove this because the live
  links point at the main checkout.
- In the worktree, before landing:
  `MISE_CONFIG_DIR=$PWD/dotfiles/mise mise
  config ls` lists
  `conf.d/claude.toml`, `conf.d/identity.toml`, `conf.d/mempalace.toml` without
  a parse error, and
  `MISE_CONFIG_DIR=$PWD/dotfiles/mise mise env | grep GITHUB_USER_NAME` shows
  `virajp`. If `MISE_CONFIG_DIR` is not honoured by mise 2026.9.14, record a
  `GAP:` and rely on the after-landing check.

## Unit contract

Every unit prompt carries, in order: its ruling quoted from this file, its owned
paths plus "touch nothing outside this list", the facts section, the shared-file
rule, and the return block below. A unit never bumps a version, never runs a
generator, never edits a doc, never adds a dependency this file does not list,
never commits. A unit deletes with plain `rm`, never `git rm` — it stages
nothing.

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

- `dotfiles/ai-tools/claude/settings.json` (absolute marketplace paths,
  `virajp-plugins`, `autoMode` block) — Claude Code has no user-scope override
  file and does not document `~` in a directory marketplace `path`; plan 2 marks
  the file whole-file personal instead.
- Starship palette name `viraj_dark` — cosmetic; the owner chose to leave it.
- `@askviraj/linter` and `@virajp.dev/claude-plugins` usages — the owner chose
  to leave them; plan 2 documents them as part of the lint gate / optional
  ai-tools.
- Repo-meta URLs (`.config/git-conventional-commits.yaml`, `docs/setup.md`,
  `setup`'s `GITHUB_USER` default) — correct for this repo; plan 2's guide has a
  friend's AI rewrite them.
- The App Store `mas:` list — public ids, a matter of taste; stays in
  `packages.toml`.
- `dotfiles/ssh/signingkeys/*`, `dotfiles/ssh/allowed_signers` — already
  whole-file personal; nothing to move.

## Parked

- Plan 2, the adoption mechanism: `llms.txt`, `docs/adopt/guide.md` (new repo,
  existing repo without sync record, sync), `docs/adopt/modules.toml`,
  `docs/adopt/changelog.md`, friend-side `.config/upstream.toml`, an
  `adopt:check` task in `code:lint`, an `adopt:changelog` drafting task, the
  readme prompt, and dry runs. Requires this folder.

## Run log

| Wave | Unit      | Model | Round | Outcome | Detail                                                                                                                                                                                                                                                                                                                                                                                                                                             | Commit  |
| ---- | --------- | ----- | ----- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| 0    | preflight | —     | 1     | green   | Wave gate green (format, lint, pre-commit). Format check skipped: no `covers:`. Doctor: mise, graphify CLI, graph pass; repo has no `.config/vwf.yaml` (not onboarded) — noted, not an execute halt; no `code` unit, so LSP/conventions skipped. Worktree via `git worktree add` (`.worktrees/` ignored in 4f7e586); `setup:all` not run (its `mise upgrade` would move a lockfile), `init` + `mise install` only                                  | —       |
| 1    | U4        | opus  | 1     | green   | PNPM_HOME → `"$HOME/Library/pnpm"`; verified `fish -n`, HOME override, no `virajpatel` left. DECIDED: ran pre-commit scoped to its file, not the full gate (concurrent units)                                                                                                                                                                                                                                                                      |         |
| 1    | U2        | opus  | 1     | green   | `User virajp` → `dotfiles/ssh/config.identity`; `Host *` line 11 now `Include ~/.ssh/config.identity`; covered by `symlink-each`. DECIDED: pre-commit scoped to its files (concurrent units)                                                                                                                                                                                                                                                       | dede874 |
| 1    | U1        | opus  | 1     | green   | `[user]` → `dotfiles/git/identity`; gitconfig `[include] path = ~/.config/git/identity`; link added to `dotfiles/mise.toml` (3 neighbours re-aligned by taplo). DOCS FALSIFIED: `dotfiles/CONFIG_DOCUMENTATION.md:152-155` Git section (→ U5). GAP: `~/.config/git/` absent; assumes `dotfiles:install` creates the parent dir — after-landing step confirms                                                                                       | 99a3cb1 |
| 1    | U3        | opus  | 1     | green   | identity/mempalace/claude conf.d files created byte-copied; entries removed from `config.toml`, `system.toml`, `packages.toml` (brew keys re-aligned by taplo); `MISE_CONFIG_DIR` honoured, key/value union = HEAD (315=315). DOCS FALSIFIED: `CLAUDE.md:14-20`, `dotfiles/CONFIG_DOCUMENTATION.md:141-142,174-216` (→ U5). GAP: taplo config unspecified, used `.config/taplo.toml`; a transient gate failure from concurrent edits, re-run green | 0634262 |
| 1    | R1        | opus  | 1     | pass    | FINDINGS 0; CONTRACT clean; RULINGS clean                                                                                                                                                                                                                                                                                                                                                                                                          |         |

## Launch

This folder is already committed and pushed on the branch it was planned on, so
the fresh session's worktree — cut from the integration branch — can see it.

Run in a fresh session, whichever kind the plan is:

/vwf:execute docs/plans/2026-09-27-personal-values-overlay

or let the queue pick it, by priority:

/vwf:execute next
