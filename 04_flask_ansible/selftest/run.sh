#! /bin/bash

HOST_ADDR=$1

while read line;
do
    curl -X POST -d "{\"word\":\"$line\", \"count\": 3}" http://"$HOST_ADDR"/
 
done < emoji_list
