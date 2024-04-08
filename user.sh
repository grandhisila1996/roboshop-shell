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

dnf module disable nodejs -y >> $LOGFILE

VALIDATE $? "Disabling current Nodejs" 

dnf moduel enable nodejs:18 -y >> $LOGFILE

VALIDATE $? "installing Nodejs:18" 

id roboshop 

if [ $? -ne 0 ]
then 
    useradd roboshop 
    VALIDATE $? "roboshop user creation"
else
    echo "roboshop user already exist $Y skipping $N"
fi
 
mkdir -p /app >> $LOGFILE

VALIDATE $? "creating app directory" 

curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip >> $LOGFILE

VALIDATE $? "downloading user application" 

cd /app

unzip -o /tmp/user.zip >> $LOGFILE

VALIDATE $? "unzipping user" 

npm install >> $LOGFILE

VALIDATE $? "installing npm" 

cp /home/centos/roboshop-shell/user.service /etc/systemd/system/catalogue.service >> $LOGFILE

VALIDATE $? "copying catalogue.service file" 

systemctl daemon-reload >> $LOGFILE

VALIDATE $? "daemon reload" 

systemctl enable user >> $LOGFILE

VALIDATE $? "enabling user" 

systemctl start userr >> $LOGFILE

VALIDATE $? "starting user" 

cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo >> $LOGFILE

VALIDATE $? "copying mongo.repo" 

dnf install mongodb-org-shell -y >> $LOGFILE

VALIDATE $? "installing mongodb client" 

mongo --host $Mongo_host </app/schema/user.js >> $LOGFILE

VALIDATE $? "loading user data into mongodb server" 
