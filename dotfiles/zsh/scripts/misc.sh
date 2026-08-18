# Only bootstrap variables belong here. Everything else lives in mise's [env]
# block (dotfiles/mise/config.toml), which both fish and zsh pick up on
# activation.
#
# GPG_TTY must be evaluated per-session against the live terminal, so mise
# cannot provide it - its [env] is evaluated in a subprocess.

# GPG
export GPG_TTY="$(tty)"
