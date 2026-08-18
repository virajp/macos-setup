# Only the shellenv bootstrap lives here. The HOMEBREW_* behaviour flags moved
# to mise's [env] block - `brew` reads them at runtime, not during startup.
#
# This must run BEFORE mise activates in .zshrc: mise wins PATH precedence by
# prepending, so anything touching PATH after it takes precedence back.

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
