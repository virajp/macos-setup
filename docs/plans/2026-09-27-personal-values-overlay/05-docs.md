# U5 — Docs

- **Wave:** 2
- **Depends on:** U1, U2, U3, U4
- **Owns:** `docs/account.md`, `CLAUDE.md`, `readme.md`,
  `dotfiles/CONFIG_DOCUMENTATION.md`, `dotfiles/readme.md`, `docs/**` except
  `docs/plans/**`, and any doc `vwf:docs-sync` names
- **Model:** opus
- **Kind:** edit
- **Read first:** the run's branch delta (`git diff <base>..HEAD --stat`), then
  each doc before editing it.

## Ruling

> 8 — `virajpatel` → `<your-username>` in both places in `docs/account.md`.
>
> The docs unit runs `vwf:docs-sync` over the run's branch delta and applies its
> findings plus every `DOCS FALSIFIED:` line the earlier units returned.

## Edits

1. Run `vwf:docs-sync` over the branch delta; apply its findings.
2. Apply every `DOCS FALSIFIED:` line from U1–U4.
3. **`docs/account.md:20,38`** — `virajpatel` → `<your-username>` in the prose
   and in the visudo line.
4. Known passages the delta falsifies (apply even if docs-sync misses them):
   - `CLAUDE.md` Layout — the `conf.d/*.toml` list gains `identity.toml`
     (personal `[env]` identity), `mempalace.toml` (qdrant compose + hub launchd
     agent), `claude.toml` (the `virajp/tap` tap + claude-status); `system.toml`
     no longer holds `[bootstrap.compose]`. Add one line naming the identity
     files convention: personal values live only in `git/identity`,
     `ssh/config.identity`, `mise/conf.d/identity.toml` (plus the
     already-personal `ssh/signingkeys/`, `ssh/allowed_signers`).
   - `dotfiles/CONFIG_DOCUMENTATION.md` — the "Machine declaration
     (`mise/conf.d/`)" section itemises the three new files; the git and ssh
     sections mention the identity includes; the `virajp/tap` example points at
     `claude.toml`.
   - `readme.md:6` — only if it names conf.d files.

## Verification

- `grep -rn 'virajpatel' docs/account.md` returns nothing.
- `grep -n 'identity.toml\|mempalace.toml\|claude.toml' CLAUDE.md
  dotfiles/CONFIG_DOCUMENTATION.md`
  hits in both.
- The wave gate lines pass.

## Guardrails

- Docs only; no config file.
- Do not add passages about the adoption mechanism — plan 2 owns those.

## Commit

`docs: document identity files and the new conf.d modules`
