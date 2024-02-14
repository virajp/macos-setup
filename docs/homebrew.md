# Homebrew

Homebrew is a package manager for macOS. Most of the tools and applications will be installed using Homebrew.

## Install homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Configure

```bash
brew analytics off
```

## Health check

```bash
brew doctor --verbose
```

## Install tools & applications

### Clone the macos-setup repo

```bash
mkdir -p ~/Projects/github.com/virajp && cd ~/Projects/github.com/virajp
git clone git@github.com:virajp/macos-setup.git
```

### Install from Brewfile

```bash
brew bundle --file="$HOME/Projects/github.com/virajp/macos-setup/Brewfile --verbose --no-lock"
```

## Reference

- [Homebrew](https://brew.sh/)
