#!/bin/bash
    #_______ Autostart everywhere ______________________________________________

    # tools / gadgets
    [ -x /usr/bin/xscreensaver ] && xscreensaver -no-splash&
    [ -x /usr/bin/gdeskcal ] && gdeskcal &
    [ -x /usr/bin/xclock ] && xclock -analog -twentyfour -update 1 -padding 1 -render -sharp&
    #     [ -x /usr/bin/liferea ] && liferea &
    [ -x /usr/bin/xpad ] && xpad &

    # eye candies
    #[ -x /usr/bin/xfishtank ] && xfishtank &
    #[ -x /usr/bin/xdesktopwaves ] && xdesktopwaves -c 5 -vs 5 -li 9 -nwm -si 4 -lal 50 -laz 0 -fr 75 -sf 2 &
    #[ -x /usr/bin/xsnow ] && xsnow -snowflakes 25 -windtimer 20 -nosanta -notrees -nokeepsnowonscreen -sc darkred -whirl 1 -xspeed 4 -yspeed 7 -wsnowdepth 25 &
    #[ -x /usr/bin/xsnow ] && xsnow -snowflakes 350 -windtimer 20 -nosanta -notrees -nokeepsnowonscreen -nokeepsnowonwindows -sc darkcyan -whirl 1 -xspeed 4 -yspeed 7 &

    if [ -x /usr/bin/chromium ]; then
        chromium &
        # chromium --app=https://www.soundcloud.com &
        # chromium --app=https://mail.business-exchange.ch/owa/?modurl=0 &
        # chromium --app=http://www.tagi.ch &
        # chromium --app=http://www.20min.ch &
    fi

    [ -x /usr/bin/audacious ] && audacious &

    #_______ Autostart Home only _______________________________________________

    /sbin/ifconfig|egrep '192.168.85.(10|14|21|22)'
    if [ "${?}" = "0" ]; then
        [ -x /usr/bin/icedove ] && icedove &
    fi

    #_______ Autostart Ganja only ______________________________________________

    /sbin/ifconfig|egrep '192.168.85.10'
    if [ "${?}" = "0" ]; then
		[ -x /usr/bin/xchat ] && xchat &
    fi

    #_______ Autostart Netstream only __________________________________________

    /sbin/ifconfig|egrep '192.168.1.116'
    if [ "${?}" = "0" ]; then
        [ -x /usr/bin/virtualbox ] && virtualbox &
        [ -x /usr/bin/pidgin ] && pidgin &
        [ -x /usr/bin/VBoxManage ] && VBoxManage startvm "Windows 8" &
        [ -x /usr/bin/kate ] && kate -s netstream_notes ~/stuff/notes/`date +"%Y%m%d"`_netstream_notes.txt &
    fi

    #_______ Autostart mobile only _____________________________________________

    if [ "`hostname`" = "mobile" ]; then
        cpufreqterm &
		[ -x /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b0 -z -n&
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
    # dmesglogterm &
    authlogterm &
    kernlogterm &
    # diskusageterm &
    mixerterm&

    sleep 1
        chromium --app=https://www.soundcloud.com &
    sleep 1
        chromium --app=https://mail.business-exchange.ch/owa/?modurl=0 &
    sleep 1
        chromium --app=http://www.tagi.ch &
    sleep 1
        chromium --app=http://www.20min.ch &
