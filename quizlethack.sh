#!/bin/bash

# Download MP3
curl -L -o /tmp/von.mp3 "https://github.com/hoursinblack/quizlethack/raw/main/King%20Von%20-%20Armed%20%26%20Dangerous%20(Audio).mp3"

# Trap mouse (requires Terminal to be allowed in Accessibility settings)
osascript <<EOF
tell application "Terminal"
    activate
    set bounds of front window to {0, 0, 3000, 2000}
    do script "while true; do
    mouseLoc=\$(ioreg -n IOHIDSystem | awk '/HIDPointerAcceleration/ { getline; getline; getline; print }')
    x=\$(osascript -e 'tell app \"System Events\" to get (item 1 of (get bounding rectangle of window of desktop)) + (item 3 of (get bounding rectangle of window of desktop)) / 2')
    y=\$(osascript -e 'tell app \"System Events\" to get (item 2 of (get bounding rectangle of window of desktop)) + (item 4 of (get bounding rectangle of window of desktop)) / 2')
    /usr/bin/env python3 -c 'import Quartz; Quartz.CGWarpMouseCursorPosition(('\"\$x\"', '\"\$y\"'))'
    sleep 0.1
    done"
end tell
EOF

# Play MP3 in background
afplay /tmp/von.mp3 &
VON_PID=$!

# Wait 20 seconds
sleep 20

# Stop playback
kill $VON_PID 2>/dev/null

# Speak goodbye
say "Goodbye"

# Silent shutdown
osascript -e 'tell application "System Events" to shut down'
