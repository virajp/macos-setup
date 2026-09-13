# dotfiles

This is a collection of my dotfiles. I use these to configure my system to my
liking.

## Installation

I use [mise](https://mise.jdx.dev/) to manage my dotfiles.
`mise/conf.d/dotfiles.toml` holds the `[dotfiles]` link map — which source file
lands at which `$HOME` path, and in which mode (`symlink`, `symlink-each`,
`line`). It is part of the global mise config (`mise/` is linked to
`~/.config/mise`), so these work from any directory:

```shell
mise bootstrap dotfiles apply     # create the symlinks
mise bootstrap dotfiles status    # show which symlinks are missing
mise bootstrap dotfiles unapply   # remove the symlinks
```

The rest of the machine declaration (`[bootstrap.*]`) lives in the sibling
`mise/conf.d/*.toml` files, see
[CONFIG_DOCUMENTATION.md](./CONFIG_DOCUMENTATION.md).

## Adding a dotfile

Add the file under `dotfiles/<pkg>/`, add its entry to
`mise/conf.d/dotfiles.toml` (source paths are relative to that directory, so
`../../<pkg>/<file>`), then run `mise bootstrap dotfiles apply`.

## Reference

- [mise dotfiles](https://mise.jdx.dev/dotfiles.html)
- [mise bootstrap](https://mise.jdx.dev/bootstrap.html)
