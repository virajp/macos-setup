function myps
  set_color --bold green; echo "Listing processes for user $USER ..."; set_color normal
  ps $argv -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command | sort -n
end
