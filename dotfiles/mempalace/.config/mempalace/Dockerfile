# MemPalace MCP server, served over HTTP.
#
# Claude Code connects to http://127.0.0.1:8765/mcp rather than spawning the
# server over stdio, which keeps crashing. Vectors live in the sibling qdrant
# service, so this container holds only the config and the embedding-model
# cache.
#
# Built here rather than pulled: ghcr.io/mempalace/mempalace is not anonymously
# pullable (401), so upstream's deploy/docker-compose.server.yml cannot be used
# as published.

FROM python:3.12-slim

# uv rather than pip — the installer the project itself uses upstream, and an
# order of magnitude faster resolving this dependency set on a rebuild.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Deliberately unpinned. mempalace:update rebuilds this image weekly, which
# keeps the server in step with the mise-installed CLI and the Claude Code
# plugin — both of which track latest.
#
# No extras: the qdrant backend talks to Qdrant over plain urllib, so the core
# install is enough. (There is no `qdrant` extra to ask for.)
RUN uv pip install --system --no-cache mempalace

# HOME=/data is the single persistence root: the config (~/.mempalace) and the
# lazily downloaded embedding model (~/.cache, ~80 MB on first search) both land
# under the one bind mount.
ENV HOME=/data \
  PYTHONUNBUFFERED=1

RUN groupadd --gid 1000 mempalace \
  && useradd --uid 1000 --gid 1000 --home-dir /data --create-home mempalace

USER mempalace
WORKDIR /data

EXPOSE 8765

# `mempalace-mcp`, not `mempalace serve`: serve forks the real server as a child
# and holds PID 1 itself, so the server would never see SIGTERM. The backend is
# selected by MEMPALACE_BACKEND in the compose environment, keeping deployment
# concerns out of the image.
ENTRYPOINT [ "mempalace-mcp" ]
CMD [ "--transport", "http", "--host", "0.0.0.0", "--port", "8765" ]
