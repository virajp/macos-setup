# dotfiles

This is a collection of my dotfiles. I use these to configure my system to my
liking.

## Installation

I use [mise](https://mise.jdx.dev/) to manage my dotfiles. This directory
mirrors `$HOME`: every file sits at the path it is linked to, and
`dotfiles.root` in [`.config/mise/config.toml`](./.config/mise/config.toml)
points mise here. Each topic's links are declared in the `[dotfiles]` table of
its own `.config/mise/conf.d/<topic>.toml` (e.g. `shell.toml` links
`~/.config/fish` and `~/.zshrc`), next to that topic's packages and settings.
`mise bootstrap` applies them from any directory, together with the rest of the
machine declaration (see [CONFIG_DOCUMENTATION.md](./CONFIG_DOCUMENTATION.md)).

```shell
mise run dotfiles:install   # create the symlinks
mise run dotfiles:status    # show which symlinks are missing
mise run dotfiles:delete    # remove the symlinks
```

## Adding a dotfile

Add the file under `dotfiles/` at its `$HOME` path, add a `[dotfiles]` entry for
it to the matching `.config/mise/conf.d/<topic>.toml`, then run
`mise run dotfiles:install`.

## Reference

- [mise dotfiles](https://mise.jdx.dev/dotfiles.html)
- [mise bootstrap](https://mise.jdx.dev/bootstrap.html)
