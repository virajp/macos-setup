# DotNet environment variables
set --global --export DOTNET_CLI_TELEMETRY_OPTOUT true

# Gem environment variables
set --global --export GEM_HOME "$HOME/.gem"

# GoLang environment variables
set --global --export GOPATH "$HOME/Projects/golang"

# Helm
set --global --export HELM_EXPERIMENTAL_OCI 1

# NodeJS environment variables
set --global --export NODE_ENV "development"

# Java environment variables
set --global --export JAVA_HOME "$HOMEBREW_PREFIX/opt/openjdk"
set --global --export CPPFLAGS "-I$HOMEBREW_PREFIX/opt/openjdk/include"

# Android SDK Path
set --global --export ANDROID_HOME "$HOMEBREW_PREFIX/share/android-commandlinetools"

# Set Chrome executable path to Brave
set --global --export CHROME_EXECUTABLE "$HOME/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Following setting is used to determine environment
set --global --export RUNTIME_ENV "development"
