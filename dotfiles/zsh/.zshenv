##########################################################################
# .zshenv is sourced for EVERY zsh invocation - login, interactive, and   #
# scripts. Keep it minimal: only what non-interactive shells need.        #
##########################################################################

# mise shims for non-interactive shells.
#
# Interactive shells get a full `mise activate zsh` from .zshrc instead. The
# interactive guard below means exactly one activation runs per shell, which
# mirrors the if/else in fish's conf.d/51-mise.fish.
#
# The absolute path is required: /usr/libexec/path_helper only runs from
# /etc/zprofile (login shells), so /opt/homebrew/bin is not on PATH yet here.
if [[ ! -o interactive ]] && [[ -x /opt/homebrew/bin/mise ]]; then
  export MISE_ENV=dev
  eval "$(/opt/homebrew/bin/mise activate zsh --shims)"
fi
