use std/util "path add"

# For a full list of active aliases, run `alias`.

# Basic system aliases
export alias cls = clear
export alias la = ls --long --all
# WHY: Uses 'eza' instead of default 'ls' for better colors and icons
export alias ll = eza --icons --color=always --color-scale --group-directories-first --classify --long --all

# Navigation shortcuts
export alias cdcd = cd $env.CLOUD_PATH
export alias cdgh = cd ($env.HOME | path join "Projects/github.com")

# Enhanced tools (replacements for standard utilities)
# WHY: diff-so-fancy provides better diff formatting with syntax highlighting
export alias diff = diff-so-fancy
export alias tf = terraform
export alias edit = subl
# export alias reload = exec fish
export alias hping = httping --ts -GBbXsSYaWZvv
export alias dns = scutil --dns
export alias findPid = lsof -t -c
export alias openports = sudo lsof -i -P | grep LISTEN
export alias flushdns = dscacheutil -flushcache
export alias ipInfo0 = ipconfig getpacket en0
export alias routes = netstat -nr -f inet
export alias emulator = open ($env.ANDROID_HOME | path join "emulator/emulator")
export alias adb = open ($env.ANDROID_HOME | path join "platform-tools/adb")
export alias ping = prettyping -i 2 --nolegend
export alias cancelPrintJobs = sudo cancel -a -x
export alias plist = plutil -p
export alias f = flutter
export alias tree = tree --du -hC
export alias cat = bat

# Git related aliases
export alias gpull = git pull --all --verbose --progress
export alias gs = git status -sb
export alias gc = git commit -a -m
export alias gp = git push --all --atomic --verbose

# Docker related aliases
export alias dpull = docker image pull --platform="linux/amd64"
export alias drun = docker run --platform="linux/amd64" --rm --interactive --tty --tz="Asia/Calcutta"
export alias dlist = docker image list
export alias dclean = docker system prune --all --volumes --force

# Kubernetes (k8s) related aliases
export alias k = kubectl
export alias kgc = kubectl config current-context
export alias kc-local = kubectl config use-context docker-desktop
