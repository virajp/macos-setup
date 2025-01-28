function code
  set ARGS $argv
  if test -z "$ARGS"
    set ARGS (find . -maxdepth 1 -name "*.code-workspace")
    set ARGS $ARGS:t
  end
  if test -z "$ARGS"
    set ARGS "."
  end
  $HOMEBREW_PREFIX/bin/cursor $ARGS
end

function code95
  code ~/Projects/github.com/95octane/95octane.code-workspace
end
