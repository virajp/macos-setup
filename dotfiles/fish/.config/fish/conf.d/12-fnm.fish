# fnm: Fast Node Manager
# reference: https://github.com/Schniz/fnm

# Load fnm if it exists, along with cd hook
if type -q fnm
    fnm env --shell fish --use-on-cd --corepack-enabled --version-file-strategy=recursive --resolve-engines=true | source
    fnm completions --shell fish | source
end
