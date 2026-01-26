#!/bin/bash

#_______ Autostart everywhere ______________________________________________

# start desktop apps
xscreensaver -no-splash &
xclock -analog -twentyfour -update 1 -padding 1 -render -sharp &
urxvt -name messagesterm -title messages -tn messagesterm &
urxvt -name syslogterm -title syslog -tn syslogterm &
urxvt -name debuglogterm -title debug -tn debuglogterm &
urxvt -name authlogterm -title auth -tn authlogterm &
urxvt -name kernlogterm -title kern -tn kernlogterm &
#urxvt -name topterm -title top -tn topterm &
urxvt -name mixerterm -title mixer -tn mixerterm &
urxvt -name clockterm -title clock -tn clockterm & # does not display correctly since style update
urxvt -name calterm -title cal -tn calterm &

# add volumeicon to systray
volumeicon &
# add pnmixer to systray
pnmixer &

sleep 5

# switch to workspace Surf
wmctrl -s 0

# start 2 terminals
urxvt -title ROOT -hold -e bash -c "screen -dR root" &
sleep 1
urxvt -title USER -hold -e bash -c "screen -dR fafa" &

# start chats
pkill -9 -f telegram-web;(telegram-web &>/dev/null &) # telegram-web is a bash function
sleep 1
chromium --app=https://web.skype.com/ &
sleep 1
pkill -9 -f signal-desktop;(signal-desktop &>/dev/null &)
sleep 4
chromium --app=https://web.whatsapp.com/ &
sleep 1

# always start a browser
chromium &

sleep 5

#_______ Autostart Home only _______________________________________________

# currently nothing

#_______ Autostart Ganja only ______________________________________________

if [ "$(hostname)" = "ganja" ]; then
    # remote terminals
    #urxvt -hold -name URxvt-remote -tn remoteterm & #-e bash -c "ssh mobile" &
    #urxvt -hold -name URxvt-remote -tn remoteterm & #-e bash -c "ssh mobile-old" &

    # switch to workspace Music
    wmctrl -s 3

    # sound
    audacious &
    sleep 5
    chromium --app="https://www.soundcloud.com" &
    sleep 1
    chromium --incognito --app="https://www.soundcloud.com" &
    sleep 1
    #chromium --app="https://www.mixcloud.com" &
    #sleep 1
    pavucontrol &
    sleep 1
    easytag /home/fafa &
    sleep 1

    # start radio
    /media/stuff/music/playlists/radio/restartradio.sh &>/dev/null

    sleep 5

    # switch to workspace Mail
    wmctrl -s 4

    thunderbird &
    sleep 5
fi

# switch to first terminal, as some apps (chromium)
# take focus altough they are configure in apps not to do so.
wmctrl -s 0
# change focus back to the terminal
wmctrl -a USER
