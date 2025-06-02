# This file will load the shell prompt

# Using starship prompt
if type -q starship
    starship init fish | source
end

# # Using oh-my-posh prompt
# if type -q oh-my-posh
#   oh-my-posh init fish --config ~/.config/oh-my-posh.yaml | source
# end
