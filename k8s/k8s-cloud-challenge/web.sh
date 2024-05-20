#!/bin/bash

# Install Apache, PHP, and PHP MySQL module
sudo yum install -y httpd php php-mysqlnd

# Allow traffic on port 80 (HTTP)
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload

# Modify Apache configuration to prioritize PHP files
sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

#Set the environment variable for the php app
sudo cp www.conf /etc/php-fpm.d 

# Start and enable Apache service
sudo systemctl start httpd
sudo systemctl enable httpd

# Stop Apache service temporarily
sudo systemctl stop httpd

# Set MySQL connection details as environment variables and add them to .bashrc
#echo 'export DB_HOST="localhost"' >> ~/.bashrc
#echo 'export DB_USER="admin"' >> ~/.bashrc
#echo 'export DB_PASSWORD="admin123"' >> ~/.bashrc
#echo 'export DB_NAME="ecomdb"' >> ~/.bashrc
#echo 'export FEATURE_DARK_MODE="true"' >> ~/.bashrc

# Reload .bashrc to apply the changes
#source ~/.bashrc

# Copy necessary files to Apache's web root directory
sudo cp -r * /var/www/html

# Replace MySQL connection details in index.php file
#sudo sed -i "s/\$link = mysqli_connect(\$dbHost, \$dbUser, \$dbPassword, \$dbName);/\$link = mysqli_connect('$DB_HOST', '$DB_USER', '$DB_PASSWORD', '$DB_NAME');/g" /var/www/html/index.php
#this command above  maintains the single quotes of the variables.

# Start Apache service
sudo systemctl start httpd

# Check Apache service status
sudo systemctl status httpd

