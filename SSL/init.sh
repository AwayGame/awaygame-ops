#!/bin/bash
# This script installs SSL via Let's Encrypt, as well as installs
# dependencies for NGINX. Make sure you change "YOURDOMAIN" to the one
# that you are going to use

yum install epel-release -y
yum install certbot-nginx -y
yum install nginx -y

firewall-cmd --add-service=http
firewall-cmd --add-service=https
firewall-cmd --runtime-to-permanent
firewall-cmd --reload

certbot --nginx -d <YOURDOMAIN>

yum install policycoreutils-python -y
sudo cat /var/log/audit/audit.log | grep nginx | grep denied | audit2allow -M mynginx
sudo semodule -i mynginx.pp
systemctl start nginx
