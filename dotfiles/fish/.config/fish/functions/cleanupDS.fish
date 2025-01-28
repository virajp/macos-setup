function cleanupDS
  set FOLDER $argv[1]
  if test -z "$FOLDER"
    set FOLDER "."
  end
  set_color --bold green; echo "Deleting .DS_Store files: $FOLDER"; set_color normal
  find $FOLDER -type f -name '.DS_Store' -not -path './Library/*'  -ls -delete
end

function cleanupDS-Projects
  repchar '='
  set_color --bold green; echo "Cleaning up .DS_Store files ..."; set_color normal
  cleanupDS ~/Projects
end
