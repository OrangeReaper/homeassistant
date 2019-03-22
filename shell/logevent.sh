#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "You must enter exactly 1 command line argument"
    exit
fi
path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
path="$path/shell.log"
now_date=$(date +"%d-%b-%Y")
now_time=$(date +"%T")
#echo $now_date
#echo $now_time
echo "$now_date $now_time $1" >> $path
