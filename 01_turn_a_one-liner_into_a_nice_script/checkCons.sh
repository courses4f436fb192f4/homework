#!/bin/bash

WARING_COLOR="\033[0;33m"
ERR_COLOR="\033[0;31m"
NO_COLOR="\033[0m"

INPUT_PROCESS="$1"
INPUT_FIELD_TO_VIEW=""
TMP_VALUE=""
OPERATION_EXIT_CODE=""
CONN_LINE=""
CONN_LINE_TMP=""

f_check_if_process_exist()
{
    if [ ! -z "${INPUT_PROCESS##*[!0-9]*}" ]
        then
            echo "PID"
            if [ -d "/proc/$INPUT_PROCESS" ]  
            then
                netstat -tunapl | grep $INPUT_PROCESS > /dev/null
                OPERATION_EXIT_CODE=$?
            else
                echo "doesnt exists"
                OPERATION_EXIT_CODE="1"
            fi  
        else
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
        INPUT_FIELD_TO_VIEW="Organization"
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

        if [ "$OPERATION_EXIT_CODE" -eq 0 ]
        then
            echo -e  "$WARING_COLOR USING netstat $NO_COLOR"

            TMP_VALUE=`netstat -tunapl`
            TMP_VALUE=$(awk "/$INPUT_PROCESS/ {print \$5}" <<< "$TMP_VALUE")
            TMP_VALUE=`echo -e "$TMP_VALUE" | grep -oP '(\d+\.){3}\d+' | uniq`

            echo -e "$WARING_COLOR IN_PROGRESS:";
            while read IP
            do
            echo -e -n "*"
                CONN_LINE_TMP=`whois "$IP" | awk -F":" "/"^"$INPUT_FIELD_TO_VIEW/ {print \$2}"`
                if [ -n "$CONN_LINE_TMP" ]
                then
                    CONN_LINE+="$CONN_LINE_TMP\n"
                else
                    CONN_LINE+="$INPUT_FIELD_TO_VIEW: $IP\n"
                fi
            done <<< "$TMP_VALUE" 
            echo -e "$NO_COLOR"
        else
            echo -e "$WARING_COLOR Process doesn't have any connections $NO_COLOR"
        fi
    fi
else
    echo -e "$WARING_COLOR No args $NO_COLOR" 
fi
    
while read line
do
    echo "Connections count: $line"
done <<< "$( echo -e "$CONN_LINE" | sort | uniq -c | sed 's/Organization://g' )"