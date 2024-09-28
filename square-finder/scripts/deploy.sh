#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Install Nginx if it's not installed on Ubuntu
if ! [ -x "$(command -v nginx)" ]; then
  echo "Nginx is not installed. Installing..."
  sudo apt update -y
  sudo apt install -y nginx
else
  echo "Nginx is already installed."
fi

# Enable and Start Nginx
if ! systemctl is-active --quiet nginx; then
  echo "Enabling and starting Nginx..."
  sudo systemctl enable nginx
  sudo systemctl start nginx
else
  echo "Nginx is already running."
fi

# Check Nginx status
if systemctl status nginx | grep -q "active (running)"; then
  echo "Nginx is running successfully."
else
  echo "Nginx failed to start. Please check the logs."
fi

# Install CodeDeploy if it's not installed on Ubuntu
if ! [ -x "$(command -v codedeploy-agent)" ]; then
  echo "CodeDeploy agent is not installed. Installing..."
  sudo apt update -y
  sudo apt install -y ruby
  cd /home/ubuntu
  wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
  chmod +x ./install
  sudo ./install auto
else
  echo "CodeDeploy agent is already installed."
fi

# Start CodeDeploy agent if it's not running
if ! systemctl is-active --quiet codedeploy-agent; then
  echo "Starting CodeDeploy agent..."
  sudo systemctl start codedeploy-agent
fi

# Check CodeDeploy status
if systemctl status codedeploy-agent | grep -q "active (running)"; then
  echo "CodeDeploy agent is running successfully."
else
  echo "CodeDeploy agent failed to start. Please check the logs."
fi
