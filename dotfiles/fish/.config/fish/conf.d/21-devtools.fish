#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Developer Tools
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Developer tool completions:
# - Apko: APK package building tool completions
# - Melange: Package building tool completions
# =============================================================================

# Initialize Developer Tools

# Apko - APK package building tool
if type -q apko
    apko completion fish | source
end

# Melange - Package building tool
if type -q melange
    melange completion fish | source
end

# GitLab CLI
if type -q glab
    glab completion -s fish | source
end
