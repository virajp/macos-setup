function repchar
  set LENGTH (math $COLUMNS / (string length $argv[1]))
  set_color --bold green
  for i in (seq 2 $LENGTH); echo -en "$argv[1]"; end
  echo ""
  set_color normal
end
