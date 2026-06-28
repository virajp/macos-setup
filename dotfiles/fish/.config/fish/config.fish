### Configuration for fish shell
### Sequence of configuration loading:
### 1. ~/.config/fish/conf.d/*.fish
### 2. ~/.config/fish/config.fish

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/virajpatel/.lmstudio/bin
# End of LM Studio CLI section
