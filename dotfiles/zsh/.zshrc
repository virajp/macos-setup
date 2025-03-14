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
source ~/.config/zsh/initialisers.sh

# echo "Initialisers: $(date)"

# Aliases and functions
source ~/.config/zsh/aliases.sh
source ~/.config/zsh/functions.sh
source ~/.config/zsh/upgrades.sh
source ~/.config/zsh/95octane.sh

# echo "Aliases, Functions, Upgrades, 95octane: $(date)"
