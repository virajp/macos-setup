##########################################################################
# .zshrc file is used to set aliases, functions, and other shell options #
# that should be available every time a new zsh shell is started         #
##########################################################################

# echo "Start: $(date)"

# Setup all environment variables
source ~/.config/shell/misc.sh
source ~/.config/shell/homebrew.sh
source ~/.config/shell/zinit.sh
source ~/.config/shell/dev.sh
source ~/.config/shell/gcp.sh

# Import secrets (environment variables)
source "${CLOUD_PATH}/Secure/secrets.sh"

# echo "Setup environment variables: $(date)"

# Path
export PATH="${HOMEBREW_PREFIX}/opt/curl/bin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:${PATH}"
export PATH="${HOME}/.pub-cache/bin:${PATH}"
export PATH="${GEM_HOME}/bin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/opt/openjdk/bin:${PATH}"
export PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:${PATH}"

# Created by `pipx` on 2024-03-15 06:20:45
export PATH="${PATH}:/Users/virajpatel/.local/bin"

# Initialisers
source ~/.config/shell/initialisers.sh

# echo "Initialisers: $(date)"

# Aliases and functions
source ~/.config/shell/aliases.sh
source ~/.config/shell/functions.sh
source ~/.config/shell/upgrades.sh
source ~/.config/shell/95octane.sh

# echo "Aliases, Functions, Upgrades, 95octane: $(date)"
