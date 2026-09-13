# dotfiles

This is a collection of my dotfiles. I use these to configure my system to my
liking.

## Installation

I use [mise](https://mise.jdx.dev/) to manage my dotfiles. `mise.toml` in this
directory holds the `[dotfiles]` link map — which source file lands at which
`$HOME` path, and in which mode (`symlink`, `symlink-each`). It is a project
config on purpose: the links change when this repo changes, not when the machine
does, so they are applied by a repo task rather than by the machine-wide
`mise bootstrap` (whose declaration lives in `mise/conf.d/`, see
[CONFIG_DOCUMENTATION.md](./CONFIG_DOCUMENTATION.md)).

```shell
mise run dotfiles:install   # create the symlinks
mise run dotfiles:status    # show which symlinks are missing
mise run dotfiles:delete    # remove the symlinks
```

## Adding a dotfile

Add the file under `dotfiles/<pkg>/`, add its entry to `mise.toml` (source paths
are relative to this directory), then run `mise run dotfiles:install`.

## Reference

- [mise dotfiles](https://mise.jdx.dev/dotfiles.html)
- [mise bootstrap](https://mise.jdx.dev/bootstrap.html)
