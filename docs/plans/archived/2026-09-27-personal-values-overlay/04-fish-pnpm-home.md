# U4 — fish PNPM_HOME uses $HOME

- **Wave:** 1
- **Depends on:** —
- **Owns:** `dotfiles/fish/conf.d/02-path.fish`
- **Model:** opus
- **Kind:** edit
- **Read first:** every owned file, top to bottom, before editing.

## Ruling

> 7 — `set -gx PNPM_HOME "$HOME/Library/pnpm"`. (Bug fix.)

## Edits

1. **`dotfiles/fish/conf.d/02-path.fish:31`** — replace
   `set -gx PNPM_HOME '/Users/virajpatel/Library/pnpm'` with
   `set -gx PNPM_HOME "$HOME/Library/pnpm"` (double quotes so `$HOME` expands).
   Nothing else changes.

## Verification

- `fish -n dotfiles/fish/conf.d/02-path.fish` passes (syntax).
- `HOME=/tmp/x fish -c 'source dotfiles/fish/conf.d/02-path.fish; echo $PNPM_HOME'`
  prints `/tmp/x/Library/pnpm`.
- `grep -c virajpatel dotfiles/fish/conf.d/02-path.fish` is `0`.
- The wave gate lines pass.

## Guardrails

- Do not touch any other fish file.
- Do not edit any doc.

## Commit

`ops: derive PNPM_HOME from $HOME in fish`
