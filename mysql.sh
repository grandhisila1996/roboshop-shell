#!/bin/bash/

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

 dnf module disable mysql -y

 VALIDATE $? "Disabling mysql current version"

 cp mysql.repo /etc/yum.reppos.d/mysql.repo

 VALIDATE $? "copying mysql repo" 

 dnf install mysql-community-server -y

 VALIDATE $? "installing mysql"

 systemctl enable mysqld

 VALIDATE $? "enabling mysql"

 systemctl start mysqld

 VALIDATE $? "starting mysql"

 mysql_secure_installation --set-root-pass RoboShop@1

 VALIDATE $? "setting mysql root password"

