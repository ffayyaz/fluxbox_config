#!/bin/bash

# bullshit sleep, otherwise everything gui-wise does not start
# because some issue with DISPLAY
sleep 10

#_______ Autostart everywhere ______________________________________________

[ -f /usr/bin/xscreensaver ]    && xscreensaver -no-splash&
[ -f /usr/bin/xclock ]          && xclock -analog -twentyfour -update 1 -padding 1 -render -sharp&
[ -f /usr/bin/skypeforlinux ]   && skypeforlinux &

# --enable-remote-extensions is a dirty hack, because all extensions were "lost"
# after reboot, this flag makes them visible/usable again
export CHROMIUM_FLAGS="--enable-remote-extensions --high-dpi-support --force-device-scale-factor=1"

# always start a browser
[ -f /usr/bin/chromium ]        && chromium &

#_______ Autostart Home only _______________________________________________

/sbin/ifconfig|egrep '192.168.85.'
if [ ${?} -eq 0 ]; then
    [ -f /usr/bin/pidgin ]      && pidgin &
    sleep 0.5
    [ -f /usr/bin/telegram ]    && telegram &
    sleep 0.5
    [ -f /usr/bin/hipchat ]     && hipchat &
    sleep 0.5
fi

#_______ Autostart Ganja only ______________________________________________

if [ "`hostname`" = "ganja" ]; then
    [ -f /usr/bin/thunderbird ] && thunderbird &

    # sound
    chromium --app="https://www.soundcloud.com" &
    sleep 2
    chromium --app="https://www.mixcloud.com" &
    [ -f /usr/bin/audacious ]   && audacious &

    # mouse speed
    xinput --set-prop 9  275 2
    xinput --set-prop 9  276 1
    xinput --set-prop 10 275 2
    xinput --set-prop 10 276 1
fi

#_______ Autostart Netstream only __________________________________________

if [ "`hostname`" = "fayyaz" ]; then
    [ -f /usr/bin/pidgin ]      && pidgin &
    sleep 0.5
    [ -f /usr/bin/hipchat ]     && hipchat &
    sleep 0.5
    [ -f /usr/bin/thunderbird ] && thunderbird &
    sleep 0.5

    # sync chromium to google-chrome
    rsync -arptl --exclude "Singleton*" --delete-before ~/.config/chromium/ ~/.config/google-chrome/

    sleep 0.5

    google-chrome --app="https://mail.business-exchange.ch/owa/?modurl=0" &

    # sound
    chromium --app="https://www.soundcloud.com" &
    sleep 2
    chromium --app="https://www.mixcloud.com" &
    [ -f /usr/bin/audacious ]   && audacious &

    # startup windows
    #[ -f /usr/bin/VBoxManage ] && VBoxManage startvm "Windows 8" &
fi

#____ Netstream notebook

if [ "`hostname`" = "nacho" ]; then
    [ -f /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
    # kill skype, which was started above
    pkill -9 -f skype
fi

#_______ Autostart mobile only _____________________________________________

if [ "`hostname`" = "mobile" ]; then
    cpufreqterm &
    [ -f /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b0 -z -n 2>&1 &> /tmp/thinkfan.log&
    [ -f /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
fi

#_______ Autostart everywhere (final)_______________________________________

urxvt &

# they need to be started at the end, otherwise
# they are not drawn correctly (they overlap the slit)
# BULLCRAP workaround
# maybe this problem is solved using the sleep solution to start fluxbox
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
