# U1 — Module manifest

- **Wave:** 1
- **Depends on:** —
- **Owns:** `docs/adopt/modules.toml`
- **Model:** opus
- **Kind:** edit
- **Read first:** `git ls-files` (the full tracked list), `dotfiles/mise.toml`
  (link map), `dotfiles/mise/conf.d/*.toml`, `dotfiles/homebrew/brewfile`.
- **Lazy-load:** any tracked file whose module is unclear from its path.

## Ruling

> 6 — `docs/adopt/modules.toml`: top-level `exclude` (globs) and `[[module]]`
> tables with `id`, `description`, `tier` (`"core"` / `"optional"`), `files`
> (globs, repo-relative), `depends` (ids), `personal` (array of inline tables
> `{ file, what, ask }`).
>
> 7 — Core: `homebrew`, `mise`, `fish`, `fnox`, `code-quality` (dprint/taplo,
> pre-commit, linter, gitleaks, commit convention), `repo` (setup, repo tasks,
> link map, repo docs), `identity` (git identity + per-SCM
> `GITHUB_*`/`GITLAB_*`, required by vwf; at least one SCM). Everything else
> optional.
>
> 8 — `dotfiles/ai-tools/claude/settings.json` is whole-file personal; the guide
> has the friend's AI build their own, offering the `virajp-plugins` marketplace
> as opt-in via its GitHub source.
>
> 13 — `adopt:check` fails when a tracked file matches neither a module's
> `files` nor `exclude`, or a module `files` glob / `personal.file` matches
> nothing.

## Edits

1. **`docs/adopt/modules.toml`** (new). A header comment: what the file is, that
   `adopt:check` enforces coverage, that globs are repo-relative and use `**`
   for any depth (no brace expansion), and the meaning of each field. Then:
   - `exclude = [...]` — at least `docs/plans/**`, `docs/adopt/**`, `llms.txt`,
     `LICENSE`, `TASKS.md`, `docs/backlog.md`, `.vscode/**`, `.claude/**`,
     `.config/statusline.json`.
   - One `[[module]]` per module. Starting map — adjust only where a tracked
     file clearly fits better, and report each adjustment as `DECIDED:`. Expand
     the indicative sets into plain globs (one entry per path or directory; no
     `{a,b}` braces):

     | id             | tier     | files (indicative)                                                                                                                                                                                                                                                                                                                                                                                                                                        | depends            |
     | -------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
     | `repo`         | core     | `setup`, `readme.md`, `CLAUDE.md`, `.gitignore`, `.config/mise.toml`, `.config/mise.lock`, `.config/mise/tasks/_scripts/**`, `.config/mise/tasks/dotfiles/**`, `.config/mise/tasks/setup/**`, `.config/mise/tasks/system/**`, `.config/mise/tasks/adopt/**`, `dotfiles/mise.toml`, `dotfiles/readme.md`, `dotfiles/CONFIG_DOCUMENTATION.md`, `docs/setup.md`, `docs/account.md`, `docs/host.md`, `docs/touchid-sudo.md`, `docs/tools.md`, `docs/shell.md` | `homebrew`, `mise` |
     | `homebrew`     | core     | `dotfiles/homebrew/brewfile`, `dotfiles/mise/tasks/brew/**`, `dotfiles/mise/tasks/upgrade/brew`                                                                                                                                                                                                                                                                                                                                                           | —                  |
     | `mise`         | core     | `dotfiles/mise/config.toml`, `dotfiles/mise/mise.lock`, `dotfiles/mise/conf.d/packages.toml`, `dotfiles/mise/conf.d/macos.toml`, `dotfiles/mise/conf.d/system.toml`, `dotfiles/mise/tasks/_scripts/**`, `dotfiles/mise/tasks/updateall`, `dotfiles/mise/tasks/macos/**`, `dotfiles/mise/tasks/upgrade/macos/**`, `dotfiles/mise/tasks/upgrade/npm`, `dotfiles/mise/tasks/upgrade/pnpm`                                                                    | `homebrew`         |
     | `fish`         | core     | `dotfiles/fish/**`                                                                                                                                                                                                                                                                                                                                                                                                                                        | `mise`             |
     | `fnox`         | core     | `dotfiles/fnox/**`                                                                                                                                                                                                                                                                                                                                                                                                                                        | `mise`             |
     | `code-quality` | core     | `dprint.json`, `dotfiles/dprint/**`, `.config/taplo.toml`, `.config/pre-commit-config.yaml`, `.config/linter.yaml`, `.config/gitleaks.toml`, `.config/git-conventional-commits.yaml`, `eslint.config.mjs`, `.config/mise/tasks/code/**`                                                                                                                                                                                                                   | `mise`             |
     | `identity`     | core     | `dotfiles/git/identity`, `dotfiles/ssh/config.identity`, `dotfiles/mise/conf.d/identity.toml`, `dotfiles/ssh/signingkeys/**`, `dotfiles/ssh/allowed_signers`                                                                                                                                                                                                                                                                                              | `mise`             |
     | `git`          | optional | `dotfiles/git/gitconfig`, `dotfiles/git/gitignore_global`, `dotfiles/github/**`                                                                                                                                                                                                                                                                                                                                                                           | `identity`         |
     | `ssh`          | optional | `dotfiles/ssh/config`                                                                                                                                                                                                                                                                                                                                                                                                                                     | `identity`         |
     | `1password`    | optional | `dotfiles/1Password/**`                                                                                                                                                                                                                                                                                                                                                                                                                                   | —                  |
     | `zsh`          | optional | `dotfiles/zsh/**`                                                                                                                                                                                                                                                                                                                                                                                                                                         | —                  |
     | `starship`     | optional | `dotfiles/starship/**`                                                                                                                                                                                                                                                                                                                                                                                                                                    | —                  |
     | `oh-my-posh`   | optional | `dotfiles/oh-my-posh/**`                                                                                                                                                                                                                                                                                                                                                                                                                                  | —                  |
     | `ghostty`      | optional | `dotfiles/ghostty/**`                                                                                                                                                                                                                                                                                                                                                                                                                                     | —                  |
     | `claude`       | optional | `dotfiles/ai-tools/claude/**`, `dotfiles/mise/conf.d/claude.toml`, `dotfiles/mise/tasks/upgrade/ai`, `dotfiles/mise/tasks/func/claude`, `docs/ai-tools/**`                                                                                                                                                                                                                                                                                                | `mise`             |
     | `copilot`      | optional | `dotfiles/ai-tools/copilot/**`                                                                                                                                                                                                                                                                                                                                                                                                                            | —                  |
     | `mempalace`    | optional | `dotfiles/mempalace/**`, `dotfiles/mise/conf.d/mempalace.toml`, `dotfiles/mise/tasks/mempalace/**`, `docs/mempalace.md`                                                                                                                                                                                                                                                                                                                                   | `mise`             |
     | `tailscale`    | optional | `dotfiles/mise/tasks/tailscale/**`, `dotfiles/mise/tasks/upgrade/tailscale`                                                                                                                                                                                                                                                                                                                                                                               | `mise`             |
     | `node-tooling` | optional | `dotfiles/pnpm/**`, `dotfiles/gem/**`                                                                                                                                                                                                                                                                                                                                                                                                                     | `mise`             |
     | `utilities`    | optional | `dotfiles/mise/tasks/ips/**`, `dotfiles/mise/tasks/func/backup`, `dotfiles/mise/tasks/func/code`, `dotfiles/mise/tasks/func/listStartupItems`, `dotfiles/mise/tasks/func/myps`, `dotfiles/mise/tasks/func/zip`, `dotfiles/mise/tasks/cleanupDS`, `dotfiles/mise/tasks/cleanupTelegram`                                                                                                                                                                    | `mise`             |

   - `personal` entries, at least:
     - `identity`: `dotfiles/git/identity` (name, email, signing key — ask);
       `dotfiles/ssh/config.identity` (default ssh `User` — ask);
       `dotfiles/mise/conf.d/identity.toml` (`GITHUB_*` / `GITLAB_*` for each
       SCM the friend uses, at least one; required by the vwf plugin — ask);
       `dotfiles/ssh/signingkeys/**` and `dotfiles/ssh/allowed_signers`
       (generate from the friend's own key — ask).
     - `mempalace`: `dotfiles/mise/conf.d/mempalace.toml` (`project_dir` is a
       literal `/Users/<username>/.config/mempalace` — substitute the friend's
       username; mise cannot template it).
     - `claude`: `dotfiles/ai-tools/claude/settings.json` (whole file — build
       the friend's own; the `virajp-plugins` marketplace is opt-in).
     - `repo`: `setup` (`GITHUB_USER` default), `docs/setup.md` (one-liner URL),
       `docs/account.md` (`<your-username>` placeholder).
     - `code-quality`: `.config/git-conventional-commits.yaml` (commit/issue
       URLs → the friend's repo).
     - `mise`: `dotfiles/mise/conf.d/packages.toml` (the `mas:` App Store list —
       keep or drop per app).
   - Every tracked file falls under exactly one module or `exclude`.
     `dotfiles/mise/tasks/_scripts/**` belongs to `mise`; the repo-level
     `.config/mise/tasks/_scripts/**` to `repo`.

## Verification

- `mise x -- taplo check docs/adopt/modules.toml` passes.
- Coverage by hand (U5's task does not exist yet): every line of `git ls-files`
  matches exactly one module glob or `exclude`; every module glob matches at
  least one tracked file, except `.config/mise/tasks/adopt/**` and
  `docs/adopt/**` / `llms.txt` (created in this run — report as `DECIDED:`).
  Plan 1's files (`dotfiles/git/identity`, `dotfiles/ssh/config.identity`,
  `dotfiles/mise/conf.d/{identity,mempalace,claude}.toml`) must already exist —
  if not, return `UNRESOLVED:` (plan 1 has not landed).
- The wave gate lines pass.

## Guardrails

- Do not create or edit any other file.
- Never quote a personal value in `modules.toml` — describe it (`what`).

## Commit

`ops: add the adoption module manifest`
