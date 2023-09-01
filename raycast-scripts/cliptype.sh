#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clip to keyboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⌨️

# Documentation:
# @raycast.description Outputs clipboard content as system keystrokes.
# @raycast.author satrday
# @raycast.authorURL https://saterdalen.me

type_string() {
    inputString="$1"
    osascript -e "tell application \"System Events\"
        repeat with currentChar in characters of \"$inputString\"
            keystroke currentChar
            # delay 0.1 #uncomment to specify a delay between keystrokes
        end repeat
    end tell"
}

# Usage
inputString=$(pbpaste)
type_string "$inputString"
