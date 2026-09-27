# U2 — Pin yq in the repo toolchain

- **Wave:** 1
- **Depends on:** —
- **Owns:** `.config/mise.toml`, `.config/mise.lock`
- **Model:** opus
- **Kind:** edit
- **Read first:** both owned files.

## Ruling

> 14 — Pin `yq` in `.config/mise.toml` `[tools]`; update `.config/mise.lock`
> with `mise lock`. Tasks read TOML via `yq -p toml -o json`.

## Edits

1. **`.config/mise.toml`** — add `yq = { version = "latest" }` to `[tools]`, in
   alphabetical order, aligned like its neighbours.
2. **`.config/mise.lock`** — run `mise lock` from the repo root (the one
   generator this plan names for a unit). If it also moves other tools'
   versions, revert those hunks so only `yq` entries change.

## Verification

- `mise x -- yq --version` succeeds from the repo root.
- `git diff .config/mise.lock` touches only `yq` entries.
- The wave gate lines pass.

## Guardrails

- Do not touch `dotfiles/mise/*` (the global config).
- Do not run `mise upgrade`.

## Commit

`ops: pin yq for the adoption tasks`
