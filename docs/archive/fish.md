# Fish Shell

Fish is a smart and user-friendly command line shell for macOS. It is the preferred shell for this setup.

## Install

```bash
# Install
brew install --formulae fish

# Make Fish as default shell (you will be asked to enter password)
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# Exit current session
exit
```

## Shell prompt

We will be using `Tide (IlanCosman/tide)` as the shell prompt and use `Fisher (Plugin Management)` to install it.

> **Note:** The following commands require to use `fish` shell.

```bash
# Install Tide
fisher install IlanCosman/tide@v5
```

### Configure `Tide`

> Follow these steps to configure `Tide` shell prompt in case your prompt is not showing up correctly.

```bash
tide configure
```

Use the following settings:

```text
# Selections for tide v5
# Prompt Style: 3) Rainbow
# Prompt Colors: 1) True Color
# Show current time?: 2) 24-hour format
# Prompt Separators: 1) Angled
# Prompt Heads: 1) Sharp
# Prompt Tails: 1) Flat
# Prompt Height: 2) Two lines
# Prompt Connection: 2) Dotted
# Prompt Frame: 1) No Frame
# Connection & Frame Color: 4) Darkest
# Prompt Spacing: 2) Sparse
# Icons: 2) Many Icons

# Replace configuration: y
```
