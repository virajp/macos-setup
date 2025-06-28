# Documentation Guide

This guide establishes consistent documentation standards for shell scripts, justfiles, and related automation tools.

## File Header Standards

Every script file should begin with a standardized header block containing essential metadata:

```bash
#!/usr/bin/env <shell>
#
# Purpose: [Brief description of what this script does]
# Author: [Your Name] <[email@domain.com]>
# Date: [YYYY-MM-DD when created]
# Prerequisites: [Required tools, permissions, or setup]
# Usage: [How to run this script with examples]
# Dependencies: [External tools, packages, or files needed]
# License: [License type, e.g., MIT, Apache 2.0, etc.]
#
```

## Function Documentation Standards

Document each function with a consistent block format:

```bash
# Function: function_name
# Description: [What this function does]
# Arguments:
#   $1 - [Description of first argument]
#   $2 - [Description of second argument] (optional)
# Environment Variables:
#   VAR_NAME - [Description of required env var]
# Returns:
#   0 - Success
#   1 - [Description of error condition]
#   2 - [Description of another error condition]
# Examples:
#   function_name "arg1" "arg2"
#   VAR_NAME="value" function_name "arg1"
```

## Comment Style Conventions

### Zsh Scripts
- Use `#` at the beginning of comment lines
- For inline comments, use `#` with a space after code
- Multi-line comments should each start with `#`

```zsh
# This is a full-line comment
echo "Hello" # This is an inline comment

# This is a multi-line comment
# that spans several lines
# for detailed explanations
```

### Fish Scripts
- Use `#` at the beginning of comment lines
- For inline comments, use `#` with a space after code
- Multi-line comments should each start with `#`

```fish
# This is a full-line comment
echo "Hello" # This is an inline comment

# This is a multi-line comment
# that spans several lines
# for detailed explanations
```

### Justfiles
- Use `#` at the very beginning of the line (no indentation)
- Comments apply to the recipe that follows them
- Use `#` for recipe descriptions

```just
# This recipe installs dependencies
install:
    brew install git # Install git via homebrew
    
# Multi-line comments for complex recipes
# should describe the overall purpose
# and any important details
complex-task:
    @echo "Starting complex task"
```

## Best Practices

1. **Consistency**: Always use the same format for headers and function documentation
2. **Clarity**: Write comments that explain "why" not just "what"
3. **Examples**: Include practical usage examples in function documentation
4. **Error Handling**: Document all possible return codes and their meanings
5. **Dependencies**: Clearly list all external dependencies and prerequisites
6. **Updates**: Update the date and description when making significant changes

## Template Usage

Use the templates in this directory as starting points:
- `file-header-template.txt` - Copy-paste file header
- `function-doc-template.txt` - Copy-paste function documentation
- `zsh-script-template.zsh` - Complete Zsh script template
- `fish-script-template.fish` - Complete Fish script template
- `justfile-template.just` - Complete Justfile template
