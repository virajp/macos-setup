#
# Purpose: [Brief description of what this justfile does]
# Author: [Your Name] <[email@domain.com]>
# Date: [YYYY-MM-DD when created]
# Prerequisites: [Required tools, permissions, or setup]
# Usage: just <recipe-name> [arguments]
# Dependencies: [External tools, packages, or files needed]
# License: [License type, e.g., MIT, Apache 2.0, etc.]
#

# Default recipe - shows available recipes
default:
    @just --list

# Recipe: example-recipe
# Description: Example recipe showing documentation format
# Arguments: name (required)
# Environment Variables: EXAMPLE_VAR (optional)
# Usage: just example-recipe "hello"
example-recipe name:
    @echo "Processing: {{name}}"
    @echo "Environment: ${EXAMPLE_VAR:-not-set}"

# Recipe: example-with-deps
# Description: Example recipe with dependencies
# Dependencies: setup
# Usage: just example-with-deps
example-with-deps: setup
    @echo "Running example with dependencies"

# Recipe: setup
# Description: Setup required for other recipes
# Usage: just setup (usually called automatically)
setup:
    @echo "Setting up environment"
    # Add setup commands here

# Recipe: clean
# Description: Clean up generated files and artifacts
# Usage: just clean
clean:
    @echo "Cleaning up..."
    # Add cleanup commands here

# Recipe: help
# Description: Show detailed help for available recipes
# Usage: just help
help:
    @echo "Available recipes:"
    @echo "  example-recipe <name> - Example recipe with argument"
    @echo "  example-with-deps     - Example with dependencies"
    @echo "  setup                 - Setup environment"
    @echo "  clean                 - Clean up artifacts"
    @echo "  help                  - Show this help"
