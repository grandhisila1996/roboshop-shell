#!/bin/bash

Disk_usage=$(df -kh | grep -vE 'VM|File')
Disk_Threshold=1
message=""

while IFS= read line
do 
usage=$(echo $line | awk '{print $8f}' | cut -d % -f1)
partition=$(echo $line | awk '{print $1f}')

if [ $usage -gt $Disk_Threshold ]
then
    message+="High disk usage alert on $partition: $usage\n"
fi

done -e <<< $Disk_usage