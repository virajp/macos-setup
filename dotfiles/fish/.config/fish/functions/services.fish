function listStartupItems
  set_color --bold green; echo "LaunchAgents @ /Library/LaunchAgents ..."; set_color normal
  ls -1 /Library/LaunchAgents
  echo "------------------------------------------"
  set_color --bold green; echo "LaunchDaemons @ /Library/LaunchDaemons ..."; set_color normal
  ls -1 /Library/LaunchDaemons
  echo "------------------------------------------"
  set_color --bold green; echo "User LaunchAgents @ ~/Library/LaunchAgents ..."; set_color normal
  ls -1 ~/Library/LaunchAgents
  # sudo sfltool dumpbtm
end

function list-services
  launchctl list | grep -v '^-' | sort -n | grep -v 'com.apple' # | grep -v '.anonymous.'
end
