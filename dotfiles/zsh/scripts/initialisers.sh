## FZF initialiser
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide initialiser
eval "$(zoxide init zsh)"

# GitHub Copilot CLI integration
# eval "$(gh copilot alias -- zsh)"

# Initialize starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Initialize oh-my-posh (commented out - using starship instead)
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh.yaml)"
# fi
