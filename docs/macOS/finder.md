# Configure Finder, Dock & Global preferences

## Finder

```bash
# Finder View Style (set as default)

sudo find / -name .DS_Store -delete

/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ContainerShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowTabView false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowStatusBar true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowPathbar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :SearchRecentsViewSettings:WindowState:ShowToolbar true" ~/Library/Preferences/com.apple.finder.plist

/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ContainerShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowTabView false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowStatusBar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ComputerViewSettings:WindowState:ShowToolbar true" ~/Library/Preferences/com.apple.finder.plist

/usr/libexec/PlistBuddy -c "Set :FinderSpawnTab false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ShowStatusBar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ShowHardDrivesOnDesktop false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXPreferredViewStyle Nlsv" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXArrangeGroupViewBy Name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXPreferredGroupBy Kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXDefaultSearchScope SCcf" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXPreferredSearchViewStyle Nlsv" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :NewWindowTarget PfHm" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ShowPathbar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ShowExternalHardDrivesOnDesktop true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :_FXSortFoldersFirstOnDesktop true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_AppCentricShowSidebar true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXICloudDriveEnabled true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FXICloudDriveDocuments true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :_FXSortFoldersFirst true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :ShowRecentTags false" ~/Library/Preferences/com.apple.finder.plist

/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ExtendedListViewSettingsV2:sortColumn name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ExtendedListViewSettingsV2:sortColumn name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ListViewSettings:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:ListViewSettings:sortColumn size" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ListViewSettings:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ListViewSettings:sortColumn size" ~/Library/Preferences/com.apple.finder.plist

/usr/libexec/PlistBuddy -c "Set :ICloudViewSettings:ExtendedListViewSettingsV2:showIconPreview false" ~/Library/Preferences/com.apple.finder.plist

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder > View > Show Status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Disable Recent Tags
defaults write com.apple.finder ShowRecentTags -bool false

# Disable Tab View
defaults write com.apple.finder ShowTabView -bool false

# Finder > Preferences > General > Show items on the Desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder > Preferences > General > New Finder windows show
defaults write com.apple.finder NewWindowTarget -string "PfHm"
#defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

# Finder > Preferences > General > Open folders in tabs instead of windows
defaults write com.apple.finder FinderSpawnTab -bool true

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > Preferences > Advance > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > Preferences > Advance > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > Preferences > Advance > Show wraning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true

# Finder > Preferences > Advance > Show warning before emptying the Bin
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# Finder > Preferences > Advance > Remove items from the Bin after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Finder > Preferences > Advance > Keep folders on top
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Finder > Preferences > Advance > When performing a search
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Google Chrome Auto Update
defaults write com.google.keystone.agent checkInterval 0

# Apply settings
killall cfprefsd; killall Finder; killall Dock
```

## Dock

```bash
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -integer 36
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mod-count -integer 565
killall Dock
```

## Global Preferences

```bash
defaults write -g AppleInterfaceStyle -string Dark
defaults write -g AppleShowAllExtensions -bool true
defaults write -g NSPersonNameDefaultDisplayNameOrder -integer 1
defaults write -g NSPersonNameDefaultShortNameEnabled -integer 1
defaults write -g NSPersonNameDefaultShortNameFormat -integer 1
defaults write -g NSQuitAlwaysKeepsWindows -bool true
killall Dock
```
