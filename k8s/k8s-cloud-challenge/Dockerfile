#Base image
FROM php:7.4-apache

# Install and enable mysqli extension
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy the application files into the container
COPY . /var/www/html

# Expose port 80 to allow external access to the Apache server
EXPOSE 80

# Set the default command to run Apache server using apache2-foreground
CMD ["apache2-foreground"]

