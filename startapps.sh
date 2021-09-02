#!/bin/bash

#_______ Autostart everywhere ______________________________________________

# start desktop apps
xscreensaver -no-splash &
xclock -analog -twentyfour -update 1 -padding 1 -render -sharp &
#urxvt -name messagesterm -title messages -tn messagesterm &
#urxvt -name syslogterm -title syslog -tn syslogterm &
#urxvt -name debuglogterm -title debug -tn debuglogterm &
#urxvt -name authlogterm -title auth -tn authlogterm &
#urxvt -name kernlogterm -title kern -tn kernlogterm &
#urxvt -name topterm -title top -tn topterm &
urxvt -name mixerterm -title mixer -tn mixerterm &
urxvt -name clockterm -title clock -tn clockterm &
urxvt -name calterm -title cal -tn calterm &

# start 2 terminals
urxvt -title ROOT -hold -e bash -c "screen -dR root" &
sleep 1
urxvt -title USER -hold -e bash -c "screen -dR fafa" &

# start chats
(telegram-desktop 2>&1>/dev/null &)
sleep 1
skypeforlinux &
sleep 1
(slack 2>&1>/dev/null &)
sleep 1
(signal-desktop 2>&1>/dev/null &)
sleep 3
chromium --app=https://web.whatsapp.com/ &
sleep 1

# always start a browser
chromium &
sleep 1

#_______ Autostart Home only _______________________________________________

# currently nothing

#_______ Autostart Ganja only ______________________________________________

if [ "$(hostname)" = "ganja" ]; then
    # remote terminals
    #urxvt -hold -name URxvt-remote -tn remoteterm & #-e bash -c "ssh mobile" &
    #urxvt -hold -name URxvt-remote -tn remoteterm & #-e bash -c "ssh mobile-old" &

    thunderbird &

    # sound
    audacious &
    sleep 1
    chromium --app="https://www.soundcloud.com" &
    sleep 1
    chromium --app="https://www.mixcloud.com" &
    sleep 1
    pavucontrol &
fi

# change focus back to the terminal
wmctrl -a USER
