#!/bin/bash

# Remove existing Docker packages
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Install necessary utilities
sudo yum install -y yum-utils

# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker packages
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service (if not started automatically)
sudo systemctl start docker
sudo systemctl enable docker
# Run hello-world container to verify installation
sudo docker run hello-world


sudo chown $USER /var/run/docker.sock
