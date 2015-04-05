#!/bin/bash
#
#_______ Autostart everywhere ______________________________________________

# tools / gadgets
[ -x /usr/bin/xscreensaver ] && xscreensaver -no-splash&
[ -x /usr/bin/gdeskcal ] && gdeskcal &
[ -x /usr/bin/xclock ] && xclock -analog -twentyfour -update 1 -padding 1 -render -sharp&
[ -x /usr/bin/xpad ] && xpad &

# always start a browser instance
if [ -x /usr/bin/chromium ]; then
    chromium &
fi

#_______ Autostart Home only _______________________________________________

/sbin/ifconfig|egrep '192.168.85.'
if [ "${?}" = "0" ]; then
    [ -x /usr/bin/icedove ] && icedove &
    [ -x /usr/bin/pidgin ] && pidgin &
    [ -x /usr/bin/skype ] && skype &
    (sleep 10;chromium --app=https://mail.business-exchange.ch/owa/?modurl=0) &
    (sleep 10;chromium --app=https://www.soundcloud.com) &
fi

#_______ Autostart Ganja only ______________________________________________

/sbin/ifconfig|egrep '192.168.85.10'
if [ "${?}" = "0" ]; then
[ -x /usr/bin/xchat ] && xchat &
    [ -x /usr/bin/audacious ] && audacious &
fi

#_______ Autostart Netstream only __________________________________________

/sbin/ifconfig|egrep '192.168.1.116'
if [ "${?}" = "0" ]; then
    [ -x /usr/bin/virtualbox ] && virtualbox &
    [ -x /usr/bin/pidgin ] && pidgin &
    [ -x /usr/bin/VBoxManage ] && VBoxManage startvm "Windows 8" &
    [ -x /usr/bin/kate ] && kate -s netstream_notes ~/stuff/notes/`date +"%Y%m%d"`_netstream_notes.txt &
    [ -x /usr/bin/audacious ] && audacious &
    (sleep 10;chromium --app=https://www.soundcloud.com) &
    (sleep 10;chromium --app=https://mail.business-exchange.ch/owa/?modurl=0) &
fi

#____ Netstream notebook
if [ "`hostname`" = "nacho" ]; then
    [ -x /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
    (sleep 10;chromium --app=https://mail.business-exchange.ch/owa/?modurl=0) &
fi

#_______ Autostart mobile only _____________________________________________

if [ "`hostname`" = "mobile" ]; then
    cpufreqterm &
    [ -x /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b0 -z -n 2>&1 &> /tmp/thinkfan.log&
    [ -x /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
fi

#_______ Autostart everywhere (final)_______________________________________

urxvt &

# they need to be started at the end, otherwise
# they are not drawn correctly (they overlap the slit)
# BULLCRAP workaround
# maybe this problem is solved using the sleep solution to start fluxbox
messagesterm &
syslogterm &
debuglogterm &
authlogterm &
kernlogterm &
mixerterm&
