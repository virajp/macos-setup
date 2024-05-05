##########################################################################
# .zshrc file is used to set aliases, functions, and other shell options #
# that should be available every time a new zsh shell is started         #
##########################################################################

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(git)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration

# Enable completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# For a full list of active aliases, run `alias`.
#
# Example aliases
alias cls='clear'
alias ls='eza --icons --color=always --color-scale --group-directories-first --classify'
alias ll='ls --long --all'
alias la='ll'
alias cdcd='cd "$CLOUD_PATH"'
# alias cdgd='cd "/Volumes/GoogleDrive/My Drive"'
alias diff='diff-so-fancy'
alias cdgh='cd "$HOME"/Projects/github.com'
alias tf='terraform'
alias edit='subl'
alias f='open -a Finder ./'
alias reload='source ~/.zshrc'
alias cdosf='cd $HOME/Projects/github.com/OpenServiceFramework'
alias cd95='cd $HOME/Projects/github.com/95octane'
alias hping='httping --ts -GBbXsSYaWZvv'
alias dns='scutil --dns'
alias findPid='lsof -t -c'
alias openports='sudo lsof -i -P | grep LISTEN'
alias flushdns='dscacheutil -flushcache'
alias ipInfo0='ipconfig getpacket en0'
alias routes='netstat -nr -f inet'
alias emulator="~/Library/Android/sdk/emulator/emulator"
alias codeosf="code ~/Projects/github.com/OpenServiceFramework/OpenServiceFramework.code-workspace"
alias ping='prettyping -i 2 --nolegend'
alias cancelPrintJobs='sudo cancel -a -x'
alias plist='plutil -p'
alias dclean='docker system prune --force --volumes'
alias f="flutter"
alias gpull='git pull --all --verbose --progress'
alias gs='git status -sb'
alias gc='git commit -a -m'
alias gp='git push --all --atomic --verbose'
alias k='kubectl'
alias kgc='kubectl config current-context'
alias kc-local='kubectl config use-context docker-desktop'
alias tree='tree --du -hC'
alias dck-run='docker run --rm -it'

# Customizations

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ] && source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# Functions

function cleanupDS() {
  local ARGS=$@
  if [ -z "$ARGS" ]; then
    ARGS="."
  fi
  echo "Deleting .DS_Store files: $ARGS"
  find $ARGS -type f -name '.DS_Store' -not -path './Library/*'  -ls -delete
}

function code() {
  local ARGS=$@
  if [ -z "$ARGS" ]; then
    ARGS=$(find . -maxdepth 1 -name "*.code-workspace")
    ARGS=$ARGS:t
  fi
  if [ -z "$ARGS" ]; then
    ARGS="."
  fi
  $HOMEBREW_PREFIX/bin/code $ARGS
}

function code95() {
  code ~/Projects/github.com/95octane/95octane.code-workspace
}

function zipf() {
  zip -r "$1".zip "$1"
}

function backup() {
  local STAMP=$(date "+%Y%m%d-%H%M%S")
  local FULLPATH=$(realpath $1)
  local BASENAME=$FULLPATH:t
  local PARENT=$FULLPATH:h
  local FILENAME="$PARENT/$BASENAME-$STAMP.zip"
  zip --recurse-paths $FILENAME $1
}

function list-services() {
  launchctl list | grep -v '^-' | sort -n | grep -v 'com.apple' # | grep -v '.anonymous.'
}

function myps() {
  ps $argv -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command | sort -n
}

function remoteip() {
  dig +short myip.opendns.com @resolver1.opendns.com
}

function ips() {
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sort | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
}

function ips4() {
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep -v 'inet6' | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
}

function ips6() {
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep 'inet6' | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
}

function gateway() {
  route -n get default | grep "gateway" | awk '{ print $2 }'
}

function ii() {
    echo -e "\nYou are logged on $HOST"
    echo -e "$NC " ; system_profiler SPSoftwareDataType
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\nUsers logged on:$NC " ; w -h
    echo -e "\nCurrent date :$NC " ; date
    echo -e "\nMachine stats :$NC " ; uptime
    echo -e "\nCurrent network location :$NC " ; scselect
    echo -e "\nPublic facing IP Address :$NC " ; remoteip
    echo -e "\nDNS Configuration:$NC " ; scutil --dns
    echo
}

function kubectx() {
  if [ $# -qt 0 ]; then
    kubectl config set-context $argv
  else
    kubectl config get-contexts
  fi
}

# Function to update grype database
function grypeupdate() {
  grype db update
}

# Function to check whether gcloud cli is installed and then run the component upgrade command
function gcloudupdate() {
  if type gcloud &>/dev/null; then
    gcloud components update --verbosity=info --quiet
  fi
}

# Function to check whether touch-id is setup for sudo 
function check-touch-id() {
  echo -n "Checking Touch ID setup for shell ... "
  if [ -n "$(cat /etc/pam.d/sudo | grep pam_tid.so)" ]; then
    echo -e "\e[32mOK\e[0m"
    return 0
  else
    echo -e "\e[31mNOT OK\e[0m"
    echo -e "\e[33mPlease run the following commands to setup Touch ID for sudo:"
    echo -e "subl /etc/pam.d/sudo"
    echo -e "\nAdd the following line to the top of the file:"
    echo -e "'auth       sufficient     pam_tid.so'\e[0m"
    return 1
  fi
}

function string(){
	for i in {1..$COLUMNS}; do echo -n "$1"; done
}

# Function to upgrade brew packages
function bf() {
  string '='
  echo "Updating brew ..."
  brew update --auto-update --verbose --force
  
  string '='
  echo "Upgrading outdated formulaes ..."
  OUTDATED=($(brew outdated --formulae --json=v2 | jq --raw-output '.formulae[].name'))
  for formulae in $OUTDATED; do
    brew upgrade --formulae --verbose --display-times $formulae
  done

  string '='
  echo "Upgrading outdated casks ..."
  # EXCLUDE=("google-cloud-sdk" "flutter")
  EXCLUDE=("some-fake-name")
  LIST=($(brew outdated --cask --json=v2 | jq --raw-output '.casks[].name'))
  for package in $LIST; do
    process=true
    for exPackage in $EXCLUDE; do
      if [ "$package" = "$exPackage" ]; then
        process=false
        break
      fi
    done
    if [ "$process" = true ]; then
      echo "Checking upgrade: $package"
      brew upgrade --cask --verbose "$package"
    fi
  done

  string '='
  echo "Upgrading pip, setuptools & wheel ..."
  type pip3 >/dev/null && pip3 install --upgrade pip setuptools wheel --break-system-packages --upgrade-strategy only-if-needed

  # string '='
  # echo "Upgrading gem (requires sudo) ..."
  # type gem >/dev/null && sudo gem update --system --no-prerelease --conservative --minimal-deps

  string '='
  echo "Autoremoving dangling formulaes ..."
  brew autoremove --verbose

  string '='
  echo "Cleaning up ..."
  brew cleanup --prune=all

}

# macOS & AppStore downloads
function osx-download() {
  echo "Checking for macOS updates ..."
  softwareupdate --download --all --verbose
  string '='
  echo "Checking for update from AppStore ..."
  mas outdated
}

# macOS update
function osx-update() {
  echo "Checking for macOS updates ..."
  sudo softwareupdate --verbose --install --all --restart
}

# Update nodejs & tools
function node-update() {
  echo "Updating nodejs ..."
  nvm install "lts/*" -b --lts="lts/*" --latest-npm --reinstall-packages-from="lts/*"
  echo "Update npm ..."
  nvm install-latest-npm
  echo "Updating global npm packages ..."
  npm update --global
  echo "Removing old version of nodejs ..."
  nvm ls --no-colors | tr -d ' *' | egrep -o '^v[0-9.]+' | xargs -n 1 -I {} zsh -c '. ~/.zshrc && nvm uninstall "{}"'
}

# Function to upgrade all brew packages
function updateall() {
  check-touch-id || return 1
  bf
  string '='
  node-update
  string '='
  grypeupdate
  string '='
  osx-download
  string '='
  echo "Cleaning up .DS_Store files ..."
  cleanupDS ~/Projects
  string '='
}

function listStartupItems() {
  echo "LaunchAgents @ /Library/LaunchAgents ..."
  ls -1 /Library/LaunchAgents
  echo "------------------------------------------"
  echo "LaunchDaemons @ /Library/LaunchDaemons ..."
  ls -1 /Library/LaunchDaemons
  echo "------------------------------------------"
  echo "User LaunchAgents @ ~/Library/LaunchAgents ..."
  ls -1 ~/Library/LaunchAgents
  # sudo sfltool dumpbtm
}

function dev-95octane() {
  # Google Play Store (Firebase Distribution: prod-95octane-app)
  export FIREBASE_APP_ID=""
  # export FIREBASE_TOKEN="1//0gzAGhopzv39wCgYIARAAGBASNwF-L9IrwYhhYclMLX7Ec5GfNC7dRrUOx8Ls6vxQ2JhVrAb8MkW4mbOJCKW90_8_4OPJuzK-P94"
  export GOOGLE_APPLICATION_CREDENTIALS=""
}

function prod-95octane() {
  # Google Play Store (Firebase Distribution: prod-95octane-app)
  export FIREBASE_APP_ID="1:698014237924:android:0232ae4cd416b3b25098f1"
  # export FIREBASE_TOKEN="1//0gzAGhopzv39wCgYIARAAGBASNwF-L9IrwYhhYclMLX7Ec5GfNC7dRrUOx8Ls6vxQ2JhVrAb8MkW4mbOJCKW90_8_4OPJuzK-P94"
  export GOOGLE_APPLICATION_CREDENTIALS="/Users/virajpatel/Library/Mobile Documents/com~apple~CloudDocs/95octane/firebase/prod-95octane-app/service-accounts/firebase-adminsdk.json"
}

# Temurin Java home
export JAVA_HOME=$(/usr/libexec/java_home)

# NVM configuration
export NVM_DIR="$HOME/.nvm"
# Load nvm
[ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" 
# Load nvm bash_completion
[ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"

# Place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Initialize direnv
eval "$(direnv hook zsh)"

# Initialize Starship
eval "$(starship init zsh)"

# Created by `pipx` on 2024-03-15 06:20:45
export PATH="$PATH:/Users/virajpatel/.local/bin"

# GitHub Copilot CLI integration
eval "$(gh copilot alias -- zsh)"

# Setup zoxide
eval "$(zoxide init zsh)"
alias cd='z'
