---
name: v-start
description: Explicit project workflow router. Call this to start any product or
  engineering work. NOT auto-triggered.
---

# v-start — Project Workflow Router

Explicitly called by user to start a project workflow. Never auto-triggered.

## Hard Rules

- Only run when user explicitly calls `/v-start`
- If user intent is unclear, ask ONE clarifying question before routing
- Do not assume intent — always confirm the workflow before delegating
- Do not proceed past routing without user confirmation

## Workflow Routing

Based on user intent, delegate to the appropriate skill:

| Intent                                          | Skill to invoke          |
| ----------------------------------------------- | ------------------------ |
| Define a product feature (what & why)           | `/sparc:specification`   |
| Create engineering / technical docs from a PRD  | `/sparc:architecture`    |
| Create spec & implementation plan for a feature | `/sparc:spec-pseudocode` |
| Build / code a feature from an existing spec    | `/sparc:tdd`             |

## Clarifying Questions (if intent is unclear)

Ask the user:

> "Are you starting from scratch (product idea), working from an existing PRD,
> or do you have a spec ready to implement?"

Route based on their answer:

- Scratch → `/sparc:specification`
- Have PRD → `/sparc:architecture` or `/sparc:spec-pseudocode`
- Have spec → `/sparc:tdd`
