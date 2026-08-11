# Homebrew

# if ("/opt/homebrew/bin/brew" | path exists) {
#   let SHELL_ENV = (/opt/homebrew/bin/brew shellenv nushell)
#   exec $SHELL_ENV
# }

$env.HOMEBREW_NO_ANALYTICS = true
$env.HOMEBREW_CURL_RETRIES = 2
$env.HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS = 7
$env.HOMEBREW_CLEANUP_MAX_AGE_DAYS = 7
$env.HOMEBREW_DISPLAY_INSTALL_TIMES = true
$env.HOMEBREW_FAIL_LOG_LINES = 100
$env.HOMEBREW_FORCE_BREWED_CURL = true
$env.HOMEBREW_FORCE_BREWED_GIT = true
$env.HOMEBREW_CASK_OPTS = "--appdir=~/Applications --caskroom=/opt/homebrew/Caskroom"
$env.HOMEBREW_NO_ENV_HINTS = 1
