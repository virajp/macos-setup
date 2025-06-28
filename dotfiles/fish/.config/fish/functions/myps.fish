#!/usr/bin/env fish
# =============================================================================
# File: myps.fish
# Description: Enhanced process listing utility for current user
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# PROCESS MONITORING FUNCTIONS
# =============================================================================

##
# Lists processes for the current user with detailed information
# Shows PID, CPU usage, memory usage, start time, and command
#
# @param $argv - Additional ps command arguments (optional)
# @env $USER - Current username (used for filtering processes)
# @return 0 on success, non-zero on failure
# @example myps                    # Lists all user processes
# @example myps aux               # Lists processes with aux options
# @example myps -e                # Lists all processes for user
##
function myps
  # Display informative header with colored output
  set_color --bold green; echo "Listing processes for user $USER ..."; set_color normal
  
  # Run ps command with:
  # $argv: any additional arguments passed to the function
  # -u $USER: filter to show only processes owned by current user
  # -o: custom output format showing:
  #   - pid: process ID
  #   - %cpu: CPU usage percentage
  #   - %mem: memory usage percentage  
  #   - start: process start time
  #   - time: cumulative CPU time
  #   - bsdtime: BSD-style time format
  #   - command: full command line
  # | sort -n: sort output numerically (by PID)
  ps $argv -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command | sort -n
end
