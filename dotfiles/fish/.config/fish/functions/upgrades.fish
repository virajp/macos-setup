#!/usr/bin/env fish
# =============================================================================
# File: upgrades.fish
# Description: System and package upgrade utilities for macOS development
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# SECURITY & VULNERABILITY SCANNER FUNCTIONS
# =============================================================================

##
# Updates the grype vulnerability scanner database
#
# @return 0 on success, non-zero on failure
# @example grype-update
##
function grype-update
    repchar '=' # Display separator line
    set_color --bold green
    echo "Updating grype database ..."
    set_color normal
    grype db update
end

# =============================================================================
# GOOGLE CLOUD FUNCTIONS
# =============================================================================

##
# Updates Google Cloud CLI components if gcloud is installed
#
# @return 0 on success, non-zero on failure
# @example gcloud-upgrade
##
function gcloud-upgrade
    # Check if gcloud command is available before proceeding
    type gcloud >/dev/null 2>&1 || return 0 # Exit if gcloud is not installed

    # Display upgrade information
    repchar '=' # Display separator line
    set_color --bold green
    echo "Updating gcloud components ..."
    set_color normal
    gcloud components update --verbosity=warning --quiet
end

# =============================================================================
# MACOS SECURITY & AUTHENTICATION FUNCTIONS
# =============================================================================

##
# Checks if Touch ID is configured for sudo authentication
#
# @return 0 if configured, 1 if not configured
# @example check-touch-id
##
function check-touch-id
    set_color --bold green
    echo -n "Checking Touch ID setup for shell ..."
    set_color normal

    # Check if pam_tid.so module is configured in sudo PAM config
    if grep -q "pam_tid.so" /etc/pam.d/sudo
        set_color --bold green
        echo OK
        set_color normal
        return 0
    else
        set_color --bold red
        echo "NOT OK"
        set_color normal
        echo "Please run the following commands to setup Touch ID for sudo:"
        set_color --bold green
        echo "subl /etc/pam.d/sudo"
        set_color normal
        echo ""
        echo "Add the following line to the top of the file:"
        set_color --bold green
        echo "'auth       sufficient     pam_tid.so'"
        set_color normal
        echo ""
        return 1
    end
end

# =============================================================================
# HOMEBREW PACKAGE MANAGEMENT FUNCTIONS
# =============================================================================

##
# Comprehensive Homebrew package upgrade function (brew formulae)
# Updates, upgrades formulae/casks, and cleans up unused packages
#
# @return 0 on success, non-zero on failure
# @example bf
##
function bf
    repchar '=' # Display separator line
    set_color --bold green
    echo "Updating brew ..."
    set_color normal
    # Force update brew with verbose output
    brew update --auto-update --verbose --force
    # Show outdated formulae
    brew outdated --formulae

    repchar - # Display sub-separator
    set_color --bold green
    echo "Upgrading outdated formulaes ..."
    set_color normal
    # Use jq to parse JSON output and extract formula names
    set OUTDATED (brew outdated --formulae --json=v2 | jq --raw-output '.formulae[].name')
    # Loop through each outdated formula and upgrade individually
    for formulae in $OUTDATED
        brew upgrade --formulae --verbose --display-times $formulae
    end

    repchar - # Display sub-separator
    set_color --bold green
    echo "Upgrading outdated casks ..."
    set_color normal
    # Define exclusion list for packages that shouldn't be auto-upgraded
    # Note: google-cloud-sdk and flutter are commented out but could be excluded
    set EXCLUDE some-fake-name
    # Get list of outdated casks using jq JSON parsing
    set LIST (brew outdated --cask --json=v2 | jq --raw-output '.casks[].name')
    # Process each outdated cask
    for package in $LIST
        set process true
        # Check if package is in exclusion list
        for exPackage in $EXCLUDE
            if test "$package" = "$exPackage"
                set process false
                break
            end
        end
        # Only upgrade if not excluded
        if test "$process" = true
            echo "Checking upgrade: $package"
            brew upgrade --cask --verbose "$package"
        end
    end

    repchar - # Display sub-separator
    set_color --bold green
    echo "Autoremoving dangling formulaes ..."
    set_color normal
    # Remove unused dependencies
    brew autoremove --verbose

    repchar - # Display sub-separator
    set_color --bold green
    echo "Cleaning up ..."
    set_color normal
    # Clean up old versions and cache files
    brew cleanup --prune=all
end

# =============================================================================
# PYTHON PACKAGE MANAGEMENT FUNCTIONS
# =============================================================================

##
# Upgrades core Python packaging tools (pip, setuptools, wheel)
#
# @return 0 on success, non-zero on failure
# @example pip-upgrade
##
function pip-upgrade
    # Check if pip3 command is available before proceeding
    type pip3 >/dev/null 2>&1 || return 0 # Exit if pip3 is not installed

    # Display upgrade information
    repchar '=' # Display separator line
    set_color --bold green
    echo "Upgrading pip, setuptools & wheel ..."
    set_color normal
    # --break-system-packages allows upgrading in newer Python environments
    pip3 install --upgrade --break-system-packages --upgrade-strategy=only-if-needed pip setuptools wheel
end

# =============================================================================
# RUBY GEM MANAGEMENT FUNCTIONS
# =============================================================================

##
# Updates Ruby gem system (requires sudo for system-wide installation)
#
# @return 0 on success, non-zero on failure
# @example gem-upgrade
##
function gem-upgrade
    # Check if gem command is available before proceeding
    type gem >/dev/null 2>&1 || return 0 # Exit if gem is not installed

    # Display upgrade information
    repchar '=' # Display separator line
    set_color --bold green
    echo "Upgrading gem for cocoapods (requires sudo) ..."
    set_color normal
    # Check if gem is available and update system with conservative options
    sudo gem update --system --no-prerelease --conservative --minimal-deps
end

# =============================================================================
# FLUTTER DEVELOPMENT FUNCTIONS
# =============================================================================

##
# Upgrades Flutter SDK to the latest stable version
#
# @return 0 on success, non-zero on failure
# @example flutter-upgrade
##
function flutter-upgrade
    # Check if flutter command is available before proceeding
    type flutter >/dev/null 2>&1 || return 0 # Exit if flutter is not installed

    # Display upgrade information
    repchar '=' # Display separator line
    set_color --bold green
    echo "Upgrading Flutter ..."
    set_color normal
    set_color --bold green
    echo "Disable analytics ..."
    set_color normal
    flutter upgrade --disable-analytics
end

# =============================================================================
# MACOS SYSTEM UPDATE FUNCTIONS
# =============================================================================

##
# Downloads macOS updates, installs Rosetta, and upgrades App Store apps
#
# @return 0 on success, non-zero on failure
# @example osx-download
##
function osx-download
    repchar '=' # Display separator line
    set_color --bold green
    echo "Install Rosetta ..."
    set_color normal
    # Install Rosetta 2 for Intel app compatibility on Apple Silicon
    softwareupdate --install-rosetta --agree-to-license

    repchar - # Display sub-separator
    set_color --bold green
    echo "Download macOS updates ..."
    set_color normal
    # Download all available macOS system updates
    softwareupdate --download --all --verbose

    repchar - # Display sub-separator
    set_color --bold green
    echo "Upgrades from AppStore ..."
    set_color normal
    # Upgrade all App Store applications using mas CLI
    mas upgrade
end

##
# Lists available macOS system updates and App Store updates
#
# @return 0 on success, non-zero on failure
# @example osx-list
##
function osx-list
    repchar '=' # Display separator line
    set_color --bold green
    echo "Checking for macOS updates ..."
    set_color normal
    # List available macOS system updates
    softwareupdate --list

    repchar - # Display sub-separator
    set_color --bold green
    echo "Checking for update from AppStore ..."
    set_color normal
    # List outdated App Store applications
    mas outdated
end

##
# Installs all available macOS system updates (requires restart)
#
# @return 0 on success, non-zero on failure
# @example osx-upgrade
##
function osx-upgrade
    repchar '=' # Display separator line
    set_color --bold green
    echo "Checking for macOS updates ..."
    set_color normal
    # Install all available system updates with automatic restart
    sudo softwareupdate --verbose --install --all --restart
end

# =============================================================================
# NODE.JS FUNCTIONS
# =============================================================================

##
# Updates global packages
#
# @return 0 on success, non-zero on failure
# @example node-upgrade
##
function node-upgrade
    repchar '=' # Display separator line
    set_color --bold green
    echo "Enable corepack & configure pnpm ..."
    set_color normal

    # Ensure corepack is enabled for package management & pnpm is default
    corepack enable && corepack prepare pnpm@latest --activate

    # Uninstall npm
    type npm >/dev/null 2>&1 && npm uninstall --global npm

    repchar - # Display sub-separator
    set_color --bold green
    echo "Upgrade global pnpm packages ..."
    set_color normal
    # Upgrade global packages
    pnpm update --global
end

# =============================================================================
# COMPREHENSIVE UPDATE FUNCTION
# =============================================================================

##
# Master update function that runs all upgrade routines in sequence
# Requires Touch ID to be configured for sudo operations
#
# @return 0 on success, 1 if Touch ID not configured
# @example updateall
##
function updateall
    # Verify Touch ID is configured before proceeding with operations requiring sudo
    check-touch-id || return 1

    # Execute all upgrade functions in logical order
    bf # Homebrew packages (formulae and casks)
    gcloud-upgrade # Google Cloud CLI components
    node-upgrade # Node.js and global pnpm packages
    grype-update # Security vulnerability database
    cleanupDS-Projects # Clean .DS_Store files from Projects directory
    pip-upgrade # Python packaging tools
    gem-upgrade # Ruby gem system
    flutter-upgrade # Flutter SDK
    osx-download # macOS updates and App Store apps
end
