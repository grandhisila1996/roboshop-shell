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

 dnf install maven -y 


 VALIDATE $? "installing maven"

 id roboshop 

if [ $? -ne 0 ]
then 
    useradd roboshop 
    VALIDATE $? "roboshop user creation"
else
    echo "roboshop user already exist $Y skipping $N"
fi

mkdir -p /app

VALIDATE $? "creating app directory"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip

cd /app

unzip -o /tmp/shipping.zip

mvn clean package

mv target/shipping-1.0.jar shipping.jar

systemctl daemon-reload

systemctl enable shipping 

dnf install mysql -y

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql 

systemctl restart shipping

VALIDATE $? "restart shipping"

