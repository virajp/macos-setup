# Install Tools via Homebrew

## Configure bash

```bash
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
```

## Upgrade pip, setuptools and wheel (python)

```bash
pip3 install --upgrade pip setuptools wheel
```

## NodeJS & tools

- `NodeJS`: NodeJS
- `NPM`: Node Package Manager
- `TypeScript`: TypeScript

### Install NodeJS & npm

```bash
brew install --formulae node
```

## Configure npm

```bash
npm config set fund false
```

### Install TypeScript & Firebase-Tools

> Note that the side effect of installing typescript like this is that it will be only available for the specific version of node. When you switch to another version of node, you will have to install typescript again.

```bash
npm install --global typescript firebase-tools
```

## Flutter & tools

> Refer to this document for Flutter installation: [Flutter](https://github.com/95octane/wiki/blob/main/engineering/setup/flutter.md)

## Miscellaneous tools

`Logitech-Options+`: Logitech Mouse Driver & Configuration. Note that the new tool (Options+) is only available for download from Logitech website.

[Download Logitech Options+](https://support.logi.com/hc/en-gb/articles/4418699283607)

## SetApp

SetApp will be installed via Homebrew. To install apps from SetApp, simply go into `Favorites` and click on `Install All` button to install all the apps from the section.

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
