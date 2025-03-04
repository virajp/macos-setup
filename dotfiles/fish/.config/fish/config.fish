# Initialize oh-my-posh
eval "$(oh-my-posh init fish --config ~/.config/oh-my-posh.yaml)"

# Initialize zoxide
zoxide init fish | source

# Initialize nvm
source ~/.config/fish/functions/nvm.fish
load_nvm > /dev/stderr

# Initialize direnv
direnv hook fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
