# =============================================================================
# Bash Configuration
# =============================================================================

# Load all BASH configuration
for f in ~/.config/bash/*.bash(N); do
  # echo "$(date): $f"
  source "$f"
done
