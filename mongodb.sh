#!/bin/bash/

ID=$(id -u)

Timestamp=$(date +%F-%H-%M-$S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"

echo "script started executing at $TIMESTAMP" & >> $LOGFILE

VALIDATE () {
    if [ $? -ne 0 ]
    then
       echo "$2 is failed"
    else
       echo "$2 is success"
    fi
}
if [ $ID -ne 0 ]

then 
   echo "Error : Please run this script with root user"
else 
   echo "you are root user"
 fi 

 cp mongo repo /etc/yum.repos/ & >> $LOGFILE

 VALIDATE $? "copied mongodb Repo"