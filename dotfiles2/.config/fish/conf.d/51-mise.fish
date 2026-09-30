# mise activate
set --global --export MISE_ENV dev

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
