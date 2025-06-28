#!/usr/bin/env fish
#
# Purpose: [Brief description of what this script does]
# Author: [Your Name] <[email@domain.com]>
# Date: [YYYY-MM-DD when created]
# Prerequisites: [Required tools, permissions, or setup]
# Usage: [How to run this script with examples]
# Dependencies: [External tools, packages, or files needed]
# License: [License type, e.g., MIT, Apache 2.0, etc.]
#

# Function: example_function
# Description: Example function showing documentation format
# Arguments:
#   argv[1] - First argument description
#   argv[2] - Second argument description (optional)
# Environment Variables:
#   EXAMPLE_VAR - Description of required environment variable
# Returns:
#   0 - Success
#   1 - Invalid arguments
#   2 - Missing environment variable
# Examples:
#   example_function "hello" "world"
#   set EXAMPLE_VAR "test"; example_function "hello"
function example_function
    set -l arg1 $argv[1]
    set -l arg2 $argv[2]
    
    # Check required environment variable
    if not set -q EXAMPLE_VAR
        echo "Error: EXAMPLE_VAR environment variable is required" >&2
        return 2
    end
    
    # Validate arguments
    if test -z "$arg1"
        echo "Error: First argument is required" >&2
        return 1
    end
    
    # Function logic here
    if test -n "$arg2"
        echo "Processing: $arg1 and $arg2 with EXAMPLE_VAR=$EXAMPLE_VAR"
    else
        echo "Processing: $arg1 with EXAMPLE_VAR=$EXAMPLE_VAR"
    end
    
    return 0
end

# Main script logic
function main
    # Script implementation here
    echo "Script started"
    
    # Example function call
    # example_function "test" "value"
    
    echo "Script completed"
end

# Only run main if script is executed directly (not sourced)
if status is-interactive
    # Interactive mode - don't run main automatically
else
    main $argv
end
