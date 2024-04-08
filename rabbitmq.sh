#!/bin/bash/

ID=$(id -u)

Timestamp=$(date +%F:-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"

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

 curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

 VALIDATE $? "Downloading erlang script"


 curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

 VALIDATE $? "Downloading erlang script"

 dnf install rabbitmq-server -y 
 
 VALIDATE $? "installing rabbitmq sererv"

 systemctl enable rabbitmq-server 
 
 VALIDATE $? "enabling rabbirmq server"

 systemctl start rabbitmq-server 

 VALIDATE $? "strating rabbitmq-server"

 rabbitmqctl add_user roboshop roboshop123

 VALIDATE $? "creating user"

 rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

  VALIDATE $? "setting permissions"