# U3 — mise conf.d split: identity, mempalace, claude

- **Wave:** 1
- **Depends on:** —
- **Owns:** `dotfiles/mise/config.toml`, `dotfiles/mise/conf.d/system.toml`,
  `dotfiles/mise/conf.d/packages.toml`, `dotfiles/mise/conf.d/identity.toml`,
  `dotfiles/mise/conf.d/mempalace.toml`, `dotfiles/mise/conf.d/claude.toml`
- **Model:** opus
- **Kind:** edit
- **Read first:** every owned file, top to bottom, before editing.
- **Lazy-load:** `dotfiles/mise/conf.d/macos.toml` (read only — header style)

## Ruling

> 1 — "Tracked `identity` files": each tool includes a whole-personal, tracked
> file; a friend's AI replaces those files wholesale, never merges.
>
> 4 — The six `GITHUB_*` / `GITLAB_*` `[env]` entries (with their two comments)
> move to `dotfiles/mise/conf.d/identity.toml`. Rejected: leaving them in
> `config.toml`.
>
> 5 — `[bootstrap.compose.mempalace]` and
> `[bootstrap.macos.launchd.agents.mempalace-hub]` move, byte-for-byte with
> their comments, to `dotfiles/mise/conf.d/mempalace.toml`. Rejected: templating
> `project_dir` — mise rejects `~`, `$HOME` and templates there.
>
> 6 — `"virajp/tap"` (under its own `[bootstrap.brew.taps]`) and
> `"brew:virajp/tap/claude-status"` (under its own `[bootstrap.packages]`) move
> to `dotfiles/mise/conf.d/claude.toml`. Rejected: `conf.d/identity.toml` — the
> tap is public and useful to friends who use Claude Code.

## Edits

Every new conf.d file opens with the same 3-line header the existing conf.d
files use, followed by one comment line saying what the file holds and that it
is an optional module (mempalace, claude) or the personal identity (identity).

1. **`dotfiles/mise/conf.d/identity.toml`** (new) — header; a comment that this
   is the owner's personal identity, the one conf.d file an adopter replaces
   wholesale, and that it is an exception to the header's "env stays in
   ../config.toml"; then `[env]` with the six entries and their two comments
   (`# GitHub related`, `# GitLab related`) byte-copied from
   `config.toml:144-152`.
2. **`dotfiles/mise/config.toml`** — remove those lines (the two comments, six
   entries and the blank line between the groups) from `[env]`. The next entry
   (`# GCP related`) follows the `[env]` header directly. Touch nothing else.
3. **`dotfiles/mise/conf.d/mempalace.toml`** (new) — header; then the
   `[bootstrap.compose.mempalace]` table with its preceding comment block and
   the `[bootstrap.macos.launchd.agents.mempalace-hub]` table, byte-copied from
   `system.toml`.
4. **`dotfiles/mise/conf.d/system.toml`** — remove both tables and the compose
   comment block. Touch Id (`[bootstrap.files]`), `[bootstrap.user]` and
   `[dotfiles]` stay.
5. **`dotfiles/mise/conf.d/claude.toml`** (new) — header; a
   `[bootstrap.brew.taps]` table holding `"virajp/tap" = …` with the
   third-party-tap comment copied above it; a `[bootstrap.packages]` table
   holding
   `"brew:virajp/tap/claude-status" = "latest" # Claude Code status line`.
6. **`dotfiles/mise/conf.d/packages.toml`** — remove the `"virajp/tap"` line and
   the `claude-status` line. If `[bootstrap.brew.taps]` is then empty, remove
   that table header too and move its tap comment to `claude.toml` only (step
   5); `[bootstrap.brew]` `adopt = true` stays.

## Verification

- `mise x -- taplo check dotfiles/mise/config.toml dotfiles/mise/conf.d/*.toml`
  passes, and `mise x -- taplo fmt --check` on the same files passes.
- `grep -rn 'virajpatel\|virajp' dotfiles/mise/config.toml
  dotfiles/mise/conf.d/system.toml dotfiles/mise/conf.d/packages.toml`
  returns nothing.
- `MISE_CONFIG_DIR=$PWD/dotfiles/mise mise config ls` lists the three new files
  with no parse error, and
  `MISE_CONFIG_DIR=$PWD/dotfiles/mise mise env
  | grep GITHUB_USER_NAME` shows
  `virajp`. If mise does not honour `MISE_CONFIG_DIR`, return a `GAP:` and skip
  this bullet.
- The union of keys is unchanged: every table and key removed from
  `config.toml`, `system.toml`, `packages.toml` appears exactly once in the new
  files.
- The wave gate lines pass.

## Guardrails

- Never touch `dotfiles/mise/mise.lock` or `[tools]`.
- Never run `mise bootstrap`, `mise bootstrap … apply` or `dotfiles:install` —
  the live `~/.config/mise` points at the main checkout.
- Keep `project_dir` literal — it cannot be templated.
- Byte-copy moved blocks; do not retype them.
- Do not edit any doc; report falsified passages as `DOCS FALSIFIED:`.
- Delete with `rm`, never `git rm`.

## Commit

`ops: split identity, mempalace and claude state into their own conf.d files`
