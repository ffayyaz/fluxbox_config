#!/bin/bash
#
#_______ Autostart everywhere ______________________________________________

[ -f /usr/bin/xscreensaver ]    && xscreensaver -no-splash&
[ -f /usr/bin/xclock ]          && xclock -analog -twentyfour -update 1 -padding 1 -render -sharp&
[ -f /usr/bin/skypeforlinux ]   && skypeforlinux &
#[ -f /usr/bin/skype ]           && skype &
# [ -f /usr/bin/vlc ]             && vlc --avcodec-hw=vaapi --video-wallpaper --zoom 2 --no-osd --qt-start-minimized --qt-notification 0 --qt-system-tray http://iphone-streaming.ustream.tv/uhls/17074538/streams/live/iphone/playlist.m3u8 &

# --enable-remote-extensions is a dirty hack, because all extensions were "lost"
# after reboot, this flag makes them visible/usable again
export CHROMIUM_FLAGS='--enable-remote-extensions --high-dpi-support --force-device-scale-factor=1'

# always start a browser
if [ -f /usr/bin/chromium ]; then
    chromium &
fi

#_______ Autostart Home only _______________________________________________

/sbin/ifconfig|egrep '192.168.85.'
if [ ${?} -eq 0 ]; then
    # [ -f /usr/bin/pidgin ] && pidgin &
    [ -f /usr/bin/telegram ] && telegram &
    [ -f /usr/bin/hipchat ] && hipchat &
    # #chromium --app=https://netstream.hipchat.com/chat &
    # google-chrome --app=https://netstream.hipchat.com/chat &
fi

#_______ Autostart Ganja only ______________________________________________

if [ "`hostname`" = "ganja" ]; then
    [ -f /usr/bin/xchat ] && xchat &
    [ -f /usr/bin/icedove ] && icedove &

    # recreate playlists
    if [ -f /media/stuff/music/playlists/recreate.sh ]; then
        /media/stuff/music/playlists/recreate.sh &
    fi

    # sound
    chromium --app=https://www.soundcloud.com &
    sleep 2
    chromium --app=https://www.mixcloud.com &
    [ -f /usr/bin/audacious ] && audacious &

    # mouse speed
    xinput --set-prop 9  275 2
    xinput --set-prop 9  276 1
    xinput --set-prop 10 275 2
    xinput --set-prop 10 276 1

    # start meteo "app"
    chromium --app="https://meteo.search.ch/images/chart/duebendorf.svg?width=915&height=315&harmonize=1"&
fi

#_______ Autostart Netstream only __________________________________________

if [ "`hostname`" = "fayyaz" ]; then
    [ -f /usr/bin/pidgin ] && pidgin &
    [ -f /usr/bin/hipchat ] && hipchat &
    [ -f /usr/bin/icedove ] && icedove &
    #chromium  --app=https://netstream.hipchat.com/chat &
    #google-chrome  --app=https://netstream.hipchat.com/chat &

    echo "" > /home/fafa/.xsession-errors

    # sync chromium to google-chrome
    rsync -arptl --exclude "Singleton*" --delete-before ~/.config/chromium/ ~/.config/google-chrome/

    # sound
    chromium --app=https://www.soundcloud.com &
    sleep 2
    chromium --app=https://www.mixcloud.com &
    [ -f /usr/bin/audacious ] && audacious &

    # startup windows
    #[ -f /usr/bin/VBoxManage ] && VBoxManage startvm "Windows 8" &

    # start firstclass
    #wine /home/fafa/.wine/drive_c/Program\ Files/FirstClass/fcc32.exe &

    # start meteo "app"
    chromium --app="https://meteo.search.ch/images/chart/duebendorf.svg?width=800&height=300&harmonize=1"&

    # start some desktop windows (zabbix, ...)
    #chromium  --app=http://zabbix.netstream.ch/zabbix/tr_status.php?ddreset=1&sid=c5e867e180599fde &
    #google-chrome  --app=http://zabbix.netstream.ch/zabbix/tr_status.php?ddreset=1&sid=c5e867e180599fde &
fi

#____ Netstream notebook

if [ "`hostname`" = "nacho" ]; then
    [ -f /usr/bin/syndaemon ] && syndaemon -k -i 0.5&
    pkill -9 -f skype # do not start skype on this machine
fi

#_______ Autostart mobile only _____________________________________________

if [ "`hostname`" = "mobile" ]; then
    #cpufreqterm &
    [ -f /usr/sbin/thinkfan ] && sudo thinkfan -s1 -b0 -z -n 2>&1 &> /tmp/thinkfan.log&
    [ -f /usr/bin/syndaemon ] && syndaemon -k -i 0.5&

    # start meteo "app"
    chromium --app="https://meteo.search.ch/images/chart/duebendorf.svg?width=915&height=315&harmonize=1"&
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
sleep 1
calterm &
