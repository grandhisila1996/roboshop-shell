#!/bin/bash

Source_Directory="/tmp/old-logs"

if [ ! -d $Source_Directory ]
then 
    echo "Source directory : $Source_Directory is not exist"
    exit 1
else
    echo "Source directory : $Source_Directory is exist"    
fi

OLD-LOGS=$(find $Source_Directory -type f -mtime +14 -name "*.log")

VALIDATE () {
    if [ $? -ne 0 ]
    then
       echo "*.log fiels not exist in $Source_Directory"
       exit 1
    else
       echo "$OLD-LOGS"
    fi
}