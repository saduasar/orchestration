#Base image
FROM php:7.4-apache

# Install and enable mysqli extension
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy the application files into the container
COPY . /var/www/html

# we need to set these environments in the image to allow these variables to be printed when the sed command runs in the image.
#if you set these variables in the container instead of the images, the variables wont get printed because, the index.php would have already be copied to var/www/html and wouldnt have these variables by that time to be printed.
# Set environment variables required for database connection
ENV MYSQL_USER=admin \
    DB_HOST=ecomdb \
    MYSQL_PASSWORD=admin123 \
    MYSQL_DATABASE=ecomdb

# Modify the index.php file to use environment variables for database connection
RUN sed -i "s/\$link = mysqli_connect(\$dbHost, \$dbUser, \$dbPassword, \$dbName);/\$link = mysqli_connect('$DB_HOST', '$MYSQL_USER', '$MYSQL_PASSWORD', '$MYSQL_DATABASE');/g" /var/www/html/index.php

# Expose port 80 to allow external access to the Apache server
EXPOSE 80

# Set the default command to run Apache server using apache2-foreground
CMD ["apache2-foreground"]

