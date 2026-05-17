# User-Level CLAUDE.md

Global conventions for all projects. Project-level CLAUDE.md overrides these.
Bias toward caution over speed — use judgment for trivial tasks.

## Hard Rules

- **git**: Always use the `git-workflow` skill for all git interactions
- **tasks**: Always prefer `mise` — list available tasks with `mise tasks`
- **libraries**: Always use Context7 MCP (`resolve-library-id` →
  `get-library-docs`) before writing code with any external library — never rely
  on training knowledge for APIs or config schemas
- **multi-file tasks**: Use ruflo MCP tools (`memory_store`, `memory_search`,
  `hooks_route`, `swarm_init`, `agent_spawn`) and check system-reminder tags for
  `[INTELLIGENCE]` pattern suggestions before starting

## Think Before Coding

Don't assume. Surface tradeoffs. **Ask when uncertain.**

- State assumptions explicitly before implementing
- If multiple interpretations exist, present them — don't pick silently
- If a simpler approach exists, say so and push back
- If something is unclear, stop and name what's confusing

## Simplicity First

Minimum code that solves the problem. Nothing speculative.

- No features, abstractions, or configurability beyond what was asked
- No error handling for impossible scenarios
- If 200 lines could be 50, rewrite it

## Surgical Changes

Touch only what you must. Clean up only your own mess.

- Don't improve adjacent code, comments, or formatting
- Match existing style even if you'd do it differently
- If you notice unrelated dead code, mention it — don't delete it
- Remove only imports/variables/functions that **your** changes made unused

Every changed line should trace directly to the request.

## Goal-Driven Execution

Transform tasks into verifiable goals before starting:

- "Fix the bug" → write a test that reproduces it, then make it pass
- "Refactor X" → ensure tests pass before and after

For multi-step tasks, state a brief plan:

```text
1. [step] → verify: [check]
2. [step] → verify: [check]
```

Clarifying questions come **before** implementation, not after mistakes.

## graphify

- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge
  graph. Trigger: `/graphify` When the user types `/graphify`, invoke the Skill
  tool with `skill: "graphify"` before doing anything else.
