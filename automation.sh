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
