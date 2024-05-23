# Shell

## Change the default shell

This can be done only after installing the latest version of ZSH from Homebrew.

## Symlink configuration files

> Open `Terminal` and run the following commands.

### ZSH shell (`.zprofile` & `.zshrc`)

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/zsh_profile.zsh" "$HOME/.zprofile" && source "$HOME/.zprofile"
```

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/zsh/zsh_rc.zsh" "$HOME/.zshrc" && source "$HOME/.zshrc"
```

### .ssh folder

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Secure/SSH-Keys/" "$HOME/.ssh"
chmod 600 $HOME/.ssh/id_*
```

### Setup gpg (gnupg) folder

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Secure/gnupg/" "$HOME/.gnupg"
chmod 0700 $HOME/.gnupg
```

### Setup global gitignore

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/gitignore_global" "$HOME/.gitignore_global"
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/gitconfig" "$HOME/.gitconfig"
```

### Setup gh

```bash
mkdir -p ~/.config/gh; ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/gh/config.yml" "$HOME/.config/gh/config.yml"
```

### Setup Docker

```bash
mkdir -p "$HOME/.docker" && yes | cp -v "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/docker-daemon.json" "$HOME/.docker/daemon.json"
```

### Setup datree

```bash
mkdir -p "$HOME/.datree" && ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/configs/datree_config.yaml" "$HOME/.datree/config.yaml"
```

### Setup visual studio code workspaces

#### 95octane

```bash
mkdir -pv $HOME/Projects/github.com/95octane
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/workspaces/95octane.code-workspace" "$HOME/Projects/github.com/95octane/95octane.code-workspace"
```

#### OpenServiceFramework (OSF)

```bash
# mkdir -pv $HOME/Projects/github.com/OpenServiceFramework
# ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/workspaces/osf.code-workspace" "$HOME/Projects/github.com/OpenServiceFramework/osf.code-workspace"
```

## Warp - The New Terminal

Warp is a new terminal that aims to be the best terminal for developers.

### Installation

`Warp` & `Starship prompt` will be installed via Homebrew.

### Configuration

```bash
ln -fs "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Personalization/shell/warp" "$HOME/.warp"
```
