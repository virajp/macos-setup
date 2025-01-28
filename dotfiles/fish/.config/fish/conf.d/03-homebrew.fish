# Homebrew

if test -f "/opt/homebrew/bin/brew"
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv fish)"
end

set --universal --export HOMEBREW_NO_ANALYTICS true
set --universal --export HOMEBREW_CURL_RETRIES 2
set --universal --export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 7
set --universal --export HOMEBREW_CLEANUP_MAX_AGE_DAYS 7
set --universal --export HOMEBREW_DISPLAY_INSTALL_TIMES true
set --universal --export HOMEBREW_FAIL_LOG_LINES 100
set --universal --export HOMEBREW_FORCE_BREWED_CURL true
set --universal --export HOMEBREW_FORCE_BREWED_GIT true
set --universal --export HOMEBREW_CASK_OPTS "--appdir=~/Applications --caskroom=/opt/homebrew/Caskroom"
set --universal --export HOMEBREW_NO_ENV_HINTS 1
