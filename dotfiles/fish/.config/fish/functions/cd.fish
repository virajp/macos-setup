# Function to replace cd command with zoxide
function cd
    z "$argv"
    # Load python venv if present
    if test -f "./.pyvenv/bin/activate.fish"
        set_color --bold green
        echo "Loading python venv ..."
        set_color normal
        source ./.pyvenv/bin/activate.fish
    end
end
