#!/bin/bash
sudo su
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
mkdir /var/www/html/products
echo "From Products page $(hostname -f)" > /var/www/html/products/index.html