#! /bin/bash

WARING_COLOR="\033[0;33m"
ERR_COLOR="\033[0;31m"
NO_COLOR="\033[0m"

LINK="$1"
REPO_ID=""
ORIGINAL_JSON=""
LENGHT=""


REPO_ID="$( echo $LINK | awk -F "com/" '{ print $2 }' )"

if [ -n "$LINK" ]
then
    ORIGINAL_JSON=`curl -s -k -X GET https://api.github.com/repos/"$REPO_ID"/contributors`
    LENGHT=$( echo $ORIGINAL_JSON | jq '.[] | length' )

    if [ -n "$LENGHT" ]
    then
        echo -e "$WARING_COLOR"; echo -e "Repository: $REPO_ID $NO_COLOR";
        echo
        echo "$ORIGINAL_JSON" \
        | jq -r '.[] | select(.contributions > 1) | .login + " " + (.contributions|tostring)' \
        | awk 'BEGIN{
                print "commits  contributor"
                print "-------  ----------"
            }
            {
                printf " %4s     %s \n", $2, $1
            }'
    else
        echo -e "$WARING_COLOR Repository haven't open pull requests $NO_COLOR"
    fi
else
    echo -e "$ERR_COLOR No args $NO_COLOR"
fi