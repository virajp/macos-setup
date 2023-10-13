# Shell

## Change the default shell

> List available shells

```bash
cat /etc/shells
```

> Change shell

```bash
chsh -s /opt/homebrew/bin/zsh
```

## Default macOS shell (ZSH)

Symlink the `.p10k.zsh`, `.zprofile` & `.zshrc` files to the home directory.

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/p10k.zsh" "$HOME/.p10k.zsh"
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/zsh_profile.zsh" "$HOME/.zprofile" && source "$HOME/.zprofile"
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/zsh_rc.zsh" "$HOME/.zshrc" && source "$HOME/.zshrc"
```

## Bash shell

Symlink the `.bash_profile` file to the home directory.

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/bash_profile.sh" "$HOME/.bash_profile" && source "$HOME/.bash_profile"
```

## Fish shell (preferred)

Symlink the `.config/fish` folder to the home directory.

```bash
# Personal setup
mkdir -p "$HOME/.config" && ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/fish-personal" "$HOME/.config/fish"
```

## Symlink other tool configuration

```bash
# Setup .ssh folder
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Secure/SSH-Keys/" "$HOME/.ssh"
# chmod 600 $HOME/.ssh/id_*

# Setup gpg (gnupg) folder
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Secure/gnupg/" "$HOME/.gnupg"
chmod 0700 $HOME/.gnupg

# Setup global gitignore
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/gitignore_global" "$HOME/.gitignore_global"
# For Personal
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/gitconfig" "$HOME/.gitconfig"

# Setup gh 
mkdir -p ~/.config/gh; ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/gh/config.yml" "$HOME/.config/gh/config.yml"

# Setup Docker
mkdir -p "$HOME/.docker" && yes | cp -v "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/docker-daemon.json" "$HOME/.docker/daemon.json"

# Setup kubectl (k8s client / kubernetes client)
mkdir -p "$HOME/.kube" && ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/kube_config" "$HOME/.kube/config"

# Setup datree
mkdir -p "$HOME/.datree" && ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/datree_config.yaml" "$HOME/.datree/config.yaml"

# Setup dnsmasq
# ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/dnsmasq.conf" "/usr/local/etc/dnsmasq.conf"
# sudo brew services start dnsmasq

# Setup visual studio code workspaces
mkdir -pv $HOME/Projects/github.com/OpenServiceFramework
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/workspaces/osf.code-workspace" "$HOME/Projects/github.com/OpenServiceFramework/osf.code-workspace"
mkdir -pv $HOME/Projects/github.com/95octane
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/workspaces/95octane.code-workspace" "$HOME/Projects/github.com/95octane/95octane.code-workspace"
# mkdir -pv $HOME/Projects/github.com/propacy.com
# ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/workspaces/propacy.code-workspace" "$HOME/Projects/github.com/propacy.com/propacy.code-workspace"
# mkdir -pv $HOME/Projects/github.com/tixmantra.com
# ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/workspaces/tixmantra.code-workspace" "$HOME/Projects/github.com/tixmantra.com/tixmantra.code-workspace"
```
