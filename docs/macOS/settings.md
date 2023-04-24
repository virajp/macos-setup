# Systen Settings

## General

```bash
# Allow Apps to open previous windows
defaults write "Apple Global Domain" NSQuitAlwaysKeepsWindows -bool true

# Trackpad "Tap to Click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

killall Dock
```

## Firewall

```bash
sudo defaults write /Library/Preferences/com.apple.alf globalstate -bool true
```

## DNS

```bash
networksetup -setv6off Wi-Fi
# networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1
```
