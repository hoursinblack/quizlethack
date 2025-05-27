#!/bin/bash

# Wallpaper URLs
wallpapers=(
"https://i.ytimg.com/vi/AOv0UPii-Vo/sddefault.jpg"
"https://cdn.britannica.com/34/240534-050-B8C4B11E/Porcupine-fish-Diodon-hystox.jpg"
"https://i1.sndcdn.com/avatars-zaCUjzWzmpQ5cqzn-4EqdxQ-t1080x1080.jpg"
)

# Force it to eventually hit 100 after 100 rolls
cycle=0

while true; do
  # Force roll to reach 100 by cycle 100
  if [ "$cycle" -ge 100 ]; then
    roll=100
  else
    roll=$((RANDOM % 100 + 1))
  fi
  ((cycle++))

  # Set a wallpaper (random)
  wp="${wallpapers[$RANDOM % ${#wallpapers[@]}]}"
  curl -s -o /tmp/prank.jpg "$wp"
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/tmp/prank.jpg"'

  # Calculate wait time: higher roll = shorter delay
  # roll 1 → 3 sec | roll 100 → 0.1 sec
  wait_time=$(awk -v r="$roll" 'BEGIN { print 3 - (r * 0.029) }')
  sleep "$wait_time"

  # If roll hits 100 — optional effect
  if [ "$roll" -eq 100 ]; then
    osascript -e 'display dialog "GEORGE DROID SYSTEM INIATED" with title "KING VON IS ANGERED" buttons {"oh"} with icon caution'
    break
  fi
done

