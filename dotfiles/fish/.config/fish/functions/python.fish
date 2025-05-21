# Function to setup python virtual environment in current directory
function python-setup
    set_color --bold green
    echo "Initialize python using `uv` ..."
    set_color normal
    uv init
end
