function code
  set ARGS $argv
  if test -z "$ARGS"
    set ARGS (find . -maxdepth 1 -name "*.code-workspace")
    set ARGS $ARGS:t
  end
  if test -z "$ARGS"
    set ARGS "."
  end
  $HOMEBREW_PREFIX/bin/code $ARGS
end

function cursor
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
