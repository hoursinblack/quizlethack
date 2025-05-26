#!/bin/bash

# Download MP3
curl -L -o /tmp/von.mp3 "https://github.com/hoursinblack/quizlethack/raw/main/King%20Von%20-%20Armed%20%26%20Dangerous%20(Audio).mp3"

# Start forcing volume to 100% forever in the background
while true; do
  osascript -e 'set volume output volume 100'
  sleep 0.5
done &
VOLUME_LOOP_PID=$!

# (Optional) Trap mouse — requires Accessibility permissions
osascript <<EOF
tell application "Terminal"
    activate
    set bounds of front window to {0, 0, 3000, 2000}
end tell
EOF

# Play MP3 in background
afplay /tmp/von.mp3 &
MP3_PID=$!

# Wait 20 seconds
sleep 20

# Kill music and volume loop
kill $MP3_PID 2>/dev/null
kill $VOLUME_LOOP_PID 2>/dev/null

# Voice goodbye
say "Goodbye"

# Silent shutdown
osascript -e 'tell application "System Events" to shut down'
