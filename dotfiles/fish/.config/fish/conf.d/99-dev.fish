# DotNet environment variables
set --universal --export DOTNET_CLI_TELEMETRY_OPTOUT true

# Gem environment variables
set --universal --export GEM_HOME "$HOME/.gem"

# GoLang environment variables
set --universal --export GOPATH "$HOME/Projects/golang"

# Helm
set --universal --export HELM_EXPERIMENTAL_OCI 1

# NodeJS environment variables
set --universal --export NODE_ENV "development"

# Java environment variables
set --universal --export JAVA_HOME "$HOMEBREW_PREFIX/opt/openjdk"
set --universal --export CPPFLAGS "-I$HOMEBREW_PREFIX/opt/openjdk/include"

# Android SDK Path
set --universal --export ANDROID_HOME "/opt/homebrew/share/android-commandlinetools"

# Set Chrome executable path to Brave
set --universal --export CHROME_EXECUTABLE "$HOME/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Following setting is used to determine environment
set --universal --export RUNTIME_ENV "development"
