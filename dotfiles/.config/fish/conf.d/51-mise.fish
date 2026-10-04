# mise activate

# MISE_ENV must be set as "dev"
set --global --export MISE_ENV dev
# Setting up mise trusted paths
set --global --export MISE_TRUSTED_CONFIG_PATHS "$HOME/.config/mise:$HOME/Projects"

# Homebrew's mise formula ships vendor_conf.d/mise-activate.fish, which sorts
# after this file and would re-run a full `mise activate`, overriding the
# interactive/--shims split below. Suppress it so this file stays authoritative.
# Global (not exported) so each shell decides independently.
set --global MISE_FISH_AUTO_ACTIVATE 0

if type -q mise
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end
end
