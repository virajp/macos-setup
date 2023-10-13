# ZSH Shell

ZSH is the default macOS shell, but we will install the latest version from homebrew.

## Install

```bash
# Install
brew install --formulae zsh

# Make ZSH (brew version) as default shell (you will be asked to enter password)
echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/zsh

# Exit current session
exit
```

## Shell prompt

We will be using `Oh My ZSH` as the shell prompt.

> **Note:** The following commands require to use `zsh` shell and home directory.

```bash
# Install Oh-My-ZSH
cd; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Configure Oh-My-ZSH

> Install plugins

```bash
brew install --formulae zsh-syntax-highlighting zsh-autocomplete zsh-autosuggestions zsh-completions
```

> Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting
to load these completions, you may need to run these commands:

```bash
chmod go-w '/opt/homebrew/share'
chmod -R go-w '/opt/homebrew/share/zsh'
```

> Powerlevel 10k theme

```bash
brew install --formulae powerlevel10k
```
