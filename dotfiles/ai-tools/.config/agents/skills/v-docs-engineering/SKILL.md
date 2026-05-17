---
name: v-docs-engineering
description: Use when creating or updating engineering documentation for a
  entity — Firestore schema, API spec, and Temporal workflows under
  docs/engineering/. Requires a corresponding product doc to exist first. Triggers
  on `/v-docs-engineering` or requests to document technical details of an entity.
version: 1.1.0
---

# Engineering Doc

Guides creation of technical engineering documentation for entities. The
technical counterpart to `v-docs-product`. Uses `superpowers:brainstorming` as
the underlying method with engineering-specific focus.

## When to Use

- User types `/v-docs-engineering` or asks to write engineering docs for an
  entity
- Can also be triggered by `/v-start` when user intent indicates need for
  engineering documentation
- A product doc exists and engineering documentation needs to be created or
  updated
- Firestore structure, API spec, or worker behavior needs to be formally
  documented

## Critical Rules

**Require a product doc first.** If `docs/product/<entity>/` does not exist,
halt and tell the user: "No product doc found for `<entity>`. Run
`/v-docs-product` first."

**Read all product docs before invoking brainstorming.** Read `index.md` and
every action page in `docs/product/<entity>/`. These are your source of truth
for behavior, rules, and failure cases.

**Always produce three files.** `schema.md`, `api.md`, and `workflows.md` are
always written. If no worker activity exists, `workflows.md` uses the
placeholder below — never skip it.

**Always migrate Firestore structure.** If the product doc `index.md` contains a
Firestore structure block, remove it and replace with a link to the engineering
schema doc. This is the canonical home for data models.

**No product behavior in engineering docs.** Engineering docs describe shape,
types, constraints, status codes, and retry policies — not user-facing behavior.
If you find yourself writing "the user can...", stop and move it to the product
doc.

## Process

1. Check that `docs/product/<entity>/` exists. If not, halt with the message
   above.
2. Check whether `docs/engineering/projects/` contains any legacy files for this
   entity (e.g. `projects/common/schemas/<entity>.md`,
   `projects/service/api/<entity>.md`). If found, read them as additional input
   and note them for migration — do not create a parallel entity folder that
   silently duplicates them.
3. Read every file in `docs/product/<entity>/`.
4. Invoke `superpowers:brainstorming` immediately. Do not ask any questions
   first.
5. Use the product doc content as the brainstorming brief.
6. Ask technical clarifying questions one at a time (see Brainstorming
   Questions).
7. Invoke `rest-api-design` skill when writing `api.md`. Apply it for: endpoint
   naming conventions, HTTP method selection, status code choices, and error
   format. Do not apply the versioning, pagination, or rate-limiting sections
   unless the entity needs them.
8. Write all three output files.
9. Update `docs/product/<entity>/index.md` to migrate the Firestore structure.
10. If legacy files were found in step 2, replace each with a redirect note:
    `> Moved to [<Entity> Schema](../../../engineering/<entity>/schema.md).`

## Brainstorming Questions

Cover all six categories before writing. Ask one question at a time.

1. **Field types & constraints** — What is the exact TypeScript/Firestore type
   for each field in the document? Are there min, max, or length constraints not
   mentioned in the product doc?

2. **Indexes** — Which fields are queried independently or in combination? Are
   composite indexes needed for any query patterns?

3. **Auth rules per endpoint** — Is each endpoint authenticated? What
   role/ownership check is enforced — creator only, admin only, group member
   only, or any authenticated user?

4. **HTTP status codes per failure case** — For each failure case in the product
   doc, what is the HTTP status code and error code string returned?

5. **Worker behavior** — Are there Temporal workflows or activities for this
   entity? What triggers them, what do they do, and what are the retry policies
   and timeouts?

6. **Planned but not yet live** — Are there planned features that need technical
   stubs? These match `> Planned` callouts in the product doc.

## Output Templates

### `docs/engineering/<entity>/schema.md`

````markdown
# <Entity> Schema

## Firestore Document (`<collection>/{<id>}`)

| Field | Type | Required | Constraints | Description |
| ----- | ---- | -------- | ----------- | ----------- |

```jsonc
{
  // full document shape with inline comments explaining each field
}
```

## Sub-collections

> Include this section only if the entity has sub-collections. Omit entirely if
> none exist.

### `<collection>/{<id>}/<sub-collection>/{<subId>}`

| Field | Type | Required | Constraints | Description |
| ----- | ---- | -------- | ----------- | ----------- |

```jsonc
{
  // sub-collection document shape
}
```

## Indexes

| Fields | Query Type | Reason |
| ------ | ---------- | ------ |
````

### `docs/engineering/<entity>/api.md`

Written using the `rest-api-design` skill. Each endpoint follows this format:

````markdown
# <Entity> API

## <Action Name>

```http
METHOD /path/{param}
```

**Auth:** Bearer token (Firebase ID token) | None

**Request**

```jsonc
{
  "field": "type", // description
}
```

**Response `<2xx status>`**

```jsonc
{
  "field": "value",
}
```

**Errors**

| Status | Code            | Condition                               |
| ------ | --------------- | --------------------------------------- |
| 400    | `MISSING_FIELD` | Required field not provided             |
| 401    | `UNAUTHORIZED`  | No valid Firebase ID token              |
| 403    | `FORBIDDEN`     | Caller lacks permission for this action |
| 404    | `NOT_FOUND`     | Entity does not exist                   |
````

### `docs/engineering/<entity>/workflows.md`

When Temporal worker activity exists:

```markdown
# <Entity> Workflows

## <Workflow Name>

**Trigger:** <event or cron schedule>

**Activities:** <ordered list of activity names>

**Retry policy:**
`maximumAttempts: N, initialInterval: Xs, backoffCoefficient: N`

**Timeout:** `workflowRunTimeout: Xm, activityStartToCloseTimeout: Xs`
```

When no worker activity exists for the entity:

```markdown
# <Entity> Workflows

No Temporal worker activity for this entity.
```

## Product Doc Migration

After writing all three files, check if `docs/product/<entity>/index.md`
contains a Firestore document structure section — identified by a heading like
`## <Entity> Document Structure` or `## Firestore Document` followed by a
`jsonc` code block.

If found:

1. Remove the entire section (heading + content) from the product doc.
2. Replace it with:

```markdown
> See [<Entity> Schema](../../engineering/<entity>/schema.md) for the Firestore
> document structure.
```

If not found, skip this step.

## Save Locations

| File      | Path                                     |
| --------- | ---------------------------------------- |
| Schema    | `docs/engineering/<entity>/schema.md`    |
| API spec  | `docs/engineering/<entity>/api.md`       |
| Workflows | `docs/engineering/<entity>/workflows.md` |

Entity folder names are singular lowercase, matching the folder name used in
`docs/product/<entity>/`.

After writing all files, update `docs/engineering/architecture.md` only if the
entity introduces a pattern not present in any other entity's docs —
specifically: a new Firestore sub-collection pattern, a new Temporal workflow
trigger type, or a new auth mechanism. If none of these apply, skip this step.
