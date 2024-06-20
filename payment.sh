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

 mkdir -p /app

 VALIDATE $? "creating app directory"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip

 VALIDATE $? "Downloading payment application"

cd /app

unzip /tmp/payment.zip

VALIDATE $? "unzipping payment"

pip3.6 install -r requirements.txt

VALIDATE $? "installing requirements"

cp /home/coentosroboshop-shell/payment.service  /etc/systemd/system/payment.service

VALIDATE $? "copying payment repo"

systemctl daemon-reload

VALIDATE $? "deamon reloading"

systemctl enable payment 

VALIDATE $? "enabling payment"

systemctl start payment

VALIDATE $? "starting payment"