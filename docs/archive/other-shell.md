# Shell

## Change the default shell

### List available shells

```bash
cat /etc/shells
```

### Change shell

```bash
chsh -s /opt/homebrew/bin/zsh
```

## Default macOS shell (ZSH)

Symlink the `.zprofile` & `.zshrc` files to the home directory.

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/zsh_profile.zsh" "$HOME/.zprofile" && source "$HOME/.zprofile"
```

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/zsh_rc.zsh" "$HOME/.zshrc" && source "$HOME/.zshrc"
```

## Bash shell

Symlink the `.bash_profile` file to the home directory.

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/bash_profile.sh" "$HOME/.bash_profile" && source "$HOME/.bash_profile"
```

## Fish shell

Symlink the `.config/fish` folder to the home directory.

```bash
mkdir -p "$HOME/.config" && ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/fish-personal" "$HOME/.config/fish"
```
