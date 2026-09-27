# U4 — Adoption changelog with a baseline entry

- **Wave:** 1
- **Depends on:** —
- **Owns:** `docs/adopt/changelog.md`
- **Model:** opus
- **Kind:** edit
- **Read first:** this plan's index.md (Facts), and plan 1's folder
  `docs/plans/2026-09-27-personal-values-overlay/index.md` (Goal and decisions).

## Ruling

> 9 — `docs/adopt/changelog.md`, newest first; each entry
> `## <YYYY-MM-DD> — <title>` followed by bullets `- **Modules:** <ids>`,
> `- **Commit:** <full sha>`, `- **Change:** <what changed>`,
> `- **Adopter action:** <what a friend's AI should do>`. One baseline entry
> dated at landing with `Commit: baseline` meaning "the state at the commit that
> adds this file".

## Edits

1. **`docs/adopt/changelog.md`** (new):
   - `# Adoption changelog` and a short paragraph: what belongs here (changes a
     friend's repo should consider), newest first, the entry shape above, that
     `adopt:changelog` drafts entries automatically after `ops:` commits on main
     and the owner reviews them before committing.
   - One entry,
     `## 2026-09-27 — Baseline: identity files and module
     manifest`:
     - **Modules:** `identity`, `git`, `ssh`, `mise`, `mempalace`, `claude`,
       `fish`, `repo`
     - **Commit:** `baseline`
     - **Change:** personal values moved into identity files
       (`dotfiles/git/identity`, `dotfiles/ssh/config.identity`,
       `dotfiles/mise/conf.d/identity.toml`); mempalace and claude machine state
       moved to their own conf.d files; `PNPM_HOME` derives from `$HOME`; the
       adoption guide, manifest and changelog added.
     - **Adopter action:** run the guide's *reconcile* mode — it compares module
       by module and writes `.config/upstream.toml`.

## Verification

- The file parses as markdown with exactly one `##` entry whose four bullets
  appear in the ruling's order.
- `grep -c '^- \*\*Commit:\*\*' docs/adopt/changelog.md` is `1`.
- The wave gate lines pass.

## Guardrails

- Only the owned file. Never quote a personal value.

## Commit

`docs: add the adoption changelog with a baseline entry`
