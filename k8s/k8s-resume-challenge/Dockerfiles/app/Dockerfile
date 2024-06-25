# Stage 1: Build stage using Maven
FROM php:7.4-apache


RUN apt update && sudo apt install php-mysql -y


# Set the working directory inside the container for the build stage
#WORKDIR /build

# Copy the entire content of the current directory into the Docker image
COPY . /var/www/html 

#ENV MYSQL_USER="admin"
#ENV DB_HOST="ecomdb"
#ENV MYSQL_PASSWORD="admin123"
#ENV MYSQL_DATABASE="ecomdb"

sudo sed -i "s/\$link = mysqli_connect(\$dbHost, \$dbUser, \$dbPassword, \$dbName);/\$link = mysqli_connect('$DB_HOST', '$MYSQL_USER', '$MYSQL_PASSWORD', '$MYSQL_DATABASE');/g" /var/www/html/index.php

# Build the Maven project and package it into a WAR file
#RUN mvn clean install

# Stage 2: Deployment stage using Tomcat
#FROM tomcat:9-jre11

# Remove any existing files related to the default ROOT application in Tomcat's webapps directory
#RUN rm -rf /usr/local/tomcat/webapps/ROOT*

# Copy the WAR file from the previous build stage into the Tomcat webapps directory, renaming it to ROOT.war
#COPY --from=build /build/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 to allow external access to the Tomcat server
EXPOSE 80

# Set the default command to run Tomcat using catalina.sh
CMD ["apache2-foreground"]

