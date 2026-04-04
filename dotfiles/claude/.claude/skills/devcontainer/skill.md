---
name: devcontainer
description: DevContainer configuration and management for the 95octane monorepo. Use when adding/updating devcontainer config, port forwards, tool versions, Doppler auth in containers, or deciding what runs inside vs outside the container.
skill_version: 1.0.0
updated_at: 2026-04-04T00:00:00Z
tags: [devcontainer, docker, dev-environment, vscode, cursor, codespaces]
progressive_disclosure:
  entry_point:
    summary: "DevContainer provides a reproducible dev environment for the 95octane apiService monorepo"
    when_to_use: "Setting up, modifying, or troubleshooting the DevContainer configuration"
    quick_start: "Run `mise run deps:start` on host, then open repo in VS Code and use 'Reopen in Container'"
  references: []
context_limit: 800
---

# DevContainer Skill

## Key Files

- `.devcontainer/devcontainer.json` — Main config (ports, extensions, mounts, MISE_ENV)
- `.devcontainer/Dockerfile` — Tool installation (docker CLI, Doppler CLI, mise)
- `.devcontainer/docker-compose.devcontainer.yaml` — External network attachment (required)
- `.devcontainer/post-create.sh` — Lifecycle script with explicit PATH; runs mise install, bun install, build:common
- `.devcontainer/README.md` — Setup and troubleshooting guide
- `.config/mise.devcontainer.toml` — Overrides 5 hostname env vars for container DNS

## Architecture

### Base Image

`mcr.microsoft.com/devcontainers/base:ubuntu` — includes glibc, sudo, zsh,
bash, common dev utilities, and a non-root `vscode` user with full VS Code
Remote compatibility.

### Tool Installation Split

| Layer | Tools |
|---|---|
| Dockerfile (image) | docker CLI, Doppler CLI, mise binary |
| postCreateCommand (container create) | bun, node, firebase-tools, turbo, biome (via `mise install`) |
| postCreateCommand | workspace deps (`bun install --frozen-lockfile`) |
| postCreateCommand | common package build (`bun run build:common`) |

This split maximises Docker layer caching — workspace-specific tool versions
(managed by `.config/mise.toml`) are installed fresh on each container create,
not baked into the image.

## Networking

The devcontainer joins three external Docker networks so dependency services are
reachable by their Docker service names (not OrbStack `.orb.local` FQDNs which
only resolve on the macOS host):

| Network | Service | Ports |
|---|---|---|
| firebase-network | firebase-emulator | 8080 (Firestore), 9099 (Auth), 9199 (Storage) |
| temporal-network | temporal | 7233 (gRPC), 8233 (UI) |
| grafana-network | grafana | 3000 (UI), 4317 (OTEL gRPC), 4318 (OTEL HTTP) |

`MISE_ENV=devcontainer` (set in `remoteEnv`) activates `.config/mise.devcontainer.toml`,
which overrides the 5 hostname env vars from `mise.development.toml`:
- `FIREBASE_AUTH_EMULATOR_HOST`
- `FIREBASE_STORAGE_EMULATOR_HOST`
- `FIRESTORE_EMULATOR_HOST`
- `OTEL_EXPORTER_OTLP_ENDPOINT`
- `TEMPORAL_ADDRESS`

**Networks must exist before opening the devcontainer.** Run `mise run deps:start`
on the host first.

## What Runs Inside vs Outside the Container

| Location | What runs there |
|---|---|
| Inside container | Code editing, linting (`bun run lint`), type-checking, bun install, builds, `mise run s:dev` |
| Outside on host Docker | Firebase emulators, Temporal, Grafana (via docker-compose) |
| Either (via socket) | `docker compose` commands — socket mount lets both sides control host Docker |

## Adding a New Port Forward

1. Add the port to `forwardPorts` array in `devcontainer.json`
2. If the port is from a docker-compose service on a new network, add the network to
   `docker-compose.devcontainer.yaml` (as external) and to the devcontainer service's
   `networks` list

## Updating Tool Versions

Tool versions are managed by mise via `.config/mise.toml`. Changes there take
effect the next time `mise install` runs (automatically on container rebuild via
`postCreateCommand`). No Dockerfile changes needed for tool version bumps.

The base image (`mcr.microsoft.com/devcontainers/base:ubuntu`) is updated by
Microsoft. Rebuild the container periodically to pick up security patches:
`Dev Containers: Rebuild Container`.

## Doppler Authentication in Containers

| Method | How |
|---|---|
| Host mount (preferred) | `doppler login` on host; `~/.doppler/` mounted in automatically |
| Manual | Run `doppler login` inside the container terminal |
| CI / Codespaces | Set `DOPPLER_TOKEN` as a secret — Doppler CLI picks it up automatically |

## Rebuilding the Container

- VS Code / Cursor: `Cmd+Shift+P` → `Dev Containers: Rebuild Container`
- After Dockerfile changes, always rebuild (not just reopen)
- `postCreateCommand` (post-create.sh) re-runs on every rebuild

## Troubleshooting

| Symptom | Fix |
|---|---|
| Container fails to start: "network not found" | Run `mise run deps:start` on host to create external networks |
| Docker socket permission denied | User is in docker group via Dockerfile; check socket group with `ls -la /var/run/docker.sock` |
| mise tools not found | `mise install && mise reshim` |
| Doppler auth expired | `doppler login` on host (remount) or inside container |
| Port conflict | Check `forwardPorts` in devcontainer.json; remove conflicting port |
| Volume path resolution errors with docker compose | Set `COMPOSE_PROJECT_DIR` to the host workspace path |
