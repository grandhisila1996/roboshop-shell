#!/bin/bash

ID=$(id -u)

Timestamp=$(date +%F:-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"
exec &> $LOGFILE

$Mongo_host=34.23.54.134
echo "script started executing at $TIMESTAMP" & >> $LOGFILE

VALIDATE () {
    if [ $? -ne 0 ]
    then
       echo "$2 is failed"
       exit 1
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

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

VALIDATE $? "installing remi release" 

dnf module enable redis:remi-6.2 -y

VALIDATE $? "enabling redis" 

dnf install redis -y

VALIDATE $? "installing redis" 
 
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf

VALIDATE $? "allowing remote connections"

systemctl enable redis

VALIDATE $? "enabling redis"

systemctl strat redis

VALIDATE $? "starting redis" 



