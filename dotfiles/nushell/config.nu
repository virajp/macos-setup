# Loading sequence:
# 1. env.nu
# 2. config.nu
# 3. All files from "vendor/autoload" directory
# 4. login.nu

# WHY: Hardcoded to Apple Silicon path instead of dynamic detection
# This ensures consistent path resolution across all nushell sessions
# Set HOMEBREW_PREFIX environment variable
$env.HOMEBREW_PREFIX = "/opt/homebrew"

# Set GEM_HOME environment variable
$env.GEM_HOME = ($env.HOME | path join ".gem")

# Set ANDROID_HOME environment variable
$env.ANDROID_HOME = ($env.HOMEBREW_PREFIX | path join "share/android-commandlinetools")

# Set path
use std/util "path add"
path add ($env.HOMEBREW_PREFIX | path join "bin")
path add ($env.HOMEBREW_PREFIX | path join "sbin")
path add ($env.HOMEBREW_PREFIX | path join "opt/curl/bin")
path add ($env.HOMEBREW_PREFIX | path join "opt/ruby/bin")
path add ($env.HOMEBREW_PREFIX | path join "opt/openjdk/bin")
path add ($env.HOMEBREW_PREFIX | path join "share/android-commandlinetools")
path add ($env.HOME | path join ".pub-cache/bin")
path add ($env.HOME | path join ".orbstack/bin")
path add ($env.HOME | path join ".local/bin")
path add ($env.GEM_HOME | path join "bin")
path add ($env.ANDROID_HOME | path join "cmdline-tools/latest/bin")

# WHY: Clean startup without nushell version banner
# Disable banner at startup
$env.config.show_banner = false

# WHY: SQLite for better performance and larger history size
# History configuration
$env.config.history = {
  file_format: sqlite
  max_size: 5_000_000
  sync_on_enter: true
  isolation: true
}

# WHY: Safety feature - use macOS Trash instead of permanent deletion
# Always use Trash for rm
$env.config.rm.always_trash = true

# WHY: Sublime Text for quick file editing from terminal
# Set sublime as editor
$env.config.buffer_editor = "/opt/homebrew/bin/subl"

# WHY: Custom datetime format for consistency across tools
# Datetime format
$env.config.datetime_format.normal = "%d/%m/%y %I:%M:%S%p"

# Create oh-my-posh init file
# oh-my-posh init nu --print --config ~/.config/oh-my-posh.yaml | save --force ($nu.default-config-dir | path join "vendor/autoload/01-oh-my-posh.nu")

# Create the zoxide (cd) init file
# zoxide init nushell | save --force ($nu.default-config-dir | path join "vendor/autoload/02-zoxide.nu")
