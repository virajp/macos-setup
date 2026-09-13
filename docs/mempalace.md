# mempalace

One-time setup for the mempalace MCP server + qdrant stack
(`dotfiles/mempalace/`, supervised by [pitchfork](https://pitchfork.jdx.dev/)
via `dotfiles/pitchfork/`). After this, `updateall` keeps the images current
weekly and pitchfork keeps the stack running across reboots.

```shell
mise run dotfiles:install
mise install
pitchfork boot enable
mise run mempalace:pull
mise run mempalace:start
```

Verify it's serving:

```shell
curl -sf http://127.0.0.1:8765/healthz
```

Claude Code's `mempalace` MCP connection (registered by the `vwf` plugin at
`http://127.0.0.1:8765/mcp`) should now show as connected — no MCP config
changes are needed on this machine.

## CLI access

There is no local `mempalace` CLI install (the previous `pipx:mempalace` mise
tool was removed — its `mempalace-mcp` binary backed an unrelated stdio MCP
server, and its bare `mempalace status` command reads a *different*, purely
local palace at `~/.mempalace/palace`; it can't see the qdrant-backed data at
all, by design of the tool — `status` never consults the backend config).

The `mempalace` shell alias (and equivalent `mise run mempalace:status` task)
instead runs `status` **inside the container**, where it correctly reflects the
live qdrant-backed data:

```shell
mempalace
```

No other subcommand is wired up — this alias is status-only on purpose.
