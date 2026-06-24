# Setup

`Homebrew` is a package manager for `macOS`. All of the global tools and
applications will be installed using `Homebrew`. For local or development tools
(global or specific to projects) will be installed using `mise`.

## Setup

The repo is public, so the [`setup`](../setup) script can be run directly from
GitHub. It installs Homebrew (which pulls in the Xcode Command Line Tools),
clones this repo to `~/Projects/github.com/virajp/macos-setup` if it isn't
already present, then installs the brewfile, symlinks the dotfiles, and applies
the macOS defaults.

```shell
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/virajp/macos-setup/main/setup)"
```

## Reference

- [Homebrew](https://brew.sh/)
- [`setup` script](../setup)
