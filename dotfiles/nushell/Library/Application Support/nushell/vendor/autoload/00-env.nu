use std/util "path add"

# WHY: iCloud Drive path for accessing synced secrets across devices
# Cloud Path
$env.CLOUD_PATH = ($env.HOME | path join "Library/Mobile Documents/com~apple~CloudDocs")

# WHY: Load API keys and secrets from encrypted iCloud file
# Load secrets (environment variables)
open ($env.CLOUD_PATH | path join "Secure/secrets.json") | load-env

# NodeJS environment variables
$env.NODE_ENV = "development"

# WHY: Java development environment setup
# Java environment variables
$env.JAVA_HOME = ($env.HOMEBREW_PREFIX | path join "opt/openjdk")
$env.CPPFLAGS = ["-I", ($env.JAVA_HOME | path join "include")] | str join

# WHY: Use Brave instead of Chrome for Flutter web development
# Set Chrome executable path to Brave
$env.CHROME_EXECUTABLE = ($env.HOME | path join "Applications/Brave Browser.app/Contents/MacOS/Brave Browser")

# Following setting is used to determine environment
$env.RUNTIME_ENV = "development"

# WHY: Docker optimization settings for better build performance
# Docker environment variables
$env.DOCKER_BUILDKIT = 1
$env.COMPOSE_DOCKER_CLI_BUILD = 1
# WHY: Force AMD64 for compatibility with production environments
$env.DOCKER_DEFAULT_PLATFORM = "linux/amd64"
$env.DOCKER_HIDE_LEGACY_COMMANDS = 1
$env.BUILDKIT_PROGRESS = "auto"
