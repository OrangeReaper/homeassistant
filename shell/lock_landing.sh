#!/bin/bash
source /home/homeassistant/.homeassistant/shell/ipAddresses.sh
#turn off Landing
echo -n "004,\!R3D6F0" | nc -u -w1 $lightwaverf 9760
sleep 2
echo -n "004,\!R3D6F0" | nc -u -w1 $lightwaverf 9760
sleep 2
#Lock Landing
echo -n "004,\!R3D6Fk" | nc -u -w1 $lightwaverf 9760
sleep 2
echo -n "004,\!R3D6Fk" | nc -u -w1 $lightwaverf 9760
path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
$path/logevent.sh "Landing Locked"
