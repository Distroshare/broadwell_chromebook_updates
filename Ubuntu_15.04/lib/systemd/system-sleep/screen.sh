#!/bin/bash

#Workaround for light locker: https://bugs.launchpad.net/ubuntu/+source/xubuntu-default-settings/+bug/1303736


# Taken from: http://askubuntu.com/questions/20585/how-to-lock-xscreensaver-on-suspend
# Lock xscreensaver on resume from a suspend.
# getXuser gets the X user belonging to the display in $displaynum.
# If you want the foreground X user, use getXconsole!

getXuser() {
    export user=`pinky -fw | awk '{ if ($2 == ":'$displaynum'" || $(NF) == ":'$displaynum'" ) { print $1; exit; } }'`
}

for x in /tmp/.X11-unix/*; do
    displaynum=`echo $x | sed s#/tmp/.X11-unix/X##`
    getXuser;
    case $1/$2 in
	pre/*)
	;;
	post/*)
	    getXuser;
	    sudo -u $user env DISPLAY=":$displaynum" /usr/bin/xrandr --auto
	    ;;
    esac
done
exit 0
