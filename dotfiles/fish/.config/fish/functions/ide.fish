#!/usr/bin/env fish
# =============================================================================
# File: ide.fish
# Description: IDE launcher functions for VS Code and Cursor
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# IDE LAUNCHER FUNCTIONS
# =============================================================================

##
# Launches VS Code with intelligent workspace detection
#
# @param $argv - Optional file/directory paths to open (default: auto-detect)
# @env HOMEBREW_PREFIX - Homebrew installation prefix (required)
# @return 0 on success, non-zero on failure
# @example code                    # Opens workspace file or current directory
# @example code ./src             # Opens specific directory
# @example code file.txt          # Opens specific file
##
function code
  set ARGS $argv
  
  # If no arguments provided, try to find workspace file
  if test -z "$ARGS"
    set ARGS (find . -maxdepth 1 -name "*.code-workspace")
    set ARGS $ARGS:t  # Extract just the filename (tail)
  end
  
  # If still no arguments, default to current directory
  if test -z "$ARGS"
    set ARGS "."
  end
  
  # Launch VS Code using Homebrew-installed binary
  $HOMEBREW_PREFIX/bin/code $ARGS
end

##
# Launches Cursor IDE with intelligent workspace detection
#
# @param $argv - Optional file/directory paths to open (default: auto-detect)
# @env HOMEBREW_PREFIX - Homebrew installation prefix (required)
# @return 0 on success, non-zero on failure
# @example cursor                  # Opens workspace file or current directory
# @example cursor ./src           # Opens specific directory
# @example cursor file.txt        # Opens specific file
##
function cursor
  set ARGS $argv
  
  # If no arguments provided, try to find workspace file
  if test -z "$ARGS"
    set ARGS (find . -maxdepth 1 -name "*.code-workspace")
    set ARGS $ARGS:t  # Extract just the filename (tail)
  end
  
  # If still no arguments, default to current directory
  if test -z "$ARGS"
    set ARGS "."
  end
  
  # Launch Cursor using Homebrew-installed binary
  $HOMEBREW_PREFIX/bin/cursor $ARGS
end
