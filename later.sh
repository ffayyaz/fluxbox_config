#!/bin/bash
[ -x /usr/bin/skype ] && skype &
if [ -x /usr/bin/chromium ]; then
	chromium &
    sleep 1
	chromium --app=https://www.soundcloud.com &
    sleep 1
	chromium --app=https://mail.business-exchange.ch/owa/?modurl=0 &
fi

sleep 1
[ -x /usr/bin/audacious ] && audacious &

#_______ Autostart Home only _______________________________________________
/sbin/ifconfig|egrep '192.168.85.(10|14|21|22)'
if [ "${?}" = "0" ]; then
    sleep 10
	[ -x /usr/bin/icedove ] && icedove &
fi

#_______ Autostart Ganja only ______________________________________________
/sbin/ifconfig|egrep '192.168.85.10'
if [ "${?}" = "0" ]; then
    sleep 2
	[ -x /usr/bin/xchat ] && xchat &
fi

#_______ Autostart Netstream only __________________________________________
/sbin/ifconfig|egrep '192.168.1.116'
if [ "${?}" = "0" ]; then
    sleep 1
	[ -x /usr/bin/virtualbox ] && virtualbox &
	[ -x /usr/bin/pidgin ] && pidgin &
fi

#_______ Autostart mobile only _____________________________________________
if [ "`hostname`" = "mobile" ]; then
    sleep 1
	cpufreqterm &
	[ -x /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b30 -z -n&
	[ -x /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
fi

#_______ Autostart everywhere (final)_______________________________________

urxvt &

sleep 1

# they need to be started at the end, otherwise
# they are not drawn correctly (they overlap the slit)
# BULLCRAP workaround
# maybe this problem is solved using the sleep solution to start fluxbox
messagesterm &
syslogterm &
debuglogterm &
# dmesglogterm &
authlogterm &
kernlogterm &
# diskusageterm &
mixerterm&
