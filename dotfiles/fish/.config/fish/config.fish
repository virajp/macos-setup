# Initialize oh-my-posh
eval "$(oh-my-posh init fish --config ~/.config/oh-my-posh.yaml)"

# Initialize zoxide
zoxide init fish | source

# Initialize nvm
source ~/.config/fish/functions/nvm.fish
load_nvm > /dev/stderr
