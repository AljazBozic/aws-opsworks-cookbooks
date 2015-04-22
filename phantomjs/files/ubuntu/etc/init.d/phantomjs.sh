#!/bin/sh
#
# chkconfig: 35 99 99
# description: Script for starting phantomjs. 
#
 
USER="root"
DAEMON="/usr/bin/phantomjs/bin/phantomjs"
LOG_FILE="/var/log/phantomjs"
ARGS="/srv/www/goavio_data/current/phantomjs/server.js"

do_start()
{
        echo -n $"Starting PhantomJS : "
        sudo -u "$USER" "$DAEMON" "$ARGS" >> "$LOG_FILE$" &
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                echo OK
        else
                echo FAIL
        fi
}

do_stop()
{
        echo -n $"Stopping PhantomJS : "
        pid=`ps -aefw | grep "$DAEMON" | grep -v " grep " | awk '{print $2}'`
        kill -9 $pid > /dev/null 2>&1
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                echo OK
        else
                echo FAIL
        fi
}
 
case "$1" in
        start)
                do_start
                ;;
        stop)
                do_stop
                ;;
        restart)
                do_stop
                do_start
                ;;
        *)
                echo "Usage: $0 {start|stop|restart}"
                RETVAL=1
esac
 
exit $RETVAL