# Functions

function string(){
	for i in {2..$COLUMNS}; do echo -n "$1"; done
  echo ""
}

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
  $HOMEBREW_PREFIX/bin/cursor $ARGS
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

function cleanupDS-Projects() {
  string '='
  echo "Cleaning up .DS_Store files ..."
  cleanupDS ~/Projects
}

# Function to clean Telegram cache
function cleanupTelegram() {
  echo "Quitting Telegram ..."
  osascript -e 'quit app "Telegram"'
  echo "Cleaning Telegram cache ..."
  find "/Users/virajpatel/Library/Group Containers/6N38VWS5BX.ru.keepcoder.Telegram/appstore" -type f -name "telegram-*" -size +1024k -delete
  echo "Starting Telegram ..."
  open -a Telegram
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

# Function to setup python virtual environment in current directory
function python-venv-setup() {
  echo "Setting up python virtual environment ..."
  python3 -m venv pyvenv
  source pyvenv/bin/activate
}

# Function to replace cd command with zoxide
function cd() {
  z "$@"
  # Load python venv if present
  if [[ -f "./pyvenv/bin/activate" ]] ; then
      echo "Loading python venv ..."
      source ./pyvenv/bin/activate
  fi
}
