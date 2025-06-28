# macOS Setup Automation Suite
# 
# A comprehensive automation toolkit for setting up and maintaining a consistent
# macOS development environment. This Justfile provides recipes for managing:
#   • Dotfiles via GNU Stow for symlink-based configuration management
#   • Homebrew packages via Brewfile for reproducible package installations
#   • Shell initialization scripts for nushell and fish configurations
# 
# Prerequisites: just, homebrew, stow, git
# Usage: Run `just` to see all available commands

set shell := ["zsh", "-cu"]
set quiet := true

@_default:
  just --list

# Install dotfiles using GNU Stow
# 
# What it does: Creates symlinks from dotfiles directory to $HOME for all subdirectories
# Why: Enables version-controlled dotfiles with easy deployment and rollback
# Prerequisites: GNU Stow installed (brew install stow), dotfiles directory exists
# Side effects: Creates symlinks in $HOME pointing to files in ./dotfiles/*/
# Expected output: Verbose output showing each symlink created
# Follow-up: Verify configs work, run `stow-simulate` first to preview changes
[group('dotfiles')]
[doc('Install dotfiles using stow')]
@stow-install:
  echo "Installing up dotfiles ..."
  cd dotfiles && stow --dir=. --target=$HOME --verbose */

# Re-install dotfiles using GNU Stow (restow mode)
# 
# What it does: Removes existing symlinks and recreates them, useful for updates
# Why: Safely updates dotfile symlinks when files are added/removed/moved
# Prerequisites: GNU Stow installed, dotfiles previously installed via stow
# Side effects: Temporarily removes then recreates all dotfile symlinks
# Expected output: Verbose output showing symlinks being removed and recreated
# Follow-up: Test configurations to ensure everything works after restow
[group('dotfiles')]
[doc('Re-install dotfiles using stow')]
@stow-reinstall:
  echo "Re-installing dotfiles ..."
  cd dotfiles && stow --restow --dir=. --target=$HOME --verbose */

# Remove dotfiles symlinks using GNU Stow
# 
# What it does: Removes all symlinks created by stow, effectively uninstalling dotfiles
# Why: Clean removal of dotfiles without leaving broken symlinks
# Prerequisites: GNU Stow installed, dotfiles previously installed via stow
# Side effects: Removes symlinks from $HOME, leaves original files in ./dotfiles/
# Expected output: Verbose output showing each symlink being removed
# Follow-up: Manually restore any configs needed, backup important settings first
[group('dotfiles')]
[doc('Cleanup dotfiles using stow')]
@stow-cleanup:
  echo "Cleaning up dotfiles ..."
  cd dotfiles && stow --delete --dir=. --target=$HOME --verbose */

# Preview dotfiles installation without making changes
# 
# What it does: Shows what stow would do without actually creating symlinks
# Why: Safe way to preview changes before installation, prevents conflicts
# Prerequisites: GNU Stow installed, dotfiles directory exists
# Side effects: None - read-only operation that makes no changes
# Expected output: Verbose output showing what symlinks would be created
# Follow-up: Review output, then run `stow-install` if everything looks correct
[group('dotfiles')]
[doc('Simulate dotfiles using stow')]
@stow-simulate:
  echo "Simulate dotfiles ..."
  cd dotfiles && stow --dir=. --target=$HOME --verbose --simulate */

# Generate comprehensive Brewfile from all installed packages
# 
# What it does: Creates/updates Brewfile with all currently installed homebrew packages
# Why: Maintains reproducible package list for fresh installs or syncing machines
# Prerequisites: Homebrew installed, diff-so-fancy for pretty output (optional)
# Side effects: Overwrites ./Brewfile with current package state
# Expected output: Brewfile generation status, git diff showing changes
# Follow-up: Review diff, commit Brewfile changes, use `brew bundle install` on other machines
[group('brewfile')]
[doc('Generate brewfile for all installed packages')]
@brew:
  echo "Generating brewfile ..."
  brew bundle dump --all --force --describe --file=./Brewfile
  echo "Printing the diff ... "
  git diff --color=always | diff-so-fancy

# Remove packages not listed in Brewfile
# 
# What it does: Uninstalls packages not in Brewfile, removes orphaned dependencies
# Why: Keeps system clean by removing packages not in version-controlled Brewfile
# Prerequisites: Homebrew installed, ./Brewfile exists
# Side effects: Removes packages and dependencies, frees disk space
# Expected output: List of packages being removed, cleanup summary
# Follow-up: Verify important packages still work, may need to reinstall manually removed packages
[group('brewfile')]
[doc('Remove packages not in brewfile')]
@brew-cleanup:
  echo "Removing packages not in Brewfile ..."
  brew bundle cleanup --force --describe --file=./Brewfile
  echo "Autoremoving packages ..."
  brew autoremove --verbose

# Generate nushell initialization scripts for shell enhancements
# 
# What it does: Creates auto-loading init scripts for oh-my-posh prompt and zoxide navigation
# Why: Automates shell enhancement setup for nushell with consistent theming
# Prerequisites: oh-my-posh, zoxide installed, nushell dotfiles directory exists
# Side effects: Overwrites init scripts in nushell vendor/autoload directory
# Expected output: Confirmation of script generation
# Follow-up: Restart nushell or source configs, verify prompt and zoxide work
[group('brewfile')]
[doc('Generate nushell init scripts for oh-my-posh  zoxide ... ')]
@nu-init:
  echo "Generating init script for oh-my-posh ..."
  oh-my-posh init nu --print --config ~/.config/oh-my-posh.yaml > "./dotfiles/nushell/Library/Application Support/nushell/vendor/autoload/99-oh-my-posh.nu"
  echo "Generating init script for zoxide ..."
  zoxide init nushell > "./dotfiles/nushell/Library/Application Support/nushell/vendor/autoload/99-zoxide.nu"

# Generate fish shell initialization scripts for development tools
# 
# What it does: Creates auto-loading init scripts for oh-my-posh, direnv, and zoxide
# Why: Automates fish shell setup with prompt theming, env management, and smart navigation
# Prerequisites: oh-my-posh, direnv, zoxide installed, fish dotfiles directory exists
# Side effects: Overwrites init scripts in fish conf.d directory
# Expected output: Confirmation of script generation for each tool
# Follow-up: Restart fish or source configs, verify all tools work correctly
[group('brewfile')]
[doc('Generate fish init scripts for oh-my-posh, direnv  zoxide ... ')]
@fish-init:
  echo "Generating init script for oh-my-posh ..."
  oh-my-posh init fish --print --config ~/.config/oh-my-posh.yaml > "./dotfiles/fish/.config/fish/conf.d/99-oh-my-posh.fish"
  echo "Generating init script for direnv ..."
  direnv hook fish > "./dotfiles/fish/.config/fish/conf.d/99-direnv.fish"
  echo "Generating init script for zoxide ..."
  zoxide init fish > "./dotfiles/fish/.config/fish/conf.d/99-zoxide.fish"
