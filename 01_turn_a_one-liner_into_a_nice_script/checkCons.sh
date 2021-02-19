#!/bin/bash

WARING_COLOR="\033[0;33m"
ERR_COLOR="\033[0;31m"
NO_COLOR="\033[0m"


INPUT_PROCESS="$1"
INPUT_FIELD_TO_VIEW="$2"
TMP_VALUE=""
OPERATION_EXIT_CODE=""


f_check_if_process_exist()
{
    if [ ! -z "${INPUT_PROCESS##*[!0-9]*}" ]
        then
            echo "PID"
            if [ -d "/proc/$INPUT_PROCESS" ]  
            then
                echo "pid exists"
                netstat -tunapl | grep $INPUT_PROCESS
                OPERATION_EXIT_CODE=$?
            else
                echo "doesnt exists"
                OPERATION_EXIT_CODE="1"
            fi  
        else
            echo "PROCESS NAME"
            if pgrep "$INPUT_PROCESS" > /dev/null
            then
                OPERATION_EXIT_CODE="$?"
            fi 
    fi
}

f_check_if_arg_2_exist()
{
    if [ -z "$INPUT_FIELD_TO_VIEW" ]
    then
        INPUT_FIELD_TO_VIEW="^Organization"
    fi
}

if [ -n "$*" ]
then
    if [ "$1" = "help" ]
    then
        cat "./help"
    else

        f_check_if_process_exist
        f_check_if_arg_2_exist

        echo "OPERATION_EXIT_CODE: $OPERATION_EXIT_CODE"
        if [ "$OPERATION_EXIT_CODE" -eq 0 ]
        then
            echo -e  "$WARING_COLOR using netstat $NO_COLOR"

            TMP_VALUE=`netstat -tunapl`
            TMP_VALUE=$(awk "/$INPUT_PROCESS/ {print \$5}" <<< "$TMP_VALUE")
            TMP_VALUE=$( echo -e "$TMP_VALUE" | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' )
            
            while read IP
            do
                whois "$IP" | awk -F":" "/$INPUT_FIELD_TO_VIEW/ {print \$2}"
            done <<< "$TMP_VALUE" 
        else
            echo -e "$WARING_COLOR Process doesn't have any connections $NO_COLOR"
        fi
    fi
else
    echo -e "$WARING_COLOR No args $NO_COLOR" 
fi
