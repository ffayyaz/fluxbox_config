#!/bin/bash

#_______ Autostart everywhere ______________________________________________

# start desktop apps
xscreensaver -no-splash &
xclock -analog -twentyfour -update 1 -padding 1 -render -sharp &

# start 2 terminals
urxvt -hold -e bash -c "screen -dR root" &
urxvt -hold -e bash -c "screen -dR fafa" &

# start chats
#skypeforlinux &
#(telegram-desktop 2>&1>/dev/null &)
#(slack 2>&1>/dev/null &)
#(signal-desktop 2>&1>/dev/null &)
#chromium --app=https://web.whatsapp.com/ &

# always start a browser
#chromium &

#_______ Autostart Home only _______________________________________________

# currently nothing

#_______ Autostart Ganja only ______________________________________________

#if [ "$(hostname)" = "ganja" ]; then
#    # remote terminals
#    #urxvt -hold -name URxvt-remote -tn remoteterm & #-e bash -c "ssh mobile" &
#    #urxvt -hold -name URxvt-remote -tn remoteterm & #-e bash -c "ssh mobile-old" &
#
#    thunderbird &
#
#    # sound
#    chromium --app="https://www.soundcloud.com" &
#    chromium --app="https://www.mixcloud.com" &
#    audacious &
#    pavucontrol &
#fi

#_______ Autostart everywhere (final)_______________________________________

## they need to be started at the end, otherwise
## they are not drawn correctly (they overlap the slit)
## BULLCRAP workaround
##messagesterm &
##syslogterm &
##debuglogterm &
##authlogterm &
##kernlogterm &
##topterm &
#mixerterm &
#clockterm &
##calterm &

#_______ random crap________________________________________________________

# ensure ~/.ssh/sockets exists (for multiplexing)
[ ! -d ~/.ssh/sockets ] && mkdir ~/.ssh/sockets && chmod 700 ~/.ssh/sockets
