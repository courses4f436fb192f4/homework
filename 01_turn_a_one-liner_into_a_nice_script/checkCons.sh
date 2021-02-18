#!/bin/bash

######
# Author:
# Creation date: 17.02.2021
# Last updateted: 18.02.2021
#
######


#set -x
WARING_COLOR="\033[0;33m"
ERR_COLOR="\033[0;31m"
NO_COLOR="\033[0m"


INPUT_ARG="$1"
TMP_VALUE=""

if [ -n "$*" ]
then
    if [ "$1" = "help" ]
    then
        cat "./help"
    else
        echo -e  "$WARING_COLOR using netstat $NO_COLOR"

        TMP_VALUE=`netstat -tunapl`
        TMP_VALUE=$(awk "/$INPUT_ARG/ {print \$5}" <<< "$TMP_VALUE")
        TMP_VALUE=$( echo -e "$TMP_VALUE" | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' )
        #echo "$TMP_VALUE"
            
        if [ -z "$TMP_VALUE" ]
        then
            echo -e "$WARING_COLOR Process doesn't have any connections $NO_COLOR"
        else
            while read IP
            do
                echo "`whois $IP | grep Organization`"
                #awk -F':' '/^Organization/ {print $2}'
            done <<< "$TMP_VALUE"               
        fi
    fi
else
    echo -e "$WARING_COLOR No args $NO_COLOR" 
fi
