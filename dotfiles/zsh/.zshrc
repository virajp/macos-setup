##########################################################################
# .zshrc file is used to set aliases, functions, and other shell options #
# that should be available every time a new zsh shell is started         #
##########################################################################

# echo "Start: $(date)"

# Load all ZSH configuration
for f in ~/.config/zsh/*.zsh(N); do
  echo "$(date): $f"
  source "$f"
done
