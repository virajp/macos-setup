# DotNet environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# Gem environment variables
export GEM_HOME="$HOME/.gem"

# GoLang environment variables
export GOPATH="$HOME/Projects/golang"

# Helm
export HELM_EXPERIMENTAL_OCI=1

# NodeJS environment variables
export NODE_ENV="development"

# Java environment variables
export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk@21"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openjdk@21/include"

# Android SDK Path
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"

# Set Chrome executable path to Brave
export CHROME_EXECUTABLE="$HOME/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Following setting is used to determine environment
export RUNTIME_ENV="development"
