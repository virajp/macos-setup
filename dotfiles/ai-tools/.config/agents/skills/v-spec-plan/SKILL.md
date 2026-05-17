---
name: v-spec-plan
description: Use when creating a specification and implementation plan for a
  feature. Takes in product and engineering docs as input and produces a spec
  and plan in docs/superpowers/. Triggers on `/v-spec-plan` or requests to
  create a spec and plan for a feature.
version: 1.0.0
---

# Spec & Plan

Guides creation of specs & plan from the product and engineering docs. Uses
`superpowers:brainstorming`

## When to Use

- User types `/v-spec-plan` or asks to create a specification and implementation
  plan for a feature
- Can also be triggered by `/v-start` when user intent indicates need for a spec
  and plan
- A new feature is being designed and needs a spec and plan before
  implementation
- An existing action changes behavior and the spec and plan needs updating

## Locations

- Product docs: `docs/product/<entity>/index.md` and
  `docs/product/<entity>/<action>.md`
- Engineering docs: `docs/engineering/<entity>/schema.md`,
  `docs/engineering/<entity>/api.md`, and
  `docs/engineering/<entity>/workflows.md`

## Critical Rules

**Require product and engineering docs first.** If `docs/product/<entity>/` or
`docs/engineering/<entity>/` does not exist, halt and tell the user: "No product
or engineering doc found for `<entity>`. Run `/v-docs-product` and
`/v-docs-engineering` first."

**Read code before asking questions.** Product & Engineering docs describe
intended behavior, not what the code currently does. Code may be incomplete,
ahead of, or behind the spec. Read the relevant code files for the feature
before asking any questions. These are your source of truth for how the system
currently works and what constraints exist.

**Follow the two-page template strictly.** Every doc is either an entity index
or an action page. Never mix them.

## Process

Invoke `superpowers:brainstorming` immediately. Do not ask any questions first.
