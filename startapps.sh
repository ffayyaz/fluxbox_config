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
if [ -x /usr/bin/chromium --high-dpi-support --force-device-scale=1 ]; then
    chromium --high-dpi-support --force-device-scale=1 &
fi

#_______ Autostart Home only _______________________________________________

/sbin/ifconfig|egrep '192.168.85.'
if [ "${?}" = "0" ]; then
    #[ -x /usr/bin/icedove ] && icedove &
    # [ -x /usr/bin/pidgin ] && pidgin &
    [ -x /usr/bin/telegram ] && telegram &
fi

#_______ Autostart Ganja only ______________________________________________

if [ "`hostname`" = "ganja" ]; then
    [ -x /usr/bin/xchat ] && xchat &
    if [ -f /media/stuff/music/playlists/recreate.sh ]; then
        /media/stuff/music/playlists/recreate.sh &
    fi
    [ -x /usr/bin/audacious ] && audacious &
    [ -x /usr/bin/icedove ] && icedove &
    # [ -x /usr/bin/pidgin ] && pidgin &
    chromium --high-dpi-support --force-device-scale=1 --app=https://www.soundcloud.com &
    sleep 2
    chromium --high-dpi-support --force-device-scale=1 --app=https://www.mixcloud.com &
    # mouse speed
    xinput --set-prop 9  275 2
    xinput --set-prop 9  276 1
    xinput --set-prop 10 275 2
    xinput --set-prop 10 276 1
fi

#_______ Autostart Netstream only __________________________________________

if [ "`hostname`" = "fayyaz" ]; then
    echo "" > /home/fafa/.xsession-errors
    rsync -arptl --exclude "Singleton*" --delete-before ~/.config/chromium/ ~/.config/google-chrome/
    # [ -x /usr/bin/virtualbox ] && virtualbox &
    [ -x /usr/bin/pidgin ] && pidgin &
    [ -x /usr/bin/hipchat ] && hipchat &
    #[ -x /usr/bin/VBoxManage ] && VBoxManage startvm "Windows 8" &
    # start firstclass
    wine /home/fafa/.wine/drive_c/Program\ Files/FirstClass/fcc32.exe &
    [ -x /usr/bin/icedove ] && icedove &
    #chromium --high-dpi-support -force-device-scale-factor=1  --app=http://zabbix.netstream.ch/zabbix/tr_status.php?ddreset=1&sid=c5e867e180599fde &
    google-chrome --high-dpi-support -force-device-scale-factor=1  --app=http://zabbix.netstream.ch/zabbix/tr_status.php?ddreset=1&sid=c5e867e180599fde &
fi

#____ Netstream notebook
if [ "`hostname`" = "nacho" ]; then
    [ -x /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
fi

#_______ Autostart mobile only _____________________________________________

if [ "`hostname`" = "mobile" ]; then
    #cpufreqterm &
    [ -x /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b0 -z -n 2>&1 &> /tmp/thinkfan.log&
    [ -x /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
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
