# Shell

The login shell is set by `mise bootstrap` (`[bootstrap.user]` in
`dotfiles/mise/conf.d/system.toml`): it adds `/opt/homebrew/bin/fish` to
`/etc/shells` and runs `chsh`. Homebrew's `bash` and `zsh` are added to
`/etc/shells` by the `line` entries at the end of `[dotfiles]`.

```shell
mise bootstrap user status
mise bootstrap user apply
```
