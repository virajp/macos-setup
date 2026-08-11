#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: PATH Management
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Environment variables referenced:
# - HOMEBREW_PREFIX: Homebrew installation prefix (defined in 01-env.fish)
# - GEM_HOME: Ruby gems installation directory (defined in 03-dev.fish)
# - HOME: User home directory (system variable)
#
# Path additions for development tools and utilities:
# - Homebrew-installed curl, ruby, and openjdk binaries
# - Flutter/Dart pub cache binaries
# - Ruby gems binaries
# - User-local binaries
# =============================================================================

# Path Management - Add development tool paths to Fish PATH
fish_add_path "$HOMEBREW_PREFIX/opt/curl/bin"
fish_add_path "$HOMEBREW_PREFIX/opt/ruby/bin"
fish_add_path "$HOME/.pub-cache/bin"
fish_add_path "$HOME/.local/bin"
