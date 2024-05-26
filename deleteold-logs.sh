#!/bin/bash

Process=$("ps -ef | grep logs.sh | head -n 1")

PID=$("echo "$Process" | awk '{print $2f}'")

echo "Deletelogs.sh started-$PID" : `date "+%d%m%Y%H%M%S"`

Source_Directory="/tmp/old-logs"


if [ ! -d $Source_Directory ]
then 
    echo "Source directory : $Source_Directory is not exist"
    exit 1
else
    echo "Source directory : $Source_Directory is exist"    
fi

OLD_LOGS=$(find "${Source_Directory}" -type f -mtime +14 -name "*.log")


for LOGS in $OLD_LOGS
do 

echo “Deleting file : $LOGS”
rm -rf $LOGS

done

echo "Deletelogs.sh completed-$PID" : `date "+%d%m%Y%H%M%S"`
