#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Development Environment Variables
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Environment variables referenced:
# - HOMEBREW_PREFIX: Homebrew installation prefix (defined in 01-env.fish)
# - HOME: User home directory (system variable)
#
# Development environment variables defined:
# - DOTNET_CLI_TELEMETRY_OPTOUT: Disable .NET telemetry
# - GEM_HOME: Ruby gems installation directory
# - GOPATH: Go workspace directory
# - HELM_EXPERIMENTAL_OCI: Enable Helm OCI support
# - NODE_ENV: Node.js environment (development)
# - JAVA_HOME: Java installation path
# - CPPFLAGS: C++ compiler flags for Java
# - ANDROID_HOME: Android SDK installation path
# - CHROME_EXECUTABLE: Chrome executable path (using Brave Browser)
# - RUNTIME_ENV: Runtime environment identifier
# =============================================================================

# DotNet environment variables
# set --global --export DOTNET_CLI_TELEMETRY_OPTOUT true

# Gem environment variables
# set --global --export GEM_HOME "$HOME/.gem"

# GoLang environment variables
# set --global --export GOPATH "$HOME/Projects/golang"

# Helm
# set --global --export HELM_EXPERIMENTAL_OCI 1

# NodeJS environment variables
# set --global --export NODE_ENV development

# Java environment variables
# set --global --export JAVA_HOME "$HOMEBREW_PREFIX/opt/openjdk"
# set --global --export CPPFLAGS "-I$HOMEBREW_PREFIX/opt/openjdk/include"

# Android SDK Path
# set --global --export ANDROID_HOME "$HOMEBREW_PREFIX/share/android-commandlinetools"

# Set Chrome executable path to Brave
set --global --export CHROME_EXECUTABLE "$HOME/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Following setting is used to determine environment
# set --global --export RUNTIME_ENV development
