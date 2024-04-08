#!/bin/bash

Source_DIrectory=/tmp/old-logs

if [ ! -d $Source_DIrectory]
then 
    echo "Source directory : $Source_Directory is not exist"
else
    echo "Source directory : $Source_Directory is exist"    

fi

Files_To_Delete=$(find $Source_Directory -type f -mtime +14 -name "*.log")

