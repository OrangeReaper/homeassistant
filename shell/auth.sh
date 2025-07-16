#!/bin/bash
path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $path/ipAddresses.sh
echo $lightwaverf
echo -ne "100,\!F*p." | nc -u -w1 $lightwaverf 9760
