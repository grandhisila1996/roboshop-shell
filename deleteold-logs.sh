#!/bin/bash

Source_Directory="/tmp/old-logs"

if [ ! -d $Source_Directory ]
then 
    echo "Source directory : $Source_Directory is not exist"
    exit 1
else
    echo "Source directory : $Source_Directory is exist"    
fi

OLD-LOGS=`$(find $Source_Directory -type f -mtime +14 -name "*.log")`
echo "$OLD-LOGS"
while IFS= read -r line
do 
  echo "Deleting file : $line"
  rm -rf $line
done <<< $OLD-LOGS

