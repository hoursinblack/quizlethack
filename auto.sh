x#!/bin/bash

# Wallpaper URLs
wallpapers=(
"https://i.ytimg.com/vi/AOv0UPii-Vo/sddefault.jpg"
"https://cdn.britannica.com/34/240534-050-B8C4B11E/Porcupine-fish-Diodon-hystox.jpg"
"https://i1.sndcdn.com/avatars-zaCUjzWzmpQ5cqzn-4EqdxQ-t1080x1080.jpg"
)

cycle=0

while true; do
  # Force roll to 100 once we hit 100 cycles
  if [ "$cycle" -ge 100 ]; then
    roll=100
  else
    roll=$((RANDOM % 100 + 1))
  fi
  ((cycle++))

  # Pick random wallpaper
  wp="${wallpapers[$RANDOM % ${#wallpapers[@]}]}"
  curl -s -o /tmp/wall.jpg "$wp"
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/tmp/wall.jpg"'

  # Faster rolls = faster flicker (100 = ~0.1s, 1 = 3s)
  wait_time=$(awk -v r="$roll" 'BEGIN { printf "%.2f", 3 - (r * 0.029) }')
  sleep "$wait_time"

  # Optional: trigger something fun at 100 (but don't break loop)
  if [ "$roll" -eq 100 ]; then
    osascript -e 'display dialog "KING VON HAS REINCARNATED INTO YOUR DISPLAY" with title "GEORGE DROID DEFENSE SYSTEM (GDDS):" buttons {"what?"} with icon note giving up after 3'
    cycle=0 # restart the cycle
  fi
done
