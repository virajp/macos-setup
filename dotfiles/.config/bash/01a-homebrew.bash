# Homebrew activate
if command -v brew >/dev/null 2>&1; then
  # If you're using macOS, you'll want this enabled
  # echo "Activating homebrew ... "
  eval "$(brew shellenv)"
fi
