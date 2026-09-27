# U9 — Gates and bump

- **Wave:** 5
- **Depends on:** U8
- **Owns:** — (no version file, no generator)
- **Model:** opus
- **Kind:** edit

## Ruling

> Release macos-setup publicly: none. macos-setup has no version file and no
> release process.

## Edits

None. No version to bump and no generator to run.

## Verification

- The full wave gate, green:
  - `mise run code:format`
  - `mise run code:lint` (includes `adopt:check`)
  - `mise x -- pre-commit run --config .config/pre-commit-config.yaml --all-files`
- `git status --short docs/adopt/changelog.md` is empty (no hook draft leaked
  into the run).

## Guardrails

- Do not fix a failing gate by editing another unit's owned path; report it as
  `UNRESOLVED:` naming the unit.

## Commit

none — this unit changes nothing; if a gate fixer rewrites a file, report it
instead of committing.
