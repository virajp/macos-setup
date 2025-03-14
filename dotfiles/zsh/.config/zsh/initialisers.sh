## FZF initialiser
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide initialiser
eval "$(zoxide init zsh)"

# Initialize direnv
eval "$(direnv hook zsh)"

# GitHub Copilot CLI integration
# eval "$(gh copilot alias -- zsh)"

# Initialize oh-my-posh
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh.yaml)"
# fi
