#!/bin/bash
sudo su
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "From Home page $(hostname -f)" > /var/www/html/index.html