#!/bin/bash

MIN_VALUE="100000"
MAX_VALUE="0"

DATE_LIST=""
JQ_VALUES=""
NEW_JQ_VALUES=""
TMP_VALUE=""


JQ_VALUES=$(jq -r '.prices[][]' quotes.json)

while read line_date; read line_value;
do
    TMP_VALUE="$( echo $line_date | sed 's/...$//' )"
    NEW_JQ_VALUES+="$( date -d @"$TMP_VALUE" "+%m-%y" ) $line_value \n"
done <<< "$JQ_VALUES" 

### !!! short list of values
NEW_JQ_VALUES="$( echo -e "$NEW_JQ_VALUES" | grep ^03 )"
DATE_LIST="$( echo "$NEW_JQ_VALUES" | grep ^03 | cut -d " " -f1 | uniq )"

while read date_value;
do
    echo "================================="
    echo "$date_value"
    echo "======"
    TMP_VALUE="$(echo "$NEW_JQ_VALUES" | grep "$date_value" | cut -d " " -f2 )"
#    echo "$TMP_VALUE"

    while read line;    
    do
    awk -v min_val=$MIN_VALUE -v max_val=$MAX_VALUE '{ cur_val=$1;
            if (min_val > cur_val){
                min_val=cur_val
            }
            if (max_val < cur_val){
                max_val=cur_val
            }
        }
        END {
            print "min_val is: " min_val
                print "max_val is: " max_val
            }'
#    echo "$line"
#    echo "$MIN_VALUE"
    echo "loop ****************************"
    echo
    done <<< "$TMP_VALUE"
    
    
done <<< "$DATE_LIST"

#echo "$NEW_JQ_VALUES"
