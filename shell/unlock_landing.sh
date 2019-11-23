#!/bin/bash
path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $path/ipAddresses.sh
#Unlock Landing
echo -n "004,\!R3D6Fu" | nc -u -w1 $lightwaverf 9760
sleep 20
echo -n "004,\!R3D6Fu" | nc -u -w1 $lightwaverf 9760
$path/logevent.sh "Landing Unlocked"
