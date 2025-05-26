#!/bin/bash

# Quit key apps
osascript -e 'quit app "Google Chrome"'
osascript -e 'quit app "Safari"'
osascript -e 'quit app "Spotify"'

# Set volume to max
osascript -e 'set volume output volume 100'

# Wait for dramatic effect
sleep 2

# Speak the message
say "Police steady watching me. Every day they clockin me."

# Silent system shutdown (no sudo)
osascript -e 'tell application "System Events" to shut down'
