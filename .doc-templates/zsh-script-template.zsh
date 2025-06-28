#!/usr/bin/env zsh
#
# Purpose: [Brief description of what this script does]
# Author: [Your Name] <[email@domain.com]>
# Date: [YYYY-MM-DD when created]
# Prerequisites: [Required tools, permissions, or setup]
# Usage: [How to run this script with examples]
# Dependencies: [External tools, packages, or files needed]
# License: [License type, e.g., MIT, Apache 2.0, etc.]
#

# Enable strict error handling
set -euo pipefail

# Function: example_function
# Description: Example function showing documentation format
# Arguments:
#   $1 - First argument description
#   $2 - Second argument description (optional)
# Environment Variables:
#   EXAMPLE_VAR - Description of required environment variable
# Returns:
#   0 - Success
#   1 - Invalid arguments
#   2 - Missing environment variable
# Examples:
#   example_function "hello" "world"
#   EXAMPLE_VAR="test" example_function "hello"
example_function() {
    local arg1="${1:-}"
    local arg2="${2:-}"
    
    # Check required environment variable
    if [[ -z "${EXAMPLE_VAR:-}" ]]; then
        echo "Error: EXAMPLE_VAR environment variable is required" >&2
        return 2
    fi
    
    # Validate arguments
    if [[ -z "$arg1" ]]; then
        echo "Error: First argument is required" >&2
        return 1
    fi
    
    # Function logic here
    echo "Processing: $arg1 ${arg2:+and $arg2} with EXAMPLE_VAR=$EXAMPLE_VAR"
    return 0
}

# Main script logic
main() {
    # Script implementation here
    echo "Script started"
    
    # Example function call
    # example_function "test" "value"
    
    echo "Script completed"
}

# Only run main if script is executed directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
