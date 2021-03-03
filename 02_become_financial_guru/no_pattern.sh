#!/bin/bash 

echo "source line"
echo 'jq -r '.prices[][]' quotes.json | grep -oP '\d+\.\d+' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}' '
jq -r '.prices[][]' quotes.json | grep -oP '\d+\.\d+' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'

echo

echo "without any patern matching"
echo 'jq -r '.prices[][1]' quotes.json | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}' '
jq -r '.prices[][1]' quotes.json | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'
