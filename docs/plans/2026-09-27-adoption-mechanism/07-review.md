# U7 — Review: adopt:check, adopt:changelog and their hooks

- **Wave:** 3
- **Depends on:** U5, U6
- **Owns:** —
- **Model:** opus
- **Kind:** review

## Scope

Covers U5 (`adopt:check`, `code:lint` wiring, pre-commit hooks) and U6
(`adopt:changelog`) — the two units that land runnable bash. Reviews the branch
delta since the branch base (first review row). Reason (decision 17): they
execute on every commit and lint run, and U6 calls an external CLI with repo
content.
