function backup
  set STAMP (date "+%Y%m%d-%H%M%S")
  set FULLPATH (realpath $argv[1])
  set BASENAME $FULLPATH:t
  set PARENT $FULLPATH:h
  set FILENAME "$PARENT/$BASENAME-$STAMP.zip"
  set_color --bold green; echo "Zipping $argv[1] ..."; set_color normal
  zip --recurse-paths $FILENAME $argv[1]
end

function zipf
  set_color --bold green; echo "Zipping $argv[1] ..."; set_color normal
  zip -r "$argv[1]".zip "$argv[1]"
end
