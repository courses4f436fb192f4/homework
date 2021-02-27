#! /bin/bash

HOST_ADDR=$1
COUNT=""

while read line;
do
    COUNT=`shuf -i 1-5 -n 1`
    curl -X POST -d "{\"word\":\"$line\", \"count\": $COUNT}" http://"$HOST_ADDR"/
 
done < emoji_list
