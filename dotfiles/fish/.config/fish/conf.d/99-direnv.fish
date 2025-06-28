#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Direnv Integration
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Direnv configuration:
# - Auto-load environment variables from .envrc files
# - Hook into Fish shell prompt and command execution events
# - Support for different direnv modes (disable_arrow, eval_after_arrow)
# - Uses Homebrew-installed direnv at /opt/homebrew/bin/direnv
# =============================================================================

    function __direnv_export_eval --on-event fish_prompt;
        "/opt/homebrew/bin/direnv" export fish | source;

        if test "$direnv_fish_mode" != "disable_arrow";
            function __direnv_cd_hook --on-variable PWD;
                if test "$direnv_fish_mode" = "eval_after_arrow";
                    set -g __direnv_export_again 0;
                else;
                    "/opt/homebrew/bin/direnv" export fish | source;
                end;
            end;
        end;
    end;

    function __direnv_export_eval_2 --on-event fish_preexec;
        if set -q __direnv_export_again;
            set -e __direnv_export_again;
            "/opt/homebrew/bin/direnv" export fish | source;
            echo;
        end;

        functions --erase __direnv_cd_hook;
    end;
