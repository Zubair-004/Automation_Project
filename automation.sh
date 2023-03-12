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

sudo systemctl status apache2 > output.txt
if grep -q "running" output.txt; then    
echo "The Apache2 service is enabled"
else
sudo systemctl start apache2
sudo systemctl enable apache2 
echo "The Apache2 service was stopped, errored, or inactive. The service has been started."
fi

timestamp=$(date '+%d%m%Y-%H%M%S')

cd /var/log/apache2

sudo tar -cvf "MohdZubair-httpd-logs-${timestamp}.tar" access.log error.log
 
src_dir="/var/log/apache2"
dest_dir="/tmp"

sudo mv "${src_dir}"/*.tar "${dest_dir}"

archive_file="/tmp/MohdZubair-httpd-logs-${timestamp}.tar"

s3_bucket="s3://upgrad-mohdzubair"

aws s3 cp $archive_file $s3_bucket

if [ ! -f /var/www/html/inventory.html ]; then
 sudo echo -e "Log Type\tTime Created\tType\tSize" > "/var/www/html/inventory.html"
fi

sudo echo -e "httpd-logs\t$(date +%m%d%Y-%H%M%S)\ttar\t$(du -sh $archive_file| cut -f1)" >> "/var/www/html/inventory.html"

