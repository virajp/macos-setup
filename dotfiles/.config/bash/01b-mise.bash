# =============================================================================
# Mise activation
# =============================================================================

# mise activate
# Setting up mise trusted paths
export MISE_TRUSTED_CONFIG_PATHS="$HOME/.config/mise:$HOME/Projects"
# MISE_ENV must be set as "dev"
export MISE_ENV="dev"
# Must run after `brew shellenv` and the PATH exports
if [[ -x "${HOME}/.local/bin/mise" ]]; then
  # echo "Activating mise ... "
  if [[ $- == *i* ]]; then
    # Interactive shell
    eval "$("${HOME}/.local/bin/mise" activate bash)"
  else
    # Non-interactive shell
    eval "$("${HOME}/.local/bin/mise" activate bash --shims)"
  fi
fi
# End of mise activation
