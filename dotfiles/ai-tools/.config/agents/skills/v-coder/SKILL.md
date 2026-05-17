---
name: v-coder
description: Use when writing or editing code. Takes in code files as input and
  produces code changes or new code files. Triggers on `/v-coder` or requests to
  write or edit code.
version: 1.0.0
---

# Coder

Guides writing and editing of code files. Uses `superpowers:executing-plans`

## When to Use

- User types `/v-coder` or asks to write or edit code
- Can also be triggered by `/v-start` when user intent indicates need for code
  changes
- An existing or new feature is being implemented and needs writing code
- An existing or new action is being implemented and needs writing code

## Locations

- Product docs: `docs/product/<entity>/index.md` and
  `docs/product/<entity>/<action>.md`
- Engineering docs: `docs/engineering/<entity>/schema.md`,
  `docs/engineering/<entity>/api.md`, and
  `docs/engineering/<entity>/workflows.md`

## Critical Rules

**Require plan first.** If spec and plan is NOT provided, halt and tell the
user: "No spec & plan has been provided. Run `/v-spec-plan` first."

**Read code before asking questions.** Product & Engineering docs describe
intended behavior, not what the code currently does. Code may be incomplete,
ahead of, or behind the spec. Read the relevant code files for the feature
before asking any questions. These are your source of truth for how the system
currently works and what constraints exist.

**Follow the two-page template strictly.** Every doc is either an entity index
or an action page. Never mix them.

## Process

Invoke `superpowers:executing-plans`
