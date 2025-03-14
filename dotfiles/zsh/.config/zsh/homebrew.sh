# Homebrew

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_CURL_RETRIES=2
export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=7
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=7
export HOMEBREW_DISPLAY_INSTALL_TIMES=true
export HOMEBREW_FAIL_LOG_LINES=100
export HOMEBREW_FORCE_BREWED_CURL=true
export HOMEBREW_FORCE_BREWED_GIT=true
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --caskroom=/opt/homebrew/Caskroom"
export HOMEBREW_NO_ENV_HINTS=1
