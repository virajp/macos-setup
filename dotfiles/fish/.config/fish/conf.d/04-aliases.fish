#!/usr/bin/env fish
# =============================================================================
# Fish Configuration: Aliases
# =============================================================================
# This file is auto-sourced by Fish shell during startup.
# Files in conf.d/ are automatically loaded in alphabetical order.
#
# Commonly Used Aliases
#
# This file groups aliases by their use or related domain.
# Grouping allows for quick reference and changes.
#
# Environment variables referenced:
# - CLOUD_PATH: iCloud Drive path for synced documents (defined in 01-env.fish)
# - HOME: User home directory (system variable)
# =============================================================================
# Generic Aliases
alias cls='clear'
alias ls='eza --icons --color=always --color-scale --group-directories-first --classify=always --long --grid --all --modified --git --header --width=1'
alias lf='ls --only-files'
alias ld='ls --only-dirs'
alias lg='ls --git-ignore'
alias cdcd='cd "$CLOUD_PATH"'
alias diff='diff-so-fancy'
alias cdgh='cd "$HOME"/Projects/github.com'
alias tf='terraform'
alias edit='subl'
alias finder='open -a Finder ./'
alias reload='exec fish'
alias hping='httping --ts -GBbXsSYaWZvv'
alias dns='scutil --dns'
alias findPid='lsof -t -c'
alias openports='sudo lsof -i -P | grep LISTEN'
alias flushdns='dscacheutil -flushcache'
alias ipInfo0='ipconfig getpacket en0'
alias routes='netstat -nr -f inet'
alias emulator='/opt/homebrew/share/android-commandlinetools/emulator/emulator'
alias adb='/opt/homebrew/share/android-commandlinetools/platform-tools/adb'
alias ping='prettyping -i 2 --nolegend'
alias cancelPrintJobs='sudo cancel -a -x'
alias plist='plutil -p'
alias f='flutter'
alias tree='ls --tree'
alias cat='bat'
alias dig='doggo'

# Git Related Aliases
alias gpull='git pull --all --verbose --progress'
alias gs='git status -sb'
alias gc='git commit -a -m'
alias gp='git push --all --atomic --verbose'

# Aliases for Git commands to improve workflow efficiency
# Examples include quick status checks, comprehensive pushes with safety measures,
# and atomic commit references.

# Docker Related Aliases
alias dpull='docker image pull --platform="linux/amd64"'
alias drun='docker run --platform="linux/amd64" --rm --interactive --tty'
alias dlist='docker image list'
alias dclean='docker system prune --all --volumes --force'
alias dprune='docker system prune --volumes --force'

# Docker aliases to streamline container management allowing easy setup
# Clean-up processes and precise image handling.

# Kubernetes (K8s) Related Aliases
alias k='kubectl'
alias kgc='kubectl config current-context'
alias kc-local='kubectl config use-context orbstack'

# Simplifying Kubernetes operations with single-letter keys for rapid context
# management and command executions.

# 95octane Related Customisations
alias cd95='cd $HOME/Projects/gitlab.com/95octane'

# Customized navigation specifically tailored to collaborate on 95octane
# projects ensuring consistent access to project resources.
