#!/bin/bash

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


