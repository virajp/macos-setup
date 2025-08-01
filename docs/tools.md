# Install Tools via Homebrew

## Configure bash

```shell
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
```

## Upgrade pip, setuptools and wheel (python)

```shell
pip3 install --upgrade pip setuptools wheel
```

## NodeJS & tools

### Install fnm (Node Version Manager)

```shell
brew install --formulae fnm
```

### Install NodeJS

```shell
set latest_version (fnm list-remote --latest)
fnm install $latest_version --corepack-enabled && fnm use $latest_version && fnm default $latest_version
corepack enable && corepack prepare pnpm@latest --activate
npm uninstall --global npm
```

## Configure pnpm

```shell
pnpm config --global set fund false
pnpm setup
```

### Install global pnpm packages

```shell
pnpm install --global firebase-tools@latest pnpm@latest prettier@latest
pnpm approve-builds --global
```

## Flutter & tools

> Refer to this document for Flutter installation: [Flutter](https://github.com/95octane/wiki/blob/main/engineering/setup/flutter.md)

## Miscellaneous tools

`Logitech-Options+`: Logitech Mouse Driver & Configuration. Note that the new tool (Options+) is only available for download from Logitech website.

[Download Logitech Options+](https://support.logi.com/hc/en-gb/articles/4418699283607)

## SetApp

SetApp will be installed via Homebrew. To install apps from SetApp, simply go into `Favorites` and click on `Install All` button to install all the apps from the section.

## Configure tools

```shell
# Configure Sublime-Text
open "$HOME/Applications/Sublime Text.app"
# Copy license from 1Password and apply

# Install package control by pressing "cmd+shift+p" and selecting "Install Package Control"

# Now install important packages in sublime (cmd + shift + P)
# - Text Pastry
# - HTML-CSS-JS Prettify
# - Compare Side-by-Side
```
