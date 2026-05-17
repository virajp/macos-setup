---
name: v-docs-product
description: Use when creating or updating product documentation for a feature
  — entity overviews or user action pages under docs/product/.
version: 1.1.0
---

# Product Doc

Guides creation of product behavior documentation. Uses
`superpowers:brainstorming` as the underlying method with product-doc-specific
focus.

## When to Use

- User types `/v-docs-product` or asks to document a product feature
- Can also be triggered by `/v-start` when user intent indicates need for
  product documentation
- A new feature is being designed and needs a product doc before implementation
- An existing action changes behavior and the product doc needs updating

## Critical Rules

**Do NOT read code before asking questions.** Product docs describe intended
behavior, not what the code currently does. Code may be incomplete, ahead of, or
behind the spec.

**No implementation detail in output.** No API shapes, request/response bodies,
error codes, or code. If a rule has a technical constraint, link to
`docs/engineering/` — do not repeat it.

**Follow the two-page template strictly.** Every doc is either an entity index
or an action page. Never mix them.

## Process

Invoke `superpowers:brainstorming` immediately. Do not ask any questions first.

The brainstorming session MUST cover these product-specific questions (one at a
time):

1. **Entity or action?** Is this an overview of what the entity IS, or what a
   user DOES with it? Entity → `index.md`. User action → `<action>.md`.
2. **Who does this?** Which user roles can perform the action and under what
   conditions?
3. **What are the rules?** Constraints, limits, preconditions, edge cases. Ask
   until none are left unclear.
4. **What changes as a result?** What does the user observe after the action
   succeeds? (No Firestore paths — just observable product outcomes.)
5. **What fails and why?** Error conditions the user will experience. In plain
   language, not error codes.
6. **What's planned but not live?** Any behavior described in intent but not yet
   built? These get explicit `> Planned — not yet live:` callouts.

## Output Templates

### Entity index (`docs/product/<entity>/index.md`)

```markdown
# <Entity>

One-sentence description of what this entity is.

## Overview

Key concepts and types (e.g., ride types: private, public).

## General Rules

Rules that apply regardless of action.

## Data Model

Firestore document structure (use jsonc blocks).

## Actions

- [Action Name](./<action>.md) — one-line description
```

### Action page (`docs/product/<entity>/<action>.md`)

```markdown
# <Action Name>

One sentence: what the user does and why.

## Who Can Do This

User roles and preconditions.

## Steps

Numbered user-facing flow (no API calls, no code).

## Rules

- Constraints specific to this action
- Limits and edge cases

## What Happens Next

Observable outcome for the user.

## Failure Cases

Plain-language descriptions of what can go wrong and why.

> **Planned — not yet live:** <description of unbuilt behavior>
```

## Save Location

| Page type    | Path                                |
| ------------ | ----------------------------------- |
| Entity index | `docs/product/<entity>/index.md`    |
| Action page  | `docs/product/<entity>/<action>.md` |

Entity folder names are singular lowercase: `ride/`, `user/`, `group/`,
`route/`, etc. Action page names are also lowercase: `request.md`, `join.md`,
`cancel.md`, etc.

After writing, update `docs/product/index.md` to add or update the entry for
this page.
