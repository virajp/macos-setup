##########################################################################
# .zshenv is sourced for EVERY zsh invocation - login, interactive, and   #
# scripts. Keep it minimal: only what non-interactive shells need.        #
##########################################################################

# echo "Start: $(date)"

# Load all ZSH configuration
for f in ~/.config/zsh/*.zsh(N); do
  # echo "$(date): $f"
  source "$f"
done
