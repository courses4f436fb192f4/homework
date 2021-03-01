#! /bin/bash

WARING_COLOR="\033[0;33m"
NO_COLOR="\033[0m"

LINK="$1"
ID=""
DATA=""

ID="$( echo $LINK | awk -F "com/" '{ print $2 }' )"

if [ -n "$LINK" ]
then
    DATA=`curl -k -X GET https://api.github.com/repos/"$ID"/pulls?state=open`

    DATA=$( echo $DATA | jq '.[] | length' )

    [ -n "$DATA" ] && echo "Repository have open pull requests"

    [ -z "$DATA" ] && echo "Repository haven't open pull requests"

else
    echo -e "$WARING_COLOR No args $NO_COLOR"
fi