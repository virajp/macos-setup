# Function to clean Telegram cache
function cleanupTelegram
  set_color --bold green; echo "Quitting Telegram ..."; set_color normal
  osascript -e 'quit app "Telegram"'
  set_color --bold green; echo "Cleaning Telegram cache ..."; set_color normal
  find "/Users/virajpatel/Library/Group Containers/6N38VWS5BX.ru.keepcoder.Telegram/appstore" -type f -name "telegram-*" -size +1024k -delete
  set_color --bold green; echo "Starting Telegram ..."; set_color normal
  open -a Telegram
end
