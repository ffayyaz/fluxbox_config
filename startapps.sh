#!/bin/bash

#_______ Autostart everywhere ______________________________________________

# start 2 terminals
urxvt -hold -e bash -c "screen -dR root" &
urxvt -hold -e bash -c "screen -dR fafa" &

[ -f /usr/bin/xscreensaver ]    && xscreensaver -no-splash&
[ -f /usr/bin/xclock ]          && xclock -analog -twentyfour -update 1 -padding 1 -render -sharp&
[ -f /usr/bin/skypeforlinux ]   && skypeforlinux &
[ -f /usr/bin/telegram ]        && telegram &
[ -f /usr/bin/slack ]           && slack &

# --enable-remote-extensions is a dirty hack, because all extensions were "lost"
# after reboot, this flag makes them visible/usable again
export CHROMIUM_FLAGS="--enable-remote-extensions --high-dpi-support --force-device-scale-factor=1"

MY_IP=$(/usr/bin/curl -s ipinfo.io/ip)
export MY_IP

# always start a browser
[ -f /usr/bin/chromium ]        && chromium &
[ -f /usr/bin/chromium ]        && chromium --app=https://web.whatsapp.com/ &

#_______ Autostart Home only _______________________________________________

# currently nothing

#_______ Autostart Ganja only ______________________________________________

if [ "$(hostname)" = "ganja" ]; then
    # remote terminals
    urxvt -hold -name URxvt-remote -tn remoteterm #-e bash -c "ssh mobile" &
    urxvt -hold -name URxvt-remote -tn remoteterm #-e bash -c "ssh mobile-old" &

    [ -f /usr/bin/thunderbird ] && thunderbird &

    # sound
    chromium --app="https://www.soundcloud.com" &
    #sleep 2
    chromium --app="https://www.mixcloud.com" &
    [ -f /usr/bin/audacious ]   && audacious &
    [ -f /usr/bin/pavucontrol ]   && pavucontrol &

    # mouse speed
    xinput --set-prop 9  275 2
    xinput --set-prop 9  276 1
    xinput --set-prop 10 275 2
    xinput --set-prop 10 276 1
fi

#_______ Autostart mobile only _____________________________________________

if [ "$(hostname)" = "mobile" ]; then
    cpufreqterm &
    [ -f /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b0 -z -n|tee /tmp/thinkfan.log&
    [ -f /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
fi

#_______ Autostart everywhere (final)_______________________________________


# they need to be started at the end, otherwise
# they are not drawn correctly (they overlap the slit)
# BULLCRAP workaround
#messagesterm &
#syslogterm &
#debuglogterm &
#authlogterm &
#kernlogterm &
#topterm &
mixerterm &
#calterm &

#_______ random crap________________________________________________________

# ensure ~/.ssh/sockets exists (for multiplexing)
[ ! -d ~/.ssh/sockets ] && mkdir ~/.ssh/sockets && chmod 700 ~/.ssh/sockets
