# MacOS Bootstrapping

## Other Apps

- [Scroll Reverser](https://pilotmoon.com/scrollreverser/)
- [FinderFix](https://synappser.github.io/downloads/) (Resize to 1000 x 680)



## Unused

```sh
defaults write com.apple.dock autohide-delay -float 0; defaults delete com.apple.dock autohide-time-modifier; killall Dock
```

```sh
defaults write com.apple.dock autohide-delay -float 0.5; defaults write com.apple.dock autohide-time-modifier -int 0.5 ;killall Dock
```

```sh
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}' && killall Dock
```

```sh
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}' && killall Dock
```

```sh
defaults write com.apple.screencapture type jpg
```

## Touch ID for Sudo

Add the following line to `/etc/pam.d/sudo`

```
auth       sufficient     pam_tid.so
```

For example:

```
# sudo: auth account password session
auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so
```

## References

https://github.com/kevinSuttle/macOS-Defaults
