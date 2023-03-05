#! /bin/bash

sudo apt update -y

dpkg -s apache2 &> /dev/null  

    if [ $? -ne 0 ]

        then
            echo "Apache2 is not installed"  
            sudo apt-get update
            sudo apt-get install apache2

        else
            echo    "Apache2 is installed"
    fi

if ! pidof apache2 > /dev/null
then
    echo  "Apache web server is down,trying to restart"
    sudo /etc/init.d/apache2 restart > /dev/null
    sleep 10
    sudo service apache2 start
else
    echo "Apache2 web server is running"
fi
