#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Shell Prompt
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Shell prompt configuration:
# - Initializes oh-my-posh prompt (preferred)
# - Alternative starship configuration (commented out)
# =============================================================================

# Using starship prompt
# if type -q starship
#     starship init fish | source
# end

# Using oh-my-posh prompt
if type -q oh-my-posh
    oh-my-posh init fish --config ~/.config/oh-my-posh/shell.yaml | source
end
