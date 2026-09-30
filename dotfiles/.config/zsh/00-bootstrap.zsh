# Only bootstrap variables belong here. Everything else lives in mise's [env]
# block (dotfiles/.config/mise/conf.d/), which both fish and zsh pick up on
# activation.
#
# GPG_TTY must be evaluated per-session against the live terminal, so mise
# cannot provide it - its [env] is evaluated in a subprocess.

# GPG
export GPG_TTY="$(tty)"

# Mise environment
export MISE_ENV="dev"

# fnox config dir
export FNOX_CONFIG_DIR="$HOME/.config/fnox"

# Local bin directory for user-installed executables
export PATH="${PATH}:${HOME}/.local/bin"
