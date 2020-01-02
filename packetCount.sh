#!/bin/sh
# Author: Burak Karaduman <burakkaradumann@gmail.com>
# Usage: sh countPackets.sh <capture time as seconds> <ip address>
# Example: sh countPackets.sh 60 10.10.10.10

# Define your arguments
capture_time=$1
IP=$2

if [[ -z $1 || -z $2 ]];then
        echo -e "\nYou should give arguments as 'sh countPackets.sh <capture time as seconds> <ip address>'\n"
        exit
fi

echo -e "\nLoading..."

# Run tcpdump
tcpdump -ni any src $IP >> /dev/null 2> result &

# Catch tcpdump process id
processID=$!

# Sleep time
sleep $capture_time

# Kill your tcpdump process
kill $processID

# Trash the result
result=$(cat result | tail -2 | head -1 | cut -d " " -f 1)

echo -e "\nSource: $IP"
echo -e "Listening time: $capture_time seconds"
echo -e "Packet count: $result\n"

# Delete junk result file
rm -f result
