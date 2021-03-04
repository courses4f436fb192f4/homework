#!/bin/bash

WARING_COLOR="\033[0;33m"
ERR_COLOR="\033[0;31m"
NO_COLOR="\033[0m"

ARG_OPTION="$1"
ARG_DATE=""

DATE_LIST=""
JQ_VALUES=""
NEW_JQ_VALUES=""
TMP_VALUE=""
RESULTS_VALUE=""

JQ_VALUES=$(jq -r '.prices[][]' quotes.json)

while read line_date; read line_value;
do
    NEW_JQ_VALUES+="$( date -d @$((line_date/1000)) "+%m-%Y" ) $line_value \n"
done <<< "$JQ_VALUES"


case "$ARG_OPTION" in
    "-m")

        case "$2" in 
            [1-9]|1[0-2])
                ARG_DATE=`date -d "$2/01" +%m`
                ;;
            0[1-9]|1[0-2])
                ARG_DATE=`date -d "$2/01" +%m`
                ;;
            *)
                echo "$WARING_COLOR \b12 months in a year $NO_COLOR"
                exit 1
        esac
        ### !!! short list of values
        NEW_JQ_VALUES="$( echo -e "$NEW_JQ_VALUES" | grep ^"$ARG_DATE" )"
        DATE_LIST="$( echo "$NEW_JQ_VALUES" | grep ^"$ARG_DATE" | cut -d " " -f1 | uniq )"
    ;;
    "-y")
        NEW_JQ_VALUES="$( echo -e "$NEW_JQ_VALUES" | grep "$2" )"
        DATE_LIST="$( echo "$NEW_JQ_VALUES" | grep "$2" | cut -d " " -f1 | uniq )"

        if ! echo "$DATE_LIST" | grep "$2" >> /dev/null
        then
            echo -e "$ERR_COLOR \bNo year $2 in a list $NO_COLOR"
            exit 1
        fi
    ;;
       *)
            echo "Optons '-m' for month or '-y' for year"
            exit 1
    ;;
esac

while read date_value;
do

    TMP_VALUE="$(echo "$NEW_JQ_VALUES" | grep "$date_value" | cut -d " " -f2 )"

    RESULTS_VALUE+="$date_value "
    while read line;    
    do
    RESULTS_VALUE+="$(awk -v min_val=1000 -v max_val=0 '{ cur_val=$1;
            if (min_val > cur_val){
                min_val=cur_val
            }
            if (max_val < cur_val){
                max_val=cur_val
            }
        }
        END {
                print min_val " " max_val " " (max_val-min_val)/2
            }')\n"
    done <<< "$TMP_VALUE"    
done <<< "$DATE_LIST"

RESULTS_VALUE=$( echo -e "$RESULTS_VALUE" | sort "-nk 4" | sed '/^$/d')

echo
echo "The least volatile in: "
echo -en "$WARING_COLOR"
echo -en "$RESULTS_VALUE" | head -n 1 | cut -d " " -f1
echo -en "$NO_COLOR"
echo "and equls:"
echo -en "$WARING_COLOR"
echo -e "$RESULTS_VALUE" | head -n 1 | cut -d " " -f4
echo -e "$NO_COLOR"

echo -e "$RESULTS_VALUE" | awk 'BEGIN{
    print "date     min     max     volatile"
    }
    {
    printf "%-8s %3.4f %3.4f %3.4f\n", $1, $2, $3, $4
}'
echo