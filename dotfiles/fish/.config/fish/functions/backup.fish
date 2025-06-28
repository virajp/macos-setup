#!/usr/bin/env fish
# =============================================================================
# File: backup.fish
# Description: Backup and compression utilities for files and directories
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# BACKUP FUNCTIONS
# =============================================================================

##
# Creates a timestamped zip backup of a file or directory
#
# @param $argv[1] - Path to file or directory to backup (required)
# @return 0 on success, non-zero on failure
# @example backup ~/Documents/important.txt
# @example backup ~/Projects/my-project
##
function backup
  # Generate timestamp for unique filename
  set STAMP (date "+%Y%m%d-%H%M%S")
  
  # Get absolute path and extract components
  set FULLPATH (realpath $argv[1])
  set BASENAME $FULLPATH:t  # Extract filename/dirname
  set PARENT $FULLPATH:h    # Extract parent directory
  
  # Construct timestamped backup filename
  set FILENAME "$PARENT/$BASENAME-$STAMP.zip"
  
  # Display progress message with colored output
  set_color --bold green; echo "Zipping $argv[1] ..."; set_color normal
  
  # Create recursive zip archive
  zip --recurse-paths $FILENAME $argv[1]
end

##
# Simple zip function that creates a zip file with .zip extension
#
# @param $argv[1] - Path to file or directory to zip (required)
# @return 0 on success, non-zero on failure
# @example zipf my-folder
##
function zipf
  # Display progress message with colored output
  set_color --bold green; echo "Zipping $argv[1] ..."; set_color normal
  
  # Create recursive zip with simple naming convention
  zip -r "$argv[1]".zip "$argv[1]"
end
