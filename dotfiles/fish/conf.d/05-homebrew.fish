#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Homebrew
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Environment variables referenced:
# - HOMEBREW_PREFIX: Homebrew installation prefix (defined in 01-env.fish)
#
# Homebrew configuration and environment setup:
# - Initialize Homebrew shell environment
# - Configure Homebrew behavior and preferences
# - Optimize Homebrew performance and display settings
# =============================================================================

# Homebrew Initialization
if test -f "$HOMEBREW_PREFIX/bin/brew"
  # If you're using macOS, you'll want this enabled
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv fish)"
end

set --global --export HOMEBREW_NO_ANALYTICS true
set --global --export HOMEBREW_CURL_RETRIES 2
set --global --export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 7
set --global --export HOMEBREW_CLEANUP_MAX_AGE_DAYS 7
set --global --export HOMEBREW_DISPLAY_INSTALL_TIMES true
set --global --export HOMEBREW_FAIL_LOG_LINES 100
set --global --export HOMEBREW_FORCE_BREWED_CURL true
set --global --export HOMEBREW_FORCE_BREWED_GIT true
set --global --export HOMEBREW_CASK_OPTS "--appdir=~/Applications --caskroom=$HOMEBREW_PREFIX/Caskroom"
set --global --export HOMEBREW_NO_ENV_HINTS 1
