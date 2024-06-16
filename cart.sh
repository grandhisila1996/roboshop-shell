#!/bin/bash/

ID=$(id -u)

Timestamp=$(date +%F:-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"
exec &> $LOGFILE

$Mongo_host=34.23.54.134
echo "script started executing at $Timestamp" & >> $LOGFILE

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

curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip >> $LOGFILE

VALIDATE $? "downloading cart application" 

cd /app

unzip -o /tmp/cart.zip >> $LOGFILE

VALIDATE $? "unzipping cart" 

npm install >> $LOGFILE

VALIDATE $? "installing npm" 

cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service >> $LOGFILE

VALIDATE $? "copying catcartlogue.service file" 

systemctl daemon-reload >> $LOGFILE

VALIDATE $? "daemon reload" 

systemctl enable cart >> $LOGFILE

VALIDATE $? "enabling cart" 

systemctl start cart >> $LOGFILE

VALIDATE $? "starting cart" 

cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo >> $LOGFILE

VALIDATE $? "copying mongo.repo" 

dnf install mongodb-org-shell -y >> $LOGFILE

VALIDATE $? "installing mongodb client" 

mongo --host $Mongo_host </app/schema/cart.js >> $LOGFILE

VALIDATE $? "loading cart data into mongodb server" 