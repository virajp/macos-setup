# Homebrew

`Homebrew` is a package manager for `macOS`. All of the global tools and applications will be installed using `Homebrew`. For local tools (specific to respective projects) will be installed using `mise`.

## Initiate the setup

To initiate the setup we will use the `gist` created on github

```shell
/bin/zsh -c "$(curl -fsSL https://gist.githubusercontent.com/virajp/c542ff926710ddbd2f65490c900018f5/raw/setup.sh)"
```

## Configure

```shell
brew analytics off
```

## Health check

```shell
brew doctor --verbose
```

## Install tools & applications

### Clone the macos-setup repo

```shell
mkdir -p ~/Projects/github.com/virajp && cd ~/Projects/github.com/virajp
git clone git@github.com:virajp/macos-setup.git
```

### Install from Brewfile

```shell
brew bundle --file="$HOME/Projects/github.com/virajp/macos-setup/Brewfile --verbose --no-lock"
```

## Reference

- [Homebrew](https://brew.sh/)
