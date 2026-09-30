# Shell

The login shell is set by `mise bootstrap` (`[bootstrap.user]` in
`dotfiles/.config/mise/conf.d/shell.toml`): it adds `/opt/homebrew/bin/fish` to
`/etc/shells` and runs `chsh`. Homebrew's `bash` and `zsh` are added to
`/etc/shells` by the `line` entries in its `[dotfiles]` table.

```shell
mise bootstrap user status
mise bootstrap user apply
```
