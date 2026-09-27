# U1 — git identity include

- **Wave:** 1
- **Depends on:** —
- **Owns:** `dotfiles/git/gitconfig`, `dotfiles/git/identity`,
  `dotfiles/mise.toml`
- **Model:** opus
- **Kind:** edit
- **Read first:** every owned file, top to bottom, before editing.
- **Lazy-load:** `dotfiles/CONFIG_DOCUMENTATION.md` (git section, read only)

## Ruling

> 1 — "Tracked `identity` files": each tool includes a whole-personal, tracked
> file; a friend's AI replaces those files wholesale, never merges.
>
> 2 — `[user]` block moves to `dotfiles/git/identity`, linked to
> `~/.config/git/identity`; `gitconfig` gets `[include]`
> `path = ~/.config/git/identity` at the top. Rejected: relative include path —
> resolution through the `~/.gitconfig` symlink is unclear.

## Edits

1. **`dotfiles/git/identity`** (new) — a git config file holding exactly the
   current `[user]` block from `gitconfig:1-4`, values byte-copied (name,
   signingkey, email; keep the key order). Precede it with a two-line comment:
   this file is the personal git identity, included from `gitconfig`; an adopter
   replaces it wholesale. Use tab indentation for the keys (the file's dominant
   style).
2. **`dotfiles/git/gitconfig`** — delete the `[user]` block (lines 1-4). In its
   place, at the top of the file, write:

   ```ini
   # Personal identity (name, email, signing key) lives in git/identity,
   # linked to ~/.config/git/identity.
   [include]
   	path = ~/.config/git/identity
   ```

   Leave the commented `includeIf` stanzas and everything below untouched.
3. **`dotfiles/mise.toml`** — under the `# Git & SSH` group, add
   `"~/.config/git/identity" = { mode = "symlink", source = "git/identity" }`,
   aligned with the neighbouring entries (taplo aligns `=`).

## Verification

- `git config --file dotfiles/git/identity --get user.email` prints
  `3125954+virajp@users.noreply.github.com`; `--get user.name` prints
  `Viraj Patel`; `--get user.signingkey` prints the same key as before.
- `git config --file dotfiles/git/gitconfig --get include.path` prints
  `~/.config/git/identity`;
  `git config --file dotfiles/git/gitconfig --get
  user.email` prints nothing.
- `mise x -- taplo check dotfiles/mise.toml` passes.
- The wave gate lines pass.

## Guardrails

- Do not touch `dotfiles/ssh/*` (U2) or `dotfiles/mise/*` (U3).
- Do not run `mise run dotfiles:install` — the live links point at the main
  checkout, not this worktree.
- Do not edit any doc; report falsified passages as `DOCS FALSIFIED:`.
- Delete with `rm`, never `git rm`.

## Commit

`ops: move git identity into an included identity file`
