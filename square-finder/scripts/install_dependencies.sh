#!/bin/bash

# Update package list
sudo apt update

# Check if Nginx is installed
if dpkg -l | grep -q nginx; then
    echo "Nginx is already installed."
else
    # Install Nginx
    sudo apt install -y nginx

    # Start Nginx service
    sudo systemctl start nginx

    # Enable Nginx to start on boot
    sudo systemctl enable nginx
fi

# Print Nginx status
sudo systemctl status nginx

# Install AWS CodeDeploy Agent
if dpkg -l | grep -q codedeploy-agent; then
    echo "AWS CodeDeploy Agent is already installed."
else
    # Install dependencies
    sudo apt install -y ruby wget

    # Download the CodeDeploy agent package
    cd /tmp
    wget https://aws-codedeploy-ap-south-1.s3.amazonaws.com/latest/install

    # Make the install script executable
    chmod +x ./install

    # Run the install script
    sudo ./install auto

    # Start the CodeDeploy agent service
    sudo systemctl start codedeploy-agent

    # Enable the CodeDeploy agent to start on boot
    sudo systemctl enable codedeploy-agent
fi

# Print CodeDeploy agent status
sudo systemctl status codedeploy-agent