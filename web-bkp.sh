#!/bin/bash

ID=$(id -u)

MONGODB_HOST=

TIMESTAMP=$(date +F:-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "scirpt started at $TIMESTAMP" &>> $LOGFILE

VALIDATE () {
    if [ $1 -ne 0 ]
    then
       echo -e "$2 ... FAILED"
    else
       echo -e "$2 ... SUCCESS"
    fi
    
}

if [ $ID -ne 0 ]
then
    echo -e "Please run this script with root access"
else
    echo -e "you are root user"
fi

dnf install nginx -y &>> $LOGFILE

VALIDATE $? "installing nginx"

systemctl enable nginx &>> $LOGFILE

VALIDATE $? "enabling nginx"

systemctl start nginx &>> $LOGFILE

VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/* &>> $LOGFILE

VALIDATE $? "removing default website"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE

VALIDATE $? "Downloading web app"

cd /usr/share/nginx/html &>> $LOGFILE

VALIDATE $? "moving to nginx html directory"

unzip -o /tmp/web.zip &>> $LOGFILE

VALIDATE $? "unzipping web"

cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE

VALIDATE $? "copied roboshop reverse proxy config"

systemctl restart nginx &>> $LOGFILE

VALIDATE $? "restarting nginx"