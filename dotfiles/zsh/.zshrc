##########################################################################
# .zshrc file is used to set aliases, functions, and other shell options #
# that should be available every time a new zsh shell is started         #
##########################################################################

# echo "Start: $(date)"

# Setup all environment variables
source ~/.config/zsh/misc.sh
source ~/.config/zsh/homebrew.sh
source ~/.config/zsh/zinit.sh
source ~/.config/zsh/dev.sh
source ~/.config/zsh/gcp.sh

# Import secrets (environment variables)
# source "${CLOUD_PATH}/Secure/secrets.sh"

# echo "Setup environment variables: $(date)"

# Path
export PATH="${HOMEBREW_PREFIX}/opt/curl/bin:${PATH}"

# Created by `pipx` on 2024-03-15 06:20:45
export PATH="${PATH}:/Users/virajpatel/.local/bin"

# mise activate
# Must run after `brew shellenv` and the PATH exports above: mise wins
# precedence by prepending, so anything touching PATH after this steals it.
# .zshenv handles the non-interactive (--shims) half; .zshrc is interactive-only.
export MISE_ENV=dev
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Initialisers
source ~/.config/zsh/initialisers.sh

# echo "Initialisers: $(date)"

# Aliases and functions
source ~/.config/zsh/aliases.sh
source ~/.config/zsh/functions.sh
source ~/.config/zsh/upgrades.sh
source ~/.config/zsh/95octane.sh

# echo "Aliases, Functions, Upgrades, 95octane: $(date)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/virajpatel/.lmstudio/bin"
# End of LM Studio CLI section
