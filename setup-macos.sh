#!/usr/bin/env bash

xcode-select --install
softwareupdate --install-rosetta --agree-to-license


################################################################################
# Trackpad
################################################################################

# Trackpad Speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5

# Set Trackpad 'Click' to Light
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# Enable Tap to Click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool TRUE
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool TRUE
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable 3 Finger Dragging
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool TRUE
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool TRUE
defaults write com.apple.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool TRUE
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0

# Enable App Expose Gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool TRUE


################################################################################
# Keyboard
################################################################################

# To find the app id, use the command: osascript -e 'id of app "SomeApp"'
# For example: osascript -e 'id of app "Visual Studio Code"'
for appId in "com.jetbrains.intellij" \
	"com.jetbrains.goland" \
	"com.jetbrains.pycharm" \
	"com.jetbrains.WebStorm" \
	"com.microsoft.VSCode"; do
    defaults write "${appId}" ApplePressAndHoldEnabled -bool FALSE
done

defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 5


################################################################################
# Dock
################################################################################

# Don't show recents in Dock
defaults write com.apple.dock show-recents -bool TRUE
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock tilesize -float 42.0
defaults write com.apple.dock position-immutable -bool TRUE
defaults write com.apple.dock size-immutable -bool TRUE

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


################################################################################
# Mission Control
################################################################################

# Mission Control - Group by Application
defaults write com.apple.dock expose-group-apps -bool TRUE


################################################################################
# Menu Bar / Control Center
################################################################################

# Control Center Hide NowPlaying
defaults -currentHost write com.apple.controlcenter NowPlaying -int 8

# Control Center Hide Spotlight
defaults delete com.apple.Spotlight "NSStatusItem Visible Item-0"
defaults -currentHost write com.apple.Spotlight -bool TRUE

# Control Center Clock
defaults write com.apple.menuextra.clock ShowDate -int 2
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool FALSE


################################################################################
# Lock Screen / Screen Saver
################################################################################

defaults -currentHost write com.apple.screensaver idleTime -int 0
defaults -currentHost write com.apple.screensaver lastDelayTime -int 1200


################################################################################
# Finder 
################################################################################

defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file:///${HOME}/"
defaults write NSGlobalDomain AppleShowAllExtensions -bool TRUE
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool FALSE
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool FALSE
defaults write com.apple.finder FXRemoveOldTrashItems -bool TRUE
defaults write com.apple.finder WarnOnEmptyTrash -bool FALSE
defaults write com.apple.finder "_FXSortFoldersFirst" -bool TRUE
defaults write com.apple.finder ShowPathbar -bool TRUE
defaults write com.apple.finder ShowStatusBar -bool TRUE

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true


################################################################################
# Launchpad
################################################################################

defaults write com.apple.dock springboard-columns -int 8
defaults write com.apple.dock springboard-rows -int 6
defaults write com.apple.dock ResetLaunchPad -bool true


################################################################################
# Other
################################################################################

# Disable quick note
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-corner -int 0

# Add some XDG stuff
mkdir -p $HOME/.local/state
mkdir -p $HOME/.local/share
mkdir -p $HOME/.config
mkdir -p $HOME/Library/Caches/XdgCache
ln -s $HOME/Library/Caches/XdgCache $HOME/.cache
mkdir -p $HOME/.local/bin


killall Dock
killall Finder
echo "Don't forget to turn off Sounds/Startup Chime"
echo "Don't forget to turn off Displays/True Tone"
echo "Done. Note that some of these changes require a logout/restart to take effect."
