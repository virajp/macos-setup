##########################################################################
# .zshenv is sourced for EVERY zsh invocation - login, interactive, and   #
# scripts. Keep it minimal: only what non-interactive shells need.        #
##########################################################################

# mise shims, loaded unconditionally.
#
# Two jobs:
#   1. Non-interactive shells get mise-managed tools on PATH (.zshrc never
#      runs for them).
#   2. Interactive shells need it too, and not just for tools: zsh's
#      `brew shellenv` runs /usr/libexec/path_helper (the fish variant does
#      not), which rebuilds PATH and leaves mise-managed binaries
#      unresolvable. The fnox-env mise plugin shells out to `fnox` while
#      computing [env], so without shims already on PATH it fails and NO
#      secrets load. Loading shims here makes `fnox` resolvable.
#
# .zshrc then runs a full `mise activate` for interactive shells, which
# supersedes the shims for tool resolution and applies the [env] block.
#
# The absolute path is required: path_helper only runs from /etc/zprofile
# (login shells), so /opt/homebrew/bin is not on PATH yet here.
if [[ -x /opt/homebrew/bin/mise ]]; then
  export MISE_ENV=dev
  eval "$(/opt/homebrew/bin/mise activate zsh --shims)"
fi
