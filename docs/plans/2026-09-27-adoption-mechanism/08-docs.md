# U8 — Docs

- **Wave:** 4
- **Depends on:** U1, U2, U3, U4, U5, U6, U7
- **Owns:** `readme.md`, `CLAUDE.md`, `TASKS.md`,
  `dotfiles/CONFIG_DOCUMENTATION.md`, `dotfiles/readme.md`, `docs/**` except
  `docs/plans/**` and `docs/adopt/**`, and any doc `vwf:docs-sync` names
- **Model:** opus
- **Kind:** edit
- **Read first:** the run's branch delta (`git diff <base>..HEAD --stat`), then
  each doc before editing it.

## Ruling

> 16 — `readme.md` gains an "Adopt this setup" section with the copy-paste
> prompt:
> `Follow https://raw.githubusercontent.com/virajp/macos-setup/main/llms.txt
> to set up or sync my macOS setup repo in this directory.`
>
> 15 — `llms.txt` and `docs/adopt/guide.md` are the plan's deliverables, owned
> by U3 alone, not by the docs unit.

## Edits

1. Run `vwf:docs-sync` over the branch delta; apply its findings, except in
   `llms.txt` and `docs/adopt/**` — report those as a note in the return block
   instead.
2. Apply every `DOCS FALSIFIED:` line from U1–U6.
3. **`readme.md`** — a new `## Adopt this setup` section after the intro: one
   sentence for friends (paste this into your AI tool, in an empty directory for
   a new repo or in your existing repo to sync), the prompt in a `text` code
   block, and a link to `docs/adopt/guide.md`.
4. **`CLAUDE.md`** — Layout: add `llms.txt` + `docs/adopt/` (guide, manifest,
   changelog) and the `adopt:*` repo tasks; Conventions: new tracked files need
   a module in `docs/adopt/modules.toml` (`adopt:check` enforces it); adoption
   changelog drafts appear uncommitted after `ops:` commits on main — review and
   commit them.
5. **`TASKS.md`** — sections for `adopt:check` and `adopt:changelog` mirroring
   their `#MISE description` and `#USAGE` flags, in the file's existing shape.
6. **`dotfiles/CONFIG_DOCUMENTATION.md`**, **`dotfiles/readme.md`** — only if
   docs-sync finds a passage (e.g. "Adding a dotfile" gains "add it to a
   module").

## Verification

- `grep -n 'llms.txt' readme.md` hits the new section.
- `grep -n 'adopt:check\|adopt:changelog' TASKS.md CLAUDE.md` hits both files.
- The wave gate lines pass.

## Guardrails

- Never edit `llms.txt`, `docs/adopt/**`, or `docs/plans/**`.
- Docs only; no config or task file.

## Commit

`docs: document the adoption mechanism and the readme prompt`
