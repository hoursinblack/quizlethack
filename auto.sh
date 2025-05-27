#!/bin/bash

# Image URLs
wallpapers=(
"https://i.ytimg.com/vi/AOv0UPii-Vo/sddefault.jpg"
"https://cdn.britannica.com/34/240534-050-B8C4B11E/Porcupine-fish-Diodon-hystox.jpg"
"https://i1.sndcdn.com/avatars-zaCUjzWzmpQ5cqzn-4EqdxQ-t1080x1080.jpg"
)

# Loop forever
while true; do
  sleep $((RANDOM % 60 + 30))

  # Random wallpaper
  wp="${wallpapers[$RANDOM % ${#wallpapers[@]}]}"
  curl -s -o /tmp/prank.jpg "$wp"
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/tmp/prank.jpg"'

  # Quick invert flash
  defaults write com.apple.universalaccess invertDisplay -bool true
  killall Dock
  sleep 0.2
  defaults write com.apple.universalaccess invertDisplay -bool false
  killall Dock

  # Roll for rare glitch trigger
  roll=$((RANDOM % 100 + 1))
  if [ "$roll" -eq 100 ]; then
    # Alert popup
    osascript -e 'display dialog "You have angered King Von." with title "⚠️ SYSTEM ALERT" buttons {"Close"} with icon stop'

    # Glitch flicker
    for i in {1..10}; do
      defaults write com.apple.universalaccess invertDisplay -bool true
      killall Dock
      sleep 0.1
      defaults write com.apple.universalaccess invertDisplay -bool false
      killall Dock
      sleep 0.1
    done

    # Close all visible apps except Terminal
    apps=$(osascript -e 'tell application "System Events" to get name of (every process whose background only is false)')
    for app in $apps; do
      if [[ "$app" != "Terminal" && "$app" != "Finder" ]]; then
        osascript -e "try" -e "quit app \"$app\"" -e "end try"
      fi
    done
  fi
done
