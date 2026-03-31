#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Environment Variables
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Environment variables defined:
# - GPG_TTY: TTY for GPG operations
# - HOMEBREW_PREFIX: Homebrew installation prefix (/opt/homebrew)
# - CLOUD_PATH: iCloud Drive path for synced documents
# - DOCKER_*: Docker environment configuration
# - BUILDKIT_*: Docker BuildKit configuration
# =============================================================================

# GPG
set --global --export GPG_TTY (tty)

# Set HOMEBREW_PREFIX environment variable
set --global --export HOMEBREW_PREFIX /opt/homebrew

# iCloud Path
set --global --export CLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Docker environment variables
set --global --export DOCKER_BUILDKIT 1
set --global --export COMPOSE_DOCKER_CLI_BUILD 1
set --global --export DOCKER_DEFAULT_PLATFORM linux/amd64
set --global --export DOCKER_HIDE_LEGACY_COMMANDS 1
set --global --export BUILDKIT_PROGRESS auto
