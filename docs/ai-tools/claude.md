# Claude Code customization surfaces

---

## What you already know

Skills, slash commands (`/command`), MCP servers, plugins — these are the
well-documented ones.

---

## What you might be missing

### 1. Hooks (most powerful, often underused)

Hooks are custom shell commands that execute automatically when targeted events
occur in a Claude Code session — like when Claude is about to write a file, or
when you submit a prompt. They communicate via stdin/stdout/exit codes and run
with your user permissions.

Key hook events: `PreToolUse` / `PostToolUse` (wrap every tool call — Bash,
Edit, Write, Read, Grep, WebFetch), `UserPromptSubmit` (validate or enrich
prompts before Claude processes them), `SessionStart` / `SessionEnd` (load
context, clean up/log), `PermissionRequest`, and `Notification`.

Beyond shell commands, hooks also support HTTP endpoints and LLM prompts as hook
handlers. Practical uses:

- Auto-run Prettier/ESLint after every file edit (`PostToolUse`)
- Inject git status + TODO list at session start (`SessionStart`)
- Gate dangerous bash commands (`PreToolUse` with exit-code control)
- Desktop notifications when Claude needs input

### 2. Custom Sub-agents

Sub-agents support tool restrictions, model selection (e.g. Haiku for
lightweight tasks), persistent memory at `~/.claude/agent-memory/`, worktree
isolation, and max turn limits. You can invoke them via `@agent-name` mentions,
or start an entire session *as* a subagent with `--agent <name>`.

Multiple independent Claude Code sessions can coordinate via shared tasks and
peer-to-peer messaging, each with its own full context window — enabling truly
parallel work on separate features or research tracks.

### 3. Memory System (auto + explicit)

Two separate mechanisms:

- **Auto-memory**: Claude automatically maintains memory across sessions at
  `~/.claude/projects/<project>/memory/`. It tracks patterns: build commands,
  architectural decisions, coding preferences. The first 200 lines load at every
  session start. Use `/memory` to view and edit directly.

- **CLAUDE.md (explicit)**: Version-controlled project knowledge. Use
  `.claude/rules/` for path-scoped rules — a rule file with
  `paths: src/components/**/*.tsx` only applies when Claude touches those files.

- **AGENTS.md (cross-tool standard)**: An emerging standard from a collaboration
  between Sourcegraph, OpenAI, Google, Cursor, and others, now maintained by the
  Agentic AI Foundation. Supported by Claude Code, Cursor, GitHub Copilot,
  Gemini CLI, Windsurf, Aider, Zed, Warp, and others — one memory file for any
  agent.

### 4. Settings Files (layered config)

Three levels with increasing specificity:

- `~/.claude/settings.json` — user-global
- `.claude/settings.json` — project-shared (commit this)
- `.claude/settings.local.json` — personal overrides (gitignore this)

Environment variables can control things like overriding default model for
Haiku, detecting when a script runs inside a Claude Code shell, enabling
PowerShell on Windows, and fast-mode fallback when corporate proxies block
status endpoints.

### 5. `.mcp.json` (project-scoped MCP)

Separate from global MCP config — lets you commit project-specific MCP server
configs (JIRA, GitHub, custom internal tools) alongside your codebase so the
whole team picks them up automatically.

### 6. Worktree Isolation

Hooks and sub-agents can trigger on worktree creation via `--worktree` or
`isolation: "worktree"`, enabling custom worktree creation logic. Useful for
running parallel Claude sessions without file conflicts.

---

## Summary matrix

| Surface           | Scope                 | Config location                    |
| ----------------- | --------------------- | ---------------------------------- |
| CLAUDE.md / rules | Project memory        | `.claude/rules/`, root `CLAUDE.md` |
| Auto-memory       | Session persistence   | `~/.claude/projects/*/memory/`     |
| Hooks             | Lifecycle automation  | `settings.json` → `hooks` key      |
| Sub-agents        | Specialized roles     | `.claude/agents/*.md`              |
| Slash commands    | Reusable workflows    | `.claude/commands/*.md`            |
| Skills            | Pattern libraries     | `.claude/skills/`                  |
| MCP (global)      | Tool extensions       | `~/.claude/claude.json`            |
| `.mcp.json`       | Project MCP           | project root                       |
| Settings layers   | Permissions/env/model | user → project → local             |
| Plugins           | Packaged extensions   | installed via `claude plugins`     |

Hooks are likely the biggest productivity multiplier you're not using yet —
especially `PreToolUse` for gating and `SessionStart` for context injection. For
your scale at Tekion, the sub-agent team coordination model is also worth
exploring for parallelizing large refactoring or cross-service work.
