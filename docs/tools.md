# Install Tools via Homebrew

## Utilities

### Tools that are required for day to day work

- `Git` (Apple) is of older version and the new git path has to be setup in PATH environment variable.
- `CoreUtils`: this is primarily required to run "sha256sum" cli
- `Bash`: Upgrade bash on macOS (even if you are not planning to use it directly, you need it for many of your scripts)
- `Python`: Python3
- `Wget`: Download files from the internet
- `ipcalc`: IP Calculator
- `watch`: Run a command repeatedly, displaying its output and errors (the first screenfull). This allows you to watch the program output change over time. By default, the program is run every 2 seconds; use -n or --interval to specify a different interval.
- `httping`: Ping-like tool for http-requests 
- `prettyping`: prettyping is a wrapper around the standard ping tool with the objective of making the output prettier, more colorful, more compact, and easier to read.
- `bat`: A cat clone with wings.
- `fzf`: A command-line fuzzy finder.
- `exa`: A modern replacement for ls.
- `diff-so-fancy`: Good looking diffs. Actually… nah… The best-lookin' diffs. :tada:
- `tree`: A recursive directory listing command that produces a depth indented listing of files.

```bash
brew install --formulae git gh coreutils bash python wget ipcalc watch httping prettyping bat fzf exa diff-so-fancy tree
```

### Configure bash

```bash
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
```

### Upgrade pip, setuptools and wheel (python)
  
```bash
pip3 install --upgrade pip setuptools wheel
```

## Tools

- `iTerm2`: Terminal
- `Sublime` Text: Text Editor
- `Authy`: 2FA
- `Firefox`: Browser
- `Notion`: Note taking
- `TaskExplorer`: Task Manager
- `EasyFind`: File Search
- `Raycast`: Spotlight alternative

```bash
brew install --cask iterm2 sublime-text authy firefox notion taskexplorer easyfind raycast
```

- `1Password`: Password Manager

```bash
brew install --appdir=/Applications --cask "1password"
```

- `MKVToolNix`: MKV Tools
- `VLC`: Video Player
- `Folx`: Download Manager
- `Handbrake`: Video Converter

```bash
brew install --cask mkvtoolnix vlc folx handbrake
```

## Developer Tools

- `Dive`: Docker Image Analyzer
- `mkcert`: A simple zero-config tool to make locally trusted development certificates with any names you'd like.
- `skaffold`: Easy and Repeatable Kubernetes Development
- `helm`: The Kubernetes Package Manager
- `terraform`: Infrastructure as Code
- `d2`: Modern diagram scripting language that turns text to diagrams

```bash
brew install --formulae dive mkcert skaffold helm terraform d2
```

- `GitHub Desktop`: Git GUI
- `Google Cloud SDK` (gcloud, gsutil, etc.); Firebase-Cli is installed via Volta (NodeJS)
- `Visual Studio Code`: Code Editor

```bash
brew install --cask github google-cloud-sdk  visual-studio-code
```

## NodeJS & tools

- `NodeJS`: NodeJS
- `NPM`: Node Package Manager
- `Yarn`: Package Manager
- `TypeScript`: TypeScript
- `Deno`: Secure runtime for JavaScript and TypeScript

```bash
brew install --formulae node npm yarn typescript deno
```

- Configure NodeJS & tools

```bash
npm config set fund false
yarn config set --home enableTelemetry 0
```

## Flutter & tools

> Refer to this document for Flutter installation: [Flutter](https://github.com/95octane/wiki/blob/main/engineering/sdlc/flutter.md)

## Miscellaneous tools

`Logitech-Options+`: Logitech Mouse Driver & Configuration. Note that the new tool (Options+) is only available for download from Logitech website.

[Download Logitech Options+](https://support.logi.com/hc/en-gb/articles/4418699283607)

## SetApp

First install SetApp using Homebrew

```bash
brew install --cask setapp
```

Then install the following apps from SetApp

- `CleanMyMac X`: System Cleaner
- `Bartender`: Menu Bar Manager
- `BusyContacts`: Contacts Manager
- `Dash`: Documentation Browser
- `DevUtils`: Developer Utilities
- `Downie`: Video Downloader
- `Folx`: Download Manager
- `Flinto`: Prototyping Tool
- `Flow`: Animation Tool
- `ForkLift`: File Manager
- `Marked`: Markdown Previewer
- `Mockuuups Studio`: Mockup Tool
- `One Switch`: System Utility
- `Permute`: Media Converter
- `RapidAPI`: API Manager
- `Typeface`: Font Manager

## Configure tools

```bash
# Configure Sublime-Text
open "$HOME/Applications/Sublime Text.app"
# Copy license from 1Password and apply

# Install package control by pressing "cmd+shift+p" and selecting "Install Package Control"

# Now install important packages in sublime (cmd + shift + P)
# - Text Pastry
# - HTML-CSS-JS Prettify
# - Compare Side-by-Side
```
