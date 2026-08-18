#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Environment Variables
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Only bootstrap variables belong here. Everything else lives in mise's [env]
# block (dotfiles/mise/config.toml), which both fish and zsh pick up on
# activation.
#
# - GPG_TTY: must be evaluated per-session against the live terminal, so mise
#   cannot provide it (its [env] is evaluated in a subprocess).
# - HOMEBREW_PREFIX: consumed by 02-path.fish and 05-homebrew.fish, both of
#   which run before mise activates at 51-.
# =============================================================================

# GPG
set --global --export GPG_TTY (tty)

# Set HOMEBREW_PREFIX environment variable
set --global --export HOMEBREW_PREFIX /opt/homebrew
