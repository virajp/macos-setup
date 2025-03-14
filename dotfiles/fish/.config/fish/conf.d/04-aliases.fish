# For a full list of active aliases, run `alias`.
alias cls='clear'
alias ls='eza --icons --color=always --color-scale --group-directories-first --classify'
alias ll='ls --long --all'
alias cdcd='cd "$CLOUD_PATH"'
alias diff='diff-so-fancy'
alias cdgh='cd "$HOME"/Projects/github.com'
alias tf='terraform'
alias edit='subl'
alias f='open -a Finder ./'
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
alias tree='tree --du -hC'
alias cat='bat'

# Git related aliases
alias gpull='git pull --all --verbose --progress'
alias gs='git status -sb'
alias gc='git commit -a -m'
alias gp='git push --all --atomic --verbose'

# Docker related aliases
alias dpull='docker image pull --platform="linux/amd64"'
alias drun='docker run --platform="linux/amd64" --rm --interactive --tty --tz="Asia/Calcutta"'
alias dlist='docker image list'
alias dclean='docker system prune --all --volumes --force'

# Kubernetes (k8s) related aliases
alias k='kubectl'
alias kgc='kubectl config current-context'
alias kc-local='kubectl config use-context orbstack'

# 95octane related customisations
alias cd95='cd $HOME/Projects/github.com/95octane'
