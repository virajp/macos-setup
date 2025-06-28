#!/usr/bin/env fish
# =============================================================================
# File: services.fish
# Description: macOS service and LaunchAgent management utilities
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# MACOS LAUNCHCTL & SERVICE MANAGEMENT FUNCTIONS
# =============================================================================

##
# Lists all LaunchAgents and LaunchDaemons across system and user directories
#
# @return 0 on success, non-zero on failure
# @example listStartupItems
##
function listStartupItems
  # Display system-wide LaunchAgents
  set_color --bold green; echo "LaunchAgents @ /Library/LaunchAgents ..."; set_color normal
  ls -1 /Library/LaunchAgents
  echo "------------------------------------------"
  
  # Display system-wide LaunchDaemons (run as root)
  set_color --bold green; echo "LaunchDaemons @ /Library/LaunchDaemons ..."; set_color normal
  ls -1 /Library/LaunchDaemons
  echo "------------------------------------------"
  
  # Display user-specific LaunchAgents
  set_color --bold green; echo "User LaunchAgents @ ~/Library/LaunchAgents ..."; set_color normal
  ls -1 ~/Library/LaunchAgents
  
  # Alternative: sudo sfltool dumpbtm (commented out - requires admin privileges)
  # This would show background task management info
end

##
# Lists currently loaded services, excluding Apple system services
#
# @return 0 on success, non-zero on failure
# @example list-services
##
function list-services
  # List all loaded services, filter out:
  # - Lines starting with '-' (header/separator lines)
  # - Apple system services (com.apple.*)
  # Sort numerically and optionally filter anonymous services
  launchctl list | grep -v '^-' | sort -n | grep -v 'com.apple' # | grep -v '.anonymous.'
end
