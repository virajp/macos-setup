function kubectx
  if test -n "$argv"
    set_color --bold green; echo "Setting kubectl context to $argv ..."; set_color normal
    kubectl config set-context $argv
  else
    set_color --bold green; echo "Getting kubectl contexts ..."; set_color normal
    kubectl config get-contexts
  end
end

alias ktx='kubectx'
