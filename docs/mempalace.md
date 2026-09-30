# mempalace

One-time setup for mempalace's qdrant backend (a docker compose stack declared
in `[bootstrap.compose.mempalace]` of
`dotfiles/.config/mise/conf.d/mempalace.toml`). After this, `updateall` pulls
the qdrant image weekly.

```shell
mise run dotfiles:install
mise install
mise run mempalace:start
```

Verify qdrant is serving:

```shell
curl -sf http://127.0.0.1:6333/healthz
```

The MCP server needs no setup: the `vwf` plugin has Claude Code start
`mempalace-mcp` (from the `pipx:mempalace` mise tool) over stdio, configured by
the `MEMPALACE_*` `[env]` in `dotfiles/.config/mise/conf.d/mempalace.toml`.
