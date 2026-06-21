# AI Tools

Notes and configuration for the AI coding tools used in this setup.

## Documented

- [Claude Code](claude.md) — customization surfaces (hooks, sub-agents, memory,
  settings, MCP).

## Configured via dotfiles

These tools are installed through `mise`/Homebrew and configured under
[`dotfiles/ai-tools/`](../../dotfiles/ai-tools):

- **Claude Code** — `dotfiles/ai-tools/.claude/` (`CLAUDE.md`, `settings.json`,
  hooks) and `ccstatusline`.
- **OpenCode** — `dotfiles/ai-tools/.config/opencode/`.
- **Gemini CLI** — `dotfiles/ai-tools/.gemini/`.
- **Shared agent skills** — `dotfiles/ai-tools/.config/agents/skills/`.
