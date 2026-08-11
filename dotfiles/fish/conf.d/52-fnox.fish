# fnox activate
set --global --export MISE_ENV dev
if type -q fnox
    fnox activate fish | source
end
