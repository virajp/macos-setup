# Homebrew activate
if command -v brew >/dev/null 2>&1; then
  # If you're using macOS, you'll want this enabled
  echo "Activating homebrew ... "
  eval "$(brew shellenv)"
fi

# mise activate
# Must run after `brew shellenv` and the PATH exports
if command -v mise >/dev/null 2>&1; then
  echo "Activating mise ... "
  eval "$(mise activate zsh)"
fi

# zoxide initialiser
if command -v zoxide >/dev/null 2>&1; then
  echo "Activating zoxide ... "
  eval "$(zoxide init zsh)"
fi

# GitHub Copilot CLI integration
# eval "$(gh copilot alias -- zsh)"

# Initialize starship prompt
if command -v starship >/dev/null 2>&1; then
  echo "Activating starship ... "
  eval "$(starship init zsh)"
fi
