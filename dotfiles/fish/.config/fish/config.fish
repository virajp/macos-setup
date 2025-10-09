### Configuration for fish shell
### Sequence of configuration loading:
### 1. ~/.config/fish/conf.d/*.fish
### 2. ~/.config/fish/config.fish

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# pnpm
set -gx PNPM_HOME /Users/virajpatel/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# mise activate
# if type -q mise
#     if status is-interactive
#         mise activate fish | source
#     else
#         mise activate fish --shims | source
#     end
# end
