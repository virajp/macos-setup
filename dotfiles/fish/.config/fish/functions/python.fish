# Function to setup python virtual environment in current directory
function python-venv-setup
  set_color --bold green; echo "Setting up python virtual environment ..."; set_color normal
  python3 -m venv pyvenv
  source pyvenv/bin/activate.fish
end
