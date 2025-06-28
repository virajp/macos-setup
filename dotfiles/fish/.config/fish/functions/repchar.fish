#!/usr/bin/env fish
# =============================================================================
# File: repchar.fish
# Description: Terminal display utility for creating separator lines
# Author: Viraj Patel
# Created: 2024
# =============================================================================

# =============================================================================
# TERMINAL DISPLAY UTILITIES
# =============================================================================

##
# Repeats a character pattern across the full width of the terminal
# Useful for creating visual separators in terminal output
#
# @param $argv[1] - Character or string pattern to repeat (required)
# @env $COLUMNS - Terminal width in columns (used for calculation)
# @return 0 on success
# @example repchar '='        # Creates a line of = characters
# @example repchar '-'        # Creates a line of - characters
# @example repchar '*'        # Creates a line of * characters
##
function repchar
  # Calculate how many repetitions fit in terminal width
  # Divides terminal columns by character/pattern length
  set LENGTH (math $COLUMNS / (string length $argv[1]))
  
  # Set color to bold green for visual emphasis
  set_color --bold green
  
  # Loop from 2 to LENGTH and echo the pattern without newlines
  # Note: starts from 2, not 1, which slightly under-fills the line
  for i in (seq 2 $LENGTH); echo -en "$argv[1]"; end
  
  # Add final newline to complete the line
  echo ""
  
  # Reset color to normal
  set_color normal
end
