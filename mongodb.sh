#!/bin/bash/

ID=$(id -u)

Timestamp=$(date +%F:-%H-%M-%S)
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

 cp mongo.repo /etc/yum.repos.d/mongo.repo & >> $LOGFILE

 VALIDATE $? "copied mongodb Repo"

 dnf install mongodb-org -y & >> $LOGFILE

 VALIDATE $? "installing mongodb"

 systemctl enable mongodb & >> $LOGFILE

 VALIDATE $? "enabling mongodb"

 systemctl start mongodb & >> $LOGFILE

 VALIDATE $? "starting mongodb"

 sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf & >> $LOGFILE

  VALIDATE $? "Remote access to Mongodb"

  systemctl restart mogod & >> $LOGFILE

  VALIDATE $? "Restarting Mongod"