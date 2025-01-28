# GPG
set --universal --export GPG_TTY (tty)

# iCloud Path
set --universal --export CLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Docker environment variables
set --universal --export DOCKER_BUILDKIT 1
set --universal --export COMPOSE_DOCKER_CLI_BUILD 1
set --universal --export DOCKER_DEFAULT_PLATFORM "linux/amd64"
set --universal --export DOCKER_HIDE_LEGACY_COMMANDS 1
set --universal --export BUILDKIT_PROGRESS "auto"
