   :ToggleCmd {MacroCmd {} {} {
# params
# 1 - application to start (full path)
# helper applications
WMCTRL=`which wmctrl`;
GREP=`which grep`;
APPLICATION=$1;
BASENAME=`basename $APPLICATION`;
BASENAME=`echo $BASENAME | tr "[:upper:]" "[:lower:]"`
FOUND=0;
function findwindow {
# 1 = BASENAME
# 2 = WMCTRL
# 3 = GREP
        IFS=$'\n';
        for RUNNING in `$2 -l -x`
        do
                if [ `echo $RUNNING | tr "[:upper:]" "[:lower:]" | $3 -c $1` -gt 0 ]
                then
                        HOSTNAME=`hostname`
                        WINDOW=${RUNNING#*${HOSTNAME} }
                        $2 -a $WINDOW
                        FOUND=1;
                fi;
        done
}
findwindow $BASENAME $WMCTRL $GREP;
if [ $FOUND -eq 0 ]
then
        $APPLICATION &
        sleep 2;
        # Try and find the application, after opened
        findwindow $BASENAME $WMCTRL $GREP;
        if [ $FOUND -eq 0 ]
        then
                # Still not found, wait a bit more, and try again
                sleep 3;
                findwindow $BASENAME $WMCTRL $GREP;
        fi
fi
