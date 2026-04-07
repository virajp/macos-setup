# ZSH Shell

ZSH is the default macOS shell, but we will install the latest version from
homebrew.

## Configuration

> - Make ZSH (brew version) as default shell (you will be asked to enter
>   password)

```shell
echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells
```

```shell
chsh -s /opt/homebrew/bin/zsh
```

> - Exit the terminal and open a new terminal to see the changes.
