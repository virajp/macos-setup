# Configuration Documentation

This document explains the less-obvious settings and customizations in the
dotfiles configuration.

## Directory Structure

The `dotfiles/` directory contains configuration files organized by application:

- `nushell/` - Modern shell configuration with custom vendor autoload system
- `oh-my-posh/` - Custom prompt theme with gruvbox colors
- `starship/` - Alternative prompt configuration (currently unused in favor of
  oh-my-posh)
- `warp/` - Terminal theme and keybindings
- `gh/` - GitHub CLI configuration
- `docker/` - Docker security profiles
- `ssh/` - SSH client configuration
- `git/` - Git configuration and aliases
- `vscode/` - VS Code settings

## Key Customizations & WHY Comments

### Nushell Configuration

#### Loading Sequence

Files are loaded in this order:

1. `env.nu` - Initial environment setup
2. `config.nu` - Main configuration
3. `vendor/autoload/*.nu` - All files in autoload directory (sorted by name)
4. `login.nu` - Login-specific setup

#### Notable Settings

**Custom Vendor Autoload System** (`vendor/autoload/`)

- `00-env.nu` - Environment variables loaded first
- `01-aliases.nu` - Command aliases and shortcuts
- `99-oh-my-posh.nu` - Prompt configuration (loaded last)
- `99-zoxide.nu` - Smart directory jumping

**Environment Variables** (`00-env.nu`)

- `CLOUD_PATH`: iCloud Drive path for cross-device secret syncing
- `CHROME_EXECUTABLE`: Uses Brave browser for Flutter web development
- `DOCKER_DEFAULT_PLATFORM`: Forces AMD64 for production compatibility
- Loads secrets from `iCloud/Secure/secrets.json`

**Shell Features** (`config.nu`)

- SQLite history with 5M record limit for performance
- Trash integration instead of permanent deletion
- Sublime Text as default editor
- Custom datetime format

### Oh-My-Posh Configuration

**Custom Theme** (`.config/oh-my-posh.yaml`)

- Gruvbox-inspired color palette
- Multi-segment layout: time → git → path → languages → k8s → execution time
- Custom path substitutions for common directories
- Auto-update enabled for latest features

**Integration** (`99-oh-my-posh.nu`)

- Right prompt on last line for nushell compatibility
- Custom config path instead of built-in themes
- Python virtual environment prompt disabled

### Tool-Specific Configurations

**GitHub CLI** (`gh/config.yml`)

- SSH protocol for better security
- VS Code as default editor
- Custom aliases for common operations

**Warp Terminal** (`warp/themes/coolnight.yaml`)

- Custom cyberpunk/synthwave inspired theme
- High contrast colors for better readability

**Starship** (`starship.toml`)

- Alternative prompt configuration (backup)
- Gruvbox color palette
- Higher timeout for slow git operations
- Custom directory substitutions with icons

## Security Features

1. **SSH Key Usage**: GitHub CLI configured for SSH over HTTPS
2. **Secret Management**: Use doppler for secret management
3. **Trash Safety**: Files moved to Trash instead of permanent deletion

## Development Environment

**Language Support**:

- Node.js with development environment
- Java with OpenJDK from Homebrew
- Ruby with custom gem directory
- Android development tools
- Docker with BuildKit optimizations

**Enhanced Tools**:

- `eza` for better `ls` with icons and colors
- `bat` for syntax-highlighted `cat`
- `diff-so-fancy` for better git diffs
- `zoxide` for smart directory navigation
- `prettyping` for enhanced ping output

## Path Configuration

Custom PATH additions include:

- Homebrew binaries (`/opt/homebrew/bin`, `/opt/homebrew/sbin`)
- Language-specific tools (Ruby, Java, Node.js)
- Android development tools
- OrbStack container tools
- Local user binaries

## Color Schemes

All tools use consistent gruvbox-inspired colors:

- Background: Dark variants (#3c3836, #665c54)
- Foreground: Light variants (#fbf1c7, #ffffff)
- Accents: Blue (#458588), Aqua (#689d6a), Green (#98971a)
- Alerts: Orange (#d65d0e), Red (#cc241d), Yellow (#d79921)

This ensures visual consistency across terminal, prompt, and editor themes.
