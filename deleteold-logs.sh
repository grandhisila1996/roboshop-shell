#!/bin/bash

Source_Directory="/tmp/old-logs"

if [ ! -d $Source_Directory ]
then 
    echo "Source directory : $Source_Directory is not exist"
else
    echo "Source directory : $Source_Directory is exist"    
fi

find $Source_Directory -type f -mtime +14 -name "*.log"