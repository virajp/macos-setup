# zoxide initialiser only for interactive shells
if [[ -o interactive ]]; then
  if command -v zoxide >/dev/null 2>&1; then
    # echo "Activating zoxide ... "
    eval "$(zoxide init zsh)"
  fi
fi

# GitHub Copilot CLI integration
# eval "$(gh copilot alias -- zsh)"

# Initialize starship prompt only for interactive shells
if [[ -o interactive ]]; then
  if command -v starship >/dev/null 2>&1; then
    # echo "Activating starship ... "
    eval "$(starship init zsh)"
  fi
fi
