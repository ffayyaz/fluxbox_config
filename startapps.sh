#!/bin/bash
#
#_______ Autostart everywhere ______________________________________________

# tools / gadgets
[ -x /usr/bin/xscreensaver ] && xscreensaver -no-splash&
# [ -x /usr/bin/gdeskcal ] && gdeskcal &
[ -x /usr/bin/xclock ] && xclock -analog -twentyfour -update 1 -padding 1 -render -sharp&
# [ -x /usr/bin/xpad ] && xpad &
[ -x /usr/bin/skype ] && skype &

# always start a browser
if [ -x /usr/bin/chromium ]; then
    chromium &
fi
# if [ -x /usr/bin/vivaldi ]; then
    # vivaldi &
# fi

#_______ Autostart Home only _______________________________________________

# /sbin/ifconfig|egrep '192.168.85.'
# if [ "${?}" = "0" ]; then
    # [ -x /usr/bin/icedove ] && icedove &
    # # [ -x /usr/bin/pidgin ] && pidgin &
# fi

#_______ Autostart Ganja only ______________________________________________

if [ "`hostname`" = "ganja" ]; then
    [ -x /usr/bin/xchat ] && xchat &
    if [ -f /media/stuff/music/playlists/recreate.sh ]; then
        /media/stuff/music/playlists/recreate.sh &
    fi
    [ -x /usr/bin/audacious ] && audacious &
    [ -x /usr/bin/icedove ] && icedove &
    # [ -x /usr/bin/pidgin ] && pidgin &
    chromium --app=https://www.soundcloud.com &
    chromium --app=https://www.mixcloud &
fi

#_______ Autostart Netstream only __________________________________________

if [ "`hostname`" = "fayyaz" ]; then
    # [ -x /usr/bin/virtualbox ] && virtualbox &
    [ -x /usr/bin/pidgin ] && pidgin &
    [ -x /usr/bin/VBoxManage ] && VBoxManage startvm "Windows 8" &
    # [ -x /usr/bin/audacious ] && audacious &
    chromium --app=https://mail.business-exchange.ch/owa/?modurl=0 &
    # jira
    #chromium --app=https://jira.netstream.ch/secure/Dashboard.jspa &
    # kayako
    # chromium --app=https://support.netstream.ch/staff/index.php?/Tickets/Manage/MyTickets &
    # chromium --app=https://support.netstream.ch/staff/index.php?/Tickets/Manage/Filter/16/-1/-1 &
    # chromium --app=https://support.netstream.ch/staff/index.php?/Tickets/Manage/Filter/27/-1/-1 &
    # chromium --app=https://support.netstream.ch/staff/index.php?/Tickets/Manage/Filter/31/-1/-1 &
    # agama iptv
    # chromium --app=http://admin.qoe.iptv.ch:8800/enterprise/dashboard &
    # chromium --app=http://admin.qoe.iptv.ch:8800/enterprise/tablestatus &
    # chromium --app=http://admin.qoe.iptv.ch:8800/enterprise/empprobegraph &
    # agama ott
    # chromium --app=http://u0494:8880/ria/dashboard &
    # chromium --app=http://u0494:8880/ria/httpstreamingrunning &
    # chromium --app=http://u0494:8880/ria/httpstreamingresultsearch &
    # secondlevel link lookup
    # chromium --app=https://intranet.netstream.ch/display/op/Secondlevel+Link+Lookup &
    # mdw
    # chromium --app=http://admin.mdw01.iptv.ch:8080/itvadmin/ &
    # chromium --app=http://mdw-preprod.iptv.ch:8080/itvadmin/ &
    # #chromium --app=http://mdw-preview.iptv.ch:8080/itvadmin/ &
    # #chromium --app=http://mdw-preview02.iptv.ch:8080/itvadmin/ &
    # #chromium --app=http://mdw-dev.iptv.ch:8080/itvadmin/ &
    # postman
    # chromium --app-id=fdmmgilgnpjigdojojpjoooidkmcomcm &

    # lynx --dump pikett.netstream.ch|grep Farhan|awk '{print $1" "$2" "$3}'|grep -q "$(date +"%a, %d. %b")"
    # if [ $? -eq 0 ]; then
# 	    # zabbix & nagios
# 	    chromium --app=http://zabbix.netstream.ch/zabbix/dashboard.php &
# 	    chromium --app=http://nagios.netstream.ch/nagios3/ &
# 	fi
fi

#____ Netstream notebook
if [ "`hostname`" = "nacho" ]; then
    [ -x /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
    chromium --app=https://mail.business-exchange.ch/owa/?modurl=0 &
fi

#_______ Autostart mobile only _____________________________________________

if [ "`hostname`" = "mobile" ]; then
    # cpufreqterm &
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
mixerterm &
