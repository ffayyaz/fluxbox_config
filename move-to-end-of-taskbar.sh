#!/bin/sh
# designed to be used with a keyboard shortcut
# in ~/.fluxbox/keys that could be:
# Control Shift Mod4 X :Exec /home/username/bin/move-to-end-of-taskbar.sh
xdotool getactivewindow windowunmap windowmap
