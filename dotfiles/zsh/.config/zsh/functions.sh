#!/usr/bin/env zsh
# =============================================================================
# File: functions.sh
# Description: macOS utility functions for Zsh shell
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

##
# Repeats a character string across the terminal width
# Useful for creating visual separators in terminal output
#
# @param $1 - Character or string to repeat
# @return 0 on success
# @example string '='    # Creates a line of equals signs
# @example string '-'    # Creates a line of dashes
# @note Fish equivalent: repchar function in repchar.fish
##
function string() {
  # Calculate how many times the string fits in terminal width
  local LENGTH=$(($COLUMNS / ${#1}))
  # Loop through and echo the character/string without newlines
  for i in {2..$LENGTH}; do echo -en "$1"; done
  # Add final newline
  echo ""
}

# =============================================================================
# MACOS FILE SYSTEM CLEANUP FUNCTIONS
# =============================================================================

##
# Removes .DS_Store files from a specified directory and subdirectories
# Excludes the Library directory to avoid interfering with system files
#
# @param $@ - Directory path to clean (optional, defaults to current directory)
# @return 0 on success, non-zero on failure
# @example cleanupDS                    # Cleans current directory
# @example cleanupDS ~/Documents        # Cleans Documents directory
# @example cleanupDS /path/to/folder    # Cleans specific folder
# @note Fish equivalent: cleanupDS function in cleanupDS.fish
##
function cleanupDS() {
  # Capture all arguments or default to current directory
  local ARGS=$@
  if [ -z "$ARGS" ]; then
    ARGS="."
  fi
  
  echo "Deleting .DS_Store files: $ARGS"
  
  # Use find to locate and delete .DS_Store files:
  # -type f: only files (not directories)
  # -name '.DS_Store': exact filename match for macOS metadata files
  # -not -path './Library/*': exclude Library directory to avoid system issues
  # -ls: list files before deletion for transparency
  # -delete: remove the found files
  find $ARGS -type f -name '.DS_Store' -not -path './Library/*' -ls -delete
}

# =============================================================================
# DEVELOPMENT ENVIRONMENT FUNCTIONS
# =============================================================================

##
# Opens files or directories in Cursor (AI-powered code editor)
# Auto-detects VS Code workspace files or defaults to current directory
#
# @param $@ - Files or directories to open (optional)
# @return 0 on success, non-zero on failure
# @example code                        # Opens current directory or workspace
# @example code myfile.js             # Opens specific file
# @example code ~/Projects/myapp      # Opens specific directory
# @note Fish equivalent: Similar function available in development utilities
##
function code() {
  local ARGS=$@
  if [ -z "$ARGS" ]; then
    # Look for VS Code workspace files in current directory
    ARGS=$(find . -maxdepth 1 -name "*.code-workspace")
    # Extract just the filename using Zsh parameter expansion
    ARGS=$ARGS:t
  fi
  if [ -z "$ARGS" ]; then
    # Default to current directory if no workspace found
    ARGS="."
  fi
  # Launch Cursor using Homebrew installation path
  $HOMEBREW_PREFIX/bin/cursor $ARGS
}

# =============================================================================
# FILE COMPRESSION UTILITIES
# =============================================================================

##
# Creates a ZIP archive of a file or directory
# Automatically appends .zip extension to the archive name
#
# @param $1 - File or directory to compress
# @return 0 on success, non-zero on failure
# @example zipf myproject              # Creates myproject.zip
# @example zipf documents/             # Creates documents.zip
# @note Fish equivalent: Similar compression utilities available
##
function zipf() {
  # Create recursive ZIP archive with auto-generated name
  zip -r "$1".zip "$1"
}

##
# Creates a timestamped backup archive of a file or directory
# Generates filename with current date and time for versioning
#
# @param $1 - File or directory to backup
# @return 0 on success, non-zero on failure
# @example backup myproject.txt        # Creates myproject.txt-20240628-143052.zip
# @example backup ~/Documents          # Creates Documents-20240628-143052.zip
# @note Fish equivalent: backup function in backup.fish
##
function backup() {
  # Generate timestamp in YYYYMMDD-HHMMSS format
  local STAMP=$(date "+%Y%m%d-%H%M%S")
  # Get absolute path to handle relative paths correctly
  local FULLPATH=$(realpath $1)
  # Extract basename (filename/directory name) using Zsh parameter expansion
  local BASENAME=$FULLPATH:t
  # Extract parent directory using Zsh parameter expansion
  local PARENT=$FULLPATH:h
  # Construct timestamped filename
  local FILENAME="$PARENT/$BASENAME-$STAMP.zip"
  # Create recursive ZIP archive with timestamped name
  zip --recurse-paths $FILENAME $1
}

# =============================================================================
# MACOS LAUNCHCTL & SERVICE MANAGEMENT FUNCTIONS
# =============================================================================

##
# Lists currently loaded services, excluding Apple system services
# Uses macOS launchctl utility to query loaded LaunchAgents and LaunchDaemons
#
# @return 0 on success, non-zero on failure
# @example list-services
# @note Fish equivalent: list-services function in services.fish
##
function list-services() {
  # List all loaded services, filter out:
  # grep -v '^-': Lines starting with '-' (header/separator lines)
  # sort -n: Sort numerically by PID
  # grep -v 'com.apple': Exclude Apple system services for cleaner output
  # Optional: grep -v '.anonymous.' to filter anonymous services (commented)
  launchctl list | grep -v '^-' | sort -n | grep -v 'com.apple' # | grep -v '.anonymous.'
}

# =============================================================================
# PROCESS MANAGEMENT FUNCTIONS
# =============================================================================

##
# Shows processes for current user with detailed information
# Displays PID, CPU%, memory%, start time, runtime, and command
#
# @param $@ - Additional ps options (optional)
# @return 0 on success, non-zero on failure
# @example myps                        # Shows all user processes
# @example myps -x                     # Shows processes without controlling terminal
# @note Fish equivalent: myps function in myps.fish
##
function myps() {
  # Note: $argv is Fish syntax, should be $@ in Zsh
  # Display user processes with:
  # -u $USER: only current user's processes
  # -o: custom output format (PID, CPU%, memory%, start time, runtime, BSD time, command)
  # | sort -n: sort numerically by PID
  ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command | sort -n
}

# =============================================================================
# NETWORK UTILITY FUNCTIONS
# =============================================================================

##
# Gets the public IP address using OpenDNS resolver
# Queries external service to determine public-facing IP
#
# @return 0 on success, non-zero on failure
# @example remoteip                    # Returns: 203.0.113.123
# @note Fish equivalent: remoteip function in ips.fish
##
function remoteip() {
  # Use dig with OpenDNS resolver to get public IP:
  # +short: only return the IP address (no verbose output)
  # myip.opendns.com: OpenDNS service that returns your public IP
  # @resolver1.opendns.com: specific DNS server to query
  dig +short myip.opendns.com @resolver1.opendns.com
}

##
# Gets all IP addresses (IPv4 and IPv6) from all network interfaces
# Parses ifconfig output using complex regex to extract IP addresses
#
# @return 0 on success, non-zero on failure
# @example ips                         # Shows all local IP addresses
# @note Fish equivalent: ips function in ips.fish
##
function ips() {
  # Complex regex breakdown:
  # inet6\?: matches 'inet' or 'inet6'
  # \(addr:\)\?: optional 'addr:' prefix
  # \s\?: optional whitespace
  # IPv4 pattern: \(\([0-9]\+\.\)\{3\}[0-9]\+\) - matches xxx.xxx.xxx.xxx
  # IPv6 pattern: [a-fA-F0-9:]\+ - matches hex characters and colons
  # awk removes the 'inet' prefix from output
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sort | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
}

##
# Gets only IPv4 addresses from all network interfaces
# Filters out IPv6 addresses from the complete IP list
#
# @return 0 on success, non-zero on failure
# @example ips4                        # Shows only IPv4 addresses
# @note Fish equivalent: ips4 function in ips.fish
##
function ips4() {
  # Same regex as ips() but with additional filter:
  # grep -v 'inet6': exclude IPv6 addresses, keeping only IPv4
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep -v 'inet6' | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
}

##
# Gets only IPv6 addresses from all network interfaces
# Filters to show only IPv6 addresses from the complete IP list
#
# @return 0 on success, non-zero on failure
# @example ips6                        # Shows only IPv6 addresses
# @note Fish equivalent: ips6 function in ips.fish
##
function ips6() {
  # Same regex as ips() but with filter for IPv6 only:
  # grep 'inet6': include only lines containing 'inet6'
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep 'inet6' | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
}

##
# Gets the default gateway IP address
# Uses macOS route command to query routing table
#
# @return 0 on success, non-zero on failure
# @example gateway                     # Returns: 192.168.1.1
# @note Fish equivalent: gateway function in ips.fish
##
function gateway() {
  # macOS route command breakdown:
  # route -n get default: get default route information in numeric format
  # grep "gateway": find the line containing gateway information
  # awk '{ print $2 }': extract the second field (the IP address)
  route -n get default | grep "gateway" | awk '{ print $2 }'
}

# =============================================================================
# SYSTEM INFORMATION FUNCTIONS
# =============================================================================

##
# Displays comprehensive system information
# Shows hostname, OS version, users, network config, and more
# Uses multiple macOS-specific utilities for detailed system overview
#
# @return 0 on success, non-zero on failure
# @example ii                          # Shows complete system info
# @note Fish equivalent: ii function in ips.fish
##
function ii() {
  echo -e "\nYou are logged on $HOST"
  echo -e "$NC "
  # system_profiler: macOS utility for detailed system information
  # SPSoftwareDataType: focuses on software/OS information
  system_profiler SPSoftwareDataType
  echo -e "\nAdditionnal information:$NC "
  # uname -a: kernel and system information
  uname -a
  echo -e "\nUsers logged on:$NC "
  # w -h: show logged in users without header
  w -h
  echo -e "\nCurrent date :$NC "
  date
  echo -e "\nMachine stats :$NC "
  # uptime: system load and uptime information
  uptime
  echo -e "\nCurrent network location :$NC "
  # scselect: macOS network location utility
  scselect
  echo -e "\nPublic facing IP Address :$NC "
  # Use our custom function to get public IP
  remoteip
  echo -e "\nDNS Configuration:$NC "
  # scutil --dns: macOS DNS configuration utility
  scutil --dns
  echo
}

# =============================================================================
# KUBERNETES UTILITY FUNCTIONS
# =============================================================================

##
# Kubernetes context switcher and viewer
# Sets or displays Kubernetes contexts
#
# @param $@ - Context name to switch to (optional)
# @return 0 on success, non-zero on failure
# @example kubectx                     # Lists all contexts
# @example kubectx production          # Switches to production context
# @note Fish equivalent: kubectx function in kubectx.fish
# @note Uses Fish syntax (-qt) which should be adapted for Zsh
##
function kubectx() {
  # Note: Original uses Fish syntax ($# -qt 0), correcting for Zsh
  if [ $# -eq 0 ]; then
    # No arguments: show all available contexts
    kubectl config get-contexts
  else
    # Arguments provided: set the specified context
    # Note: Original uses $argv (Fish syntax), should be $@ in Zsh
    kubectl config set-context $@
  fi
}

##
# Convenience function to clean .DS_Store files from the Projects directory
# Uses the string function to display a visual separator
#
# @return 0 on success, non-zero on failure
# @example cleanupDS-Projects
# @note Fish equivalent: cleanupDS-Projects function in cleanupDS.fish
##
function cleanupDS-Projects() {
  # Display visual separator using string utility function
  string '='
  echo "Cleaning up .DS_Store files ..."
  # Clean the Projects directory specifically
  cleanupDS ~/Projects
}

# =============================================================================
# APPLICATION-SPECIFIC CLEANUP FUNCTIONS
# =============================================================================

##
# Cleans Telegram cache files to free up disk space
# Safely quits Telegram, removes large cache files, and restarts the app
# Targets files larger than 1MB in Telegram's Group Container
#
# @return 0 on success, non-zero on failure
# @example cleanupTelegram
# @note Fish equivalent: cleanupTelegram function in cleanupTelegram.fish
##
function cleanupTelegram() {
  echo "Quitting Telegram ..."
  # osascript: macOS AppleScript command-line tool
  # Use AppleScript to gracefully quit Telegram application
  osascript -e 'quit app "Telegram"'
  
  echo "Cleaning Telegram cache ..."
  # Target Telegram's Group Container (sandboxed app storage):
  # -type f: files only
  # -name "telegram-*": files starting with 'telegram-'
  # -size +1024k: files larger than 1MB (1024 kilobytes)
  # -delete: remove the matched files
  find "/Users/virajpatel/Library/Group Containers/6N38VWS5BX.ru.keepcoder.Telegram/appstore" -type f -name "telegram-*" -size +1024k -delete
  
  echo "Starting Telegram ..."
  # open -a: macOS command to launch applications
  open -a Telegram
}

##
# Lists all LaunchAgents and LaunchDaemons across system and user directories
# Provides overview of startup items and background services on macOS
#
# @return 0 on success, non-zero on failure
# @example listStartupItems
# @note Fish equivalent: listStartupItems function in services.fish
##
function listStartupItems() {
  # Display system-wide LaunchAgents (run in user context)
  echo "LaunchAgents @ /Library/LaunchAgents ..."
  ls -1 /Library/LaunchAgents
  echo "------------------------------------------"
  
  # Display system-wide LaunchDaemons (run as root/system)
  echo "LaunchDaemons @ /Library/LaunchDaemons ..."
  ls -1 /Library/LaunchDaemons
  echo "------------------------------------------"
  
  # Display user-specific LaunchAgents
  echo "User LaunchAgents @ ~/Library/LaunchAgents ..."
  ls -1 ~/Library/LaunchAgents
  
  # Alternative: sudo sfltool dumpbtm (commented out)
  # sfltool: System Filter Tool for background task management
  # Requires admin privileges to show background task management info
  # sudo sfltool dumpbtm
}
