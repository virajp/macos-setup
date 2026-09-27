# U6 — Gates and bump

- **Wave:** 3
- **Depends on:** U5
- **Owns:** — (no version file, no generator)
- **Model:** opus
- **Kind:** edit

## Ruling

> Release macos-setup publicly: none. macos-setup has no version file and no
> release process.

## Edits

None. No version to bump and no generator to run (`graphify-out/` is rebuilt by
the post-commit hook, not by this unit).

## Verification

- The full wave gate, green:
  - `mise run code:format`
  - `mise run code:lint`
  - `mise x -- pre-commit run --config .config/pre-commit-config.yaml --all-files`
- `git grep -n 'virajpatel' -- dotfiles/mise/config.toml
  dotfiles/mise/conf.d/system.toml dotfiles/mise/conf.d/packages.toml
  dotfiles/git/gitconfig dotfiles/ssh/config dotfiles/fish docs/account.md`
  returns nothing.

## Guardrails

- Do not fix a failing gate by editing an owned path of another unit; report it
  as `UNRESOLVED:` naming the unit.

## Commit

none — this unit changes nothing; if a gate fixer rewrites a file, report it
instead of committing.
