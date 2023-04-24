# Install Tools via Homebrew

## Utilities

```bash
# Install Git & CoreUtils. 
# NOTE: Git (Apple) is of older version and the new git path has to be setup in PATH environment variable.
# CoreUtils: this is primarily required to run "sha256sum" cli
# Bash: Upgrade bash on macOS (even if you are not planning to use it directly, you need it for many of your scripts)
# Python: Python3
brew install --formulae git gh coreutils bash python wget ipcalc watch httping

# Configure bash
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells

# Upgrade pip, setuptools and wheel (python)
pip3 install --upgrade pip setuptools wheel
```

## Tools

```bash
# iTerm2: Terminal
# Sublime Text: Text Editor
# Alfred: Spotlight replacement
# Spectacle: Window Manager
# Bartender: Menu Bar Manager
# Authy: 2FA
# Firefox: Browser
# Notion: Note taking
# TaskExplorer: Task Manager
# EasyFind: File Search
brew install --cask iterm2 sublime-text alfred spectacle bartender authy firefox notion taskexplorer easyfind

# 1Password: Password Manager
brew install --appdir=/Applications --cask 1password

# Spotify: Music
# MKVToolNix: MKV Tools
# VLC: Video Player
# Folx: Download Manager
# Handbrake: Video Converter
brew install --cask spotify mkvtoolnix vlc folx handbrake
```

## Developer Tools

```bash
# Dive: Docker Image Analyzer
# mkcert: A simple zero-config tool to make locally trusted development certificates with any names you'd like.
# skaffold: Easy and Repeatable Kubernetes Development
# helm: The Kubernetes Package Manager
brew install --formulae dive mkcert skaffold helm

# Google Cloud SDK (gcloud, gsutil, etc.); Firebase-Cli is installed via Volta (NodeJS)
brew install --cask google-cloud-sdk

# Terraform: Infrastructure as Code
brew install --cask terraform

# Visual Studio Code: IDE
brew install --cask  visual-studio-code

# Github: Github Desktop App
brew install --cask github 

# Codux: Visual IDE
brew install --cask codux

# Steampipe: SQL for Cloud resources
brew install --formulae turbot/tap/steampipe
```

## NodeJS & tools

> We will be using `Volta` to manage NodeJS versions and packages.

```bash
# Install Volta
brew install --formulae volta

# Configure Volta for fish shell
volta setup --verbose
volta completions fish --force --output ~/.config/fish/completions/volta.fish

# Install NodeJS, NPM, Yarn, TypeScript, Firebase CLI
volta install node@lts node@latest npm@latest yarn@latest typescript@latest firebase-cli@latest

# Configure NPM
npm config set fund false


```

## Archived Tools

```bash
# Install alternate to Docker-Desktop (colima)
# brew install --formulae docker docker-buildx docker-scan kubectl colima minikube

# Lens: Kubernetes IDE
# brew install --cask lens

# Install packer
# brew install --formulae packer 

# CNCF BuildPacks (buildpacks.io)
# brew install --formulae buildpacks/tap/pack

# Dash: API Documentation Browser and Code Snippet Manager
# brew install --cask dash

# Postman: API Development Environment
# brew install --cask postman

# dotNET SDK
# brew install --cask dotnet-sdk

# Install Flutter (requires Rosetta)
# brew install --cask flutter android-studio
# brew install --formulae cocoapods openjdk
# Start android studio and install android-sdk
# flutter config --android-sdk="/Users/virajpatel/Library/Android/sdk"
# Install Android SDK Command Line tools from Preferences/System Settings/Android SDK/SDK Tools
# mas install 497799835 # Install XCode
# sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
# sudo xcodebuild -runFirstLaunch
# flutter doctor --android-licenses
# flutter config --no-analytics --enable-web --enable-ios --enable-android --no-enable-linux-desktop --no-enable-macos-desktop --no-enable-windows-desktop --no-enable-fuchsia --no-enable-custom-devices

# Install drivers (if needed)
# brew install --cask homebrew/cask-drivers/logitech-options
```

## Configure tools

```bash
# Configure Spectacle
open "$HOME/Applications/Spectacle.app"

# Configure Alfred
open "$HOME/Applications/Alfred 5.app"
# Copy license from 1Password and paste it when asked

# Configure Sublime-Text
open "$HOME/Applications/Sublime Text.app"
# Copy license from 1Password and apply

# Install package control by pressing "cmd+shift+p" and selecting "Install Package Control"

# Now install important packages in sublime (cmd + shift + P)
# - Text Pastry
# - HTML-CSS-JS Prettify
# - Compare Side-by-Side
```
