# GPG
set --global --export GPG_TTY (tty)

# Set HOMEBREW_PREFIX environment variable
set --global --export HOMEBREW_PREFIX "/opt/homebrew"

# iCloud Path
set --global --export CLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Docker environment variables
set --global --export DOCKER_BUILDKIT 1
set --global --export COMPOSE_DOCKER_CLI_BUILD 1
set --global --export DOCKER_DEFAULT_PLATFORM "linux/amd64"
set --global --export DOCKER_HIDE_LEGACY_COMMANDS 1
set --global --export BUILDKIT_PROGRESS "auto"

# Import secrets (environment variables)
source "$CLOUD_PATH/Secure/secrets.fish"
