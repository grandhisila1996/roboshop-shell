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

dnf install nginx -y

VALIDATE $? "installing nginx"

systemctl enable nginx

VALIDATE $? "enabling nginx"

systemctl start nginx

VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/*

VALIDATE $? "removing default nginx content"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip

VALIDATE $? "downloading own nginx content"

cd /usr/share/nginx/html

unzip -o /tmp/web.zip

VALIDATE $? "unzipping nginx"

cp /home/contos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx

VALIDATE $? "restarting nginx"