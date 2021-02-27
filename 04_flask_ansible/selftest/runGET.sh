#! /bin/bash

HOST_ADDR=$1
COUNT=""

while read line;
do
    COUNT=`shuf -i 1-5 -n 1`
    curl -X GET "http://$HOST_ADDR/?word=$line&count=$COUNT"
 
done < emoji_list
