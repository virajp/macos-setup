#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Fast Node Manager (fnm)
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# fnm: Fast Node Manager
# Reference: https://github.com/Schniz/fnm
#
# Configuration:
# - Auto-switch Node.js versions on directory change
# - Enable corepack support
# - Recursive version file strategy
# - Resolve engines compatibility
# - Load shell completions
# =============================================================================

# Load fnm if it exists, along with cd hook
if type -q fnm
    fnm env --shell fish --use-on-cd --corepack-enabled --version-file-strategy=recursive --resolve-engines=true | source
    fnm completions --shell fish | source
end
