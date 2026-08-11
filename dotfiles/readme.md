# dotfiles

This is a collection of my dotfiles. I use these to configure my system to my
liking.

## Installation

I use [mise](https://mise.jdx.dev/) to manage my dotfiles. `mise.toml` in this
directory holds the `[dotfiles]` link map — which source file lands at which
`$HOME` path, and in which mode (`symlink`, `symlink-each`).

```shell
mise run dotfiles:install   # create the symlinks
mise run dotfiles:status    # show which symlinks are missing
mise run dotfiles:delete    # remove the symlinks
```

## Adding a dotfile

Add the file under `dotfiles/<pkg>/`, add its entry to `mise.toml`, then run
`mise run dotfiles:install`.

## Reference

- [mise bootstrap dotfiles](https://mise.jdx.dev/cli/bootstrap/dotfiles.html)
