# Homebrew

Homebrew is a package manager for macOS. Most of the tools and applications will be installed using Homebrew.

## Install homebrew

```bash
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Configure
brew analytics off
brew tap homebrew/cask
brew tap homebrew/cask-fonts

# Health check
brew doctor --verbose
```

## Reference

- [Homebrew](https://brew.sh/)
