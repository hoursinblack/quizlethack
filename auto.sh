#!/bin/bash

# Wallpaper URLs
wallpapers=(
"https://i.ytimg.com/vi/AOv0UPii-Vo/sddefault.jpg"
"https://cdn.britannica.com/34/240534-050-B8C4B11E/Porcupine-fish-Diodon-hystox.jpg"
"https://i1.sndcdn.com/avatars-zaCUjzWzmpQ5cqzn-4EqdxQ-t1080x1080.jpg"
)

cycle=0

while true; do
  # Force roll to 100 after 100 loops
  if [ "$cycle" -ge 100 ]; then
    roll=100
  else
    roll=$((RANDOM % 100 + 1))
  fi
  ((cycle++))

  # Download wallpaper to a persistent and valid path
  wp="${wallpapers[$RANDOM % ${#wallpapers[@]}]}"
  curl -s -o "$HOME/Downloads/prank_wall.jpg" "$wp"

  # Validate file actually downloaded
  if [ -f "$HOME/Downloads/prank_wall.jpg" ]; then
    osascript -e 'tell application "System Events" to tell every desktop to set picture to POSIX file "'"$HOME/Downloads/prank_wall.jpg"'"'
  fi

  # Speed logic: higher roll = faster change
  wait_time=$(awk -v r="$roll" 'BEGIN { printf "%.2f", 3 - (r * 0.029) }')
  sleep "$wait_time"

  # On 100 roll — show popup, then keep going
  if [ "$roll" -eq 100 ]; then
    osascript -e 'display dialog "king von is here" with title "GEORGE DROID DEFENSE SYSTEM" buttons {"accept your fate"} with icon note giving up after 3'
    cycle=0
  fi
done

