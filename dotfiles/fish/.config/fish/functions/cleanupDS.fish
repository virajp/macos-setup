#!/usr/bin/env fish
# =============================================================================
# File: cleanupDS.fish
# Description: macOS .DS_Store file cleanup utilities
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# MACOS FILE SYSTEM CLEANUP FUNCTIONS
# =============================================================================

##
# Removes .DS_Store files from a specified directory and subdirectories
# Excludes the Library directory to avoid interfering with system files
#
# @param $argv[1] - Directory path to clean (optional, defaults to current directory)
# @return 0 on success, non-zero on failure
# @example cleanupDS                    # Cleans current directory
# @example cleanupDS ~/Documents        # Cleans Documents directory
# @example cleanupDS /path/to/folder    # Cleans specific folder
##
function cleanupDS
  # Set target folder from argument or default to current directory
  set FOLDER $argv[1]
  if test -z "$FOLDER"
    set FOLDER "."
  end
  
  # Display progress message with colored output
  set_color --bold green; echo "Deleting .DS_Store files: $FOLDER"; set_color normal
  
  # Use find to locate and delete .DS_Store files:
  # -type f: only files (not directories)
  # -name '.DS_Store': exact filename match
  # -not -path './Library/*': exclude Library directory to avoid system issues
  # -ls: list files before deletion
  # -delete: remove the found files
  find $FOLDER -type f -name '.DS_Store' -not -path './Library/*'  -ls -delete
end

##
# Convenience function to clean .DS_Store files from the Projects directory
# Uses the repchar function to display a visual separator
#
# @return 0 on success, non-zero on failure
# @example cleanupDS-Projects
##
function cleanupDS-Projects
  repchar '='  # Display separator line using repchar utility
  set_color --bold green; echo "Cleaning up .DS_Store files ..."; set_color normal
  # Clean the Projects directory specifically
  cleanupDS ~/Projects
end
