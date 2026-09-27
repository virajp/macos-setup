# U2 — ssh identity include

- **Wave:** 1
- **Depends on:** —
- **Owns:** `dotfiles/ssh/config`, `dotfiles/ssh/config.identity`
- **Model:** opus
- **Kind:** edit
- **Read first:** every owned file, top to bottom, before editing.
- **Lazy-load:** `dotfiles/mise.toml` (read only — confirm `~/.ssh` is
  `mode = "symlink-each"`)

## Ruling

> 1 — "Tracked `identity` files": each tool includes a whole-personal, tracked
> file; a friend's AI replaces those files wholesale, never merges.
>
> 3 — `User virajp` moves to `dotfiles/ssh/config.identity`; `Host *` gets
> `Include ~/.ssh/config.identity` as its first line, where `User` was.
> Rejected: deleting `User` — changes the owner's behaviour.

## Edits

1. **`dotfiles/ssh/config.identity`** (new) — a two-line comment (personal ssh
   defaults, included inside `Host *` from `config`; an adopter replaces it
   wholesale), then the single line `User virajp`. No `Host` line — it is read
   in the context of the including `Host *` block.
2. **`dotfiles/ssh/config`** — replace line 11 (`User virajp`) with
   `Include ~/.ssh/config.identity`, same two-space indent. Nothing else
   changes.

No link-map edit: `~/.ssh` is `symlink-each`, so the new file is linked on the
next `dotfiles:install`.

## Verification

- Static checks only — `ssh -G` would resolve the Include against the live
  `~/.ssh/config.identity`, which exists only after landing:
  `grep -n 'Include ~/.ssh/config.identity' dotfiles/ssh/config` hits inside the
  `Host *` block; `grep -c 'User virajp' dotfiles/ssh/config` is `0`;
  `dotfiles/ssh/config.identity` has exactly one non-comment line,
  `User virajp`.
- The wave gate lines pass (`check-symlinks`, `detect-private-key` included).

## Guardrails

- Do not touch `dotfiles/ssh/signingkeys/*` or `dotfiles/ssh/allowed_signers`.
- Do not touch `dotfiles/mise.toml` (U1 owns it).
- Do not edit any doc; report falsified passages as `DOCS FALSIFIED:`.
- Delete with `rm`, never `git rm`.

## Commit

`ops: move ssh default user into an included identity file`
