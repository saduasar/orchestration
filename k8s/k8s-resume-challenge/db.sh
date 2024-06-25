#!/bin/bash

DATABASE_PASS='admin123'

# Update package repository
sudo yum update -y

# Install necessary packages
sudo yum install git zip unzip mariadb-server -y

# Starting and enabling mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Cloning the repository
#cd /tmp/
#git clone -b main https://github.com/saduasar/vprofile-project.git

# Restore the dump file for the application
sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
sudo mysql -u root -p"$DATABASE_PASS" -e "create database ecomdb"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on ecomdb.* TO 'admin'@'localhost' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on ecomdb.* TO 'admin'@'%' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" ecomdb < assets/db-load-script.sql
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

# Restart mariadb-server
sudo systemctl restart mariadb

# Enable firewall and allow mariadb access from port 3306
sudo ufw allow 3306/tcp

# Output success message
sudo echo "the userdata worked yaaay" > /etc/motd

