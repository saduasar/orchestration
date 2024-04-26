#!/bin/bash

# Function to log messages with timestamps
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $@"
}

# Function to check if a command executed successfully
check_command() {
    if [ $? -eq 0 ]; then
        log "Command succeeded: $1"
    else
        log "Command failed: $1"
        exit 1
    fi
}

# Install Apache, PHP, and PHP MySQL module
log "Installing Apache, PHP, and PHP MySQL module..."
sudo yum install -y httpd php php-mysqlnd
check_command "Install Apache, PHP, and PHP MySQL module"

# Allow traffic on port 80 (HTTP)
log "Allowing traffic on port 80 (HTTP)..."
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload
check_command "Allow traffic on port 80 (HTTP)"

# Modify Apache configuration to prioritize PHP files
log "Modifying Apache configuration to prioritize PHP files..."
sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf
check_command "Modify Apache configuration"

# Start and enable Apache service
log "Starting and enabling Apache service..."
sudo systemctl start httpd
sudo systemctl enable httpd
check_command "Start and enable Apache service"

# Stop Apache service temporarily
log "Stopping Apache service temporarily..."
sudo systemctl stop httpd
check_command "Stop Apache service temporarily"

# Set MySQL connection details as environment variables and add them to .bashrc
log "Setting MySQL connection details as environment variables..."
echo 'export DB_HOST="localhost"' >> ~/.bashrc
echo 'export DB_USER="admin"' >> ~/.bashrc
echo 'export DB_PASSWORD="admin123"' >> ~/.bashrc
echo 'export DB_NAME="ecomdb"' >> ~/.bashrc
source ~/.bashrc
check_command "Set MySQL connection details as environment variables"

# Copy necessary files to Apache's web root directory
log "Copying necessary files to Apache's web root directory..."
sudo cp -r * /var/www/html
check_command "Copy necessary files to Apache's web root directory"

# Replace MySQL connection details in index.php file
log "Replacing MySQL connection details in index.php file..."
sudo sed -i "s/\$link = mysqli_connect(\$dbHost, \$dbUser, \$dbPassword, \$dbName);/\$link = mysqli_connect('$DB_HOST', '$DB_USER', '$DB_PASSWORD', '$DB_NAME');/g" /var/www/html/index.php
check_command "Replace MySQL connection details in index.php file"

# Start Apache service
log "Starting Apache service..."
sudo systemctl start httpd
check_command "Start Apache service"

# Check Apache service status
log "Checking Apache service status..."
sudo systemctl status httpd
check_command "Check Apache service status"

log "Script execution completed successfully!"

