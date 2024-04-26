# Use the mysql:8.0.33 image as the base image and name the build stage 'build'
FROM mysql:8.0.33 AS build

# Set environment variables for MySQL user, password, and database name
ENV MYSQL_ROOT_PASSWORD="admin123"
ENV MYSQL_DATABASE="ecomdb"

# Copy the db-load-script.sql file from the local project directory to the /docker-entrypoint-initdb.d/ directory inside the container
COPY ${PWD}/db-load-script.sql docker-entrypoint-initdb.d/db-load-script.sql

# Expose port 3306 to allow external connections to the MySQL server
EXPOSE 3306
