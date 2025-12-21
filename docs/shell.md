# Shell

## Change the default shell

This should be done only after installing all tools using `Homebrew`.

## Configure all shells

```zsh
zsh -c 'grep -q "^/opt/homebrew/bin/fish$" /etc/shells || echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells'
zsh -c 'grep -q "^/opt/homebrew/bin/bash$" /etc/shells || echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells'
zsh -c 'grep -q "^/opt/homebrew/bin/zsh$" /etc/shells || echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells'
```

## Configure `fish` as default shell

```zsh
chsh -s /opt/homebrew/bin/fish
```
