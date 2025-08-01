# Preferences

## Global Preferences

```shell
defaults write -globalDomain AppleInterfaceStyle -string Dark
# Finder > Preferences > Advance > Show all filename extensions
defaults write -globalDomain AppleShowAllExtensions -bool true
defaults write -globalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write -globalDomain NSPersonNameDefaultDisplayNameOrder -integer 1
defaults write -globalDomain NSPersonNameDefaultShortNameEnabled -integer 1
defaults write -globalDomain NSPersonNameDefaultShortNameFormat -integer 1
defaults write -globalDomain NSQuitAlwaysKeepsWindows -bool true
defaults write -globalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write -globalDomain "com.apple.trackpad.forceClick" -bool false
# Allow Apps to open previous windows
defaults write -globalDomain NSQuitAlwaysKeepsWindows -bool true
killall Dock
```

## Trackpad

```shell
# Trackpad "Tap to Click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
```

## Firewall

```shell
sudo defaults write /Library/Preferences/com.apple.alf globalstate -bool true
sudo defaults write /Library/Preferences/com.apple.alf allowdownloadsignedenabled -bool true
sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool true
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true
```

## DNS

```shell
networksetup -setv6off Wi-Fi
# networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1
```

## Dock

```shell
defaults write com.apple.dock orientation -string bottom
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -integer 36
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mod-count -integer 661
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock windowtabbing -string always
killall Dock
```

## Address Book

```shell
defaults read com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"
defaults read com.apple.AddressBook ABBirthDayVisible -bool true
```

## Desktop
  
```shell
defaults write com.apple.finder CreateDesktop -bool false
# Finder > Preferences > General > Show items on the Desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool true
# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true
# Disable Recent Tags
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowSidebar -bool true
# Finder > View > Show Status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Enable Tab View
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder SidebarShowingiCloudDesktop -bool true
# Finder > Preferences > Advance > Keep folders on top
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
# Finder > Preferences > Advance > Remove items from the Bin after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
# Finder > Preferences > General > New Finder windows show
defaults write com.apple.finder NewWindowTarget -string "PfHm"
# Finder > Preferences > General > Open folders in tabs instead of windows
defaults write com.apple.finder FinderSpawnTab -bool true
# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXPreferredSearchViewStyle -string "Nlsv"
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"
# Finder > Preferences > Advance > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Finder > Preferences > Advance > Show warning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true
# Finder > Preferences > Advance > Show warning before emptying the Bin
defaults write com.apple.finder WarnOnEmptyTrash -bool true
# Finder > Preferences > Advance > When performing a search
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder FK_AppCentricShowSidebar -bool true
defaults write com.apple.finder FXICloudDriveEnabled -bool true
defaults write com.apple.finder FXICloudDriveDocuments -bool true
```

> - For configuration which has complex settings, use `PlistBuddy` to set the values.

## Search Recents View Settings

```shell
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ContainerShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowTabView false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowStatusBar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowPathbar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowToolbar true" ~/Library/Preferences/com.apple.finder.plist
```

## Computer View Settings

```shell
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ContainerShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowTabView false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowStatusBar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowToolbar true" ~/Library/Preferences/com.apple.finder.plist
```

## Standard View Settings

```shell
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ExtendedListViewSettingsV2:sortColumn name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ExtendedListViewSettingsV2:sortColumn name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ListViewSettings:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ListViewSettings:sortColumn size" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ListViewSettings:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ListViewSettings:sortColumn size" ~/Library/Preferences/com.apple.finder.plist
```

## iCloud View Settings

```shell
/usr/libexec/PlistBuddy -c "Set :ICloudViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
```

## Apply above settings

```shell
# Apply settings
killall cfprefsd; killall Finder; killall Dock
```
