#!/bin/bash

# Quit key apps
osascript -e 'quit app "Google Chrome"'
osascript -e 'quit app "Safari"'
osascript -e 'quit app "Spotify"'

# Set volume to max
osascript -e 'set volume output volume 100'

# Wait 2 seconds
sleep 2

# Speak the line
say "police steady watching me every day they clocking me"

# Shutdown the Mac
sudo shutdown -h now

