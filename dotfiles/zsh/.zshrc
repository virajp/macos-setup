##########################################################################
# .zshrc file is used to set aliases, functions, and other shell options #
# that should be available every time a new zsh shell is started         #
##########################################################################

# echo "Start: $(date)"

# Setup all environment variables
# Only bootstrap vars live here now; the rest come from mise's [env] block,
# applied by `mise activate` below.
source ~/.config/zsh/misc.sh
source ~/.config/zsh/homebrew.sh
source ~/.config/zsh/zinit.sh

# echo "Setup environment variables: $(date)"

# Path
export PATH="${HOMEBREW_PREFIX}/opt/curl/bin:${PATH}"

# Created by `pipx` on 2024-03-15 06:20:45
export PATH="${PATH}:${HOME}/.local/bin"

# mise activate
# Must run after `brew shellenv` and the PATH exports above: mise wins
# precedence by prepending, so anything touching PATH after this steals it.
# Aliases and functions arrive here too, from [shell_alias] and [tasks] -
# which is why there is no longer an aliases.sh or functions.sh.
# .zshenv loads shims first; see the comment there for why that is required.
export MISE_ENV=dev
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Shell options: history, keybindings, completion styling
source ~/.config/zsh/zsh.sh

# Initialisers
source ~/.config/zsh/initialisers.sh

# echo "Initialisers: $(date)"
