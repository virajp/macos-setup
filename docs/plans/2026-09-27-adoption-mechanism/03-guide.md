# U3 — Adoption guide and llms.txt

- **Wave:** 1
- **Depends on:** —
- **Owns:** `docs/adopt/guide.md`, `llms.txt`
- **Model:** opus
- **Kind:** edit
- **Read first:** `readme.md`, `CLAUDE.md`, `dotfiles/CONFIG_DOCUMENTATION.md`,
  `dotfiles/mise.toml`, `setup`, `dotfiles/mise/conf.d/*.toml`, this plan's
  index.md (Facts and decisions).
- **Lazy-load:** `docs/setup.md`, `.config/pre-commit-config.yaml`,
  `dotfiles/ai-tools/claude/settings.json` (shape only — never quote it).

## Ruling

> 1 — Hybrid: friends' repos are independent and AI-synced from guide +
> changelog; personal values already isolated by plan 1.
>
> 2 — Tool-agnostic plain markdown fetched by URL — friends use mixed AI tools.
>
> 3 — `llms.txt` at the repo root in llmstxt.org format (H1, blockquote summary,
> `## Docs` link list) linking `docs/adopt/guide.md`, `docs/adopt/modules.toml`,
> `docs/adopt/changelog.md` by raw GitHub URL.
>
> 4 — Three modes: **new** (no repo) — pick modules, collect personal values,
> generate, write `.config/upstream.toml`; **reconcile** (existing repo, no
> `.config/upstream.toml`) — compare module by module against upstream HEAD,
> propose differences, write the record; **sync** — apply changelog entries
> whose commit is after `last_synced`, filtered to the friend's modules,
> skipping `declined`. Every mode asks for personal values rather than copying
> them, and shows a diff before writing.
>
> 5 — Friend-side `.config/upstream.toml`: `[upstream]` `repo`, `last_synced`
> (full commit sha of upstream HEAD at sync), `synced_at` (ISO date), `modules`
> (array of module ids), `declined` (array of commit shas whose entries the
> friend declined).
>
> 7 — Core: `homebrew`, `mise`, `fish`, `fnox`, `code-quality`, `repo`,
> `identity` (git identity + per-SCM `GITHUB_*`/`GITLAB_*`, required by vwf; at
> least one SCM). Everything else optional.
>
> 8 — `dotfiles/ai-tools/claude/settings.json` is whole-file personal; the guide
> has the friend's AI build their own, offering the `virajp-plugins` marketplace
> as opt-in via its GitHub source.
>
> 9 — Changelog entries: `## <YYYY-MM-DD> — <title>` then `**Modules:**`,
> `**Commit:**` (full sha, or `baseline`), `**Change:**`, `**Adopter action:**`.
>
> 15 — `llms.txt` and `docs/adopt/guide.md` are the plan's deliverables, owned
> by U3 alone.

## Edits

1. **`llms.txt`** (new, repo root) — llmstxt.org shape:
   - `# macOS setup (virajp/macos-setup)`
   - a `>` blockquote: a personal macOS provisioning repo driven by
     `mise bootstrap`; an AI agent reading this file can set up, reconcile or
     sync a friend's own copy by following the guide.
   - one short paragraph: start with the guide; never copy personal values;
     always show a diff before writing.
   - `## Docs` — three links by raw URL
     (`https://raw.githubusercontent.com/virajp/macos-setup/main/…`), each with
     a one-line description: the guide, the module manifest, the changelog.
   - `## Optional` — links to `readme.md` and `dotfiles/CONFIG_DOCUMENTATION.md`
     (raw URLs).
2. **`docs/adopt/guide.md`** (new) — written **to the friend's AI agent**, in
   the imperative. Sections, in order:
   1. **What this repo is** — how it is built: `setup` → Homebrew → mise →
      `mise bootstrap`; `dotfiles/<pkg>/` sources linked into `$HOME` by the
      `[dotfiles]` map in `dotfiles/mise.toml` (`mise run dotfiles:install`);
      the global mise config in `dotfiles/mise/` (`config.toml`, `conf.d/*.toml`
      loaded alphabetically and merged, `tasks/`); repo tasks in
      `.config/mise/tasks/`; casks + VS Code extensions in the brewfile; secrets
      via fnox + Keychain; conventions (commit types, dprint/taplo, pre-commit).
      Point at `CONFIG_DOCUMENTATION.md` for detail rather than restating it.
   2. **Hard rules** — never copy a value listed under any module's `personal`;
      ask the friend for each instead. Never write without showing the diff and
      getting a yes. Never delete a friend's file that no module lists — it is
      theirs. Treat the literal mempalace `project_dir` and the claude
      `settings.json` as the manifest says.
   3. **Pick the mode** — read the friend's working directory: no repo →
      **new**; a repo with no `.config/upstream.toml` → **reconcile**; a repo
      with one → **sync**.
   4. **Modules** — how to read `modules.toml`: tiers, `depends` (choosing a
      module pulls its dependencies), `personal` (what to ask), `exclude` (never
      copy those). Core modules are required; ask per optional module. State
      that `identity` needs `GITHUB_*` and/or `GITLAB_*` for each SCM the friend
      uses (at least one) because the owner's vwf plugin reads them.
   5. **Mode: new** — steps: confirm prerequisites (macOS, Apple Silicon,
      Homebrew/mise installed by `setup`); ask optional modules; fetch the files
      of the chosen modules at upstream HEAD; collect each personal value; write
      identity files; adapt `setup`, `docs/setup.md`,
      `.config/git-conventional-commits.yaml` URLs and `GITHUB_USER` to the
      friend's repo; walk the `mas:` list keep/drop; for `claude`, build a fresh
      `settings.json` from the friend's needs and ask whether to add the
      `virajp-plugins` marketplace (GitHub source `virajp/claude-plugins`);
      remove link-map entries and conf.d files for modules not chosen; write
      `.config/upstream.toml`; tell the friend to run `./setup` and
      `mise run dotfiles:install`.
   6. **Mode: reconcile** — for each module: compare the friend's files with
      upstream HEAD; classify differences as (a) upstream design change to
      adopt, (b) friend's own customisation to keep, (c) personal value — never
      touch; propose (a) item by item; ask which optional modules the friend
      already has; write `.config/upstream.toml` with `last_synced` = the
      upstream HEAD sha compared against.
   7. **Mode: sync** — read `.config/upstream.toml`; read the changelog; take
      entries whose `Commit` is newer than `last_synced` (by upstream history —
      `git merge-base --is-ancestor` against a fetched upstream, or by entry
      order when only the raw file is available), whose `Modules` intersect the
      friend's `modules` (or name a module the friend might want — offer it),
      and whose `Commit` is not in `declined`; apply each entry's *Adopter
      action* with a diff and a yes; record declines; when the changelog is
      thin, compare upstream files for the friend's modules between
      `last_synced` and HEAD; update `last_synced` and `synced_at`.
   8. **`.config/upstream.toml`** — the schema from decision 5, with an example
      (placeholder values only).
   9. **Changelog format** — decision 9's shape, and that `Commit: baseline` is
      the starting point for anyone whose record predates it.
   10. **Things that are the owner's but shareable** — `@askviraj/linter` (the
       lint gate: keep it, or replace `code:lint` and the `linter` hook with the
       friend's linter), `@virajp.dev/claude-plugins` in `upgrade:ai` (only with
       the `claude` module), `virajp/tap` + `claude-status` (public tap),
       starship palette `viraj_dark` (rename freely), `.config/statusline.json`.
   11. **The prompt** — the one-line prompt from decision 16, so a friend can
       re-run it.

## Verification

- `llms.txt` starts with a single `#` H1 followed by a `>` blockquote, and has a
  `## Docs` section with exactly the three raw URLs.
- `grep -n 'virajpatel\|3125954\|AAAAC3Nza' docs/adopt/guide.md llms.txt`
  returns nothing (no personal values quoted).
- Every mode names `.config/upstream.toml` and every field of decision 5.
- The wave gate lines pass (dprint formats markdown).

## Guardrails

- Only the two owned files. Do not add a readme section — U8 owns `readme.md`.
- Do not describe task internals that U5/U6 have not written yet beyond their
  names (`adopt:check`, `adopt:changelog`) and decisions 12–13.

## Commit

`docs: add the adoption guide and llms.txt`
