# Setup

Global tools and applications (Homebrew formulae, casks, Mac App Store apps) are
declared in `[bootstrap.packages]` of
[`dotfiles/mise.toml`](../dotfiles/mise.toml) and installed by
[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html), which pours Homebrew
bottles itself. `Homebrew` stays installed for `brew services` and the few
packages in the `brew:extras` task. Development tools (global or per project)
are `mise` `[tools]`.

## Setup

The repo is public, so the [`setup`](../setup) script can be run directly from
GitHub. It installs Homebrew (which pulls in the Xcode Command Line Tools) and
`mise`, clones this repo to `~/Projects/github.com/virajp/macos-setup` if it
isn't already present, then runs `mise --cd dotfiles bootstrap --yes`: packages,
dotfile symlinks, macOS defaults, fish as login shell, Touch ID for sudo, and
the pmset/nvram power profile (this last part prompts for `sudo`).

```shell
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/virajp/macos-setup/main/setup)"
```

## Reference

- [mise bootstrap](https://mise.jdx.dev/bootstrap.html)
- [Homebrew](https://brew.sh/)
- [`setup` script](../setup)
