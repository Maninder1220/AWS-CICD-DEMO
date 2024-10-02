#!/bin/bash

# Check if Nginx is installed
if ! command -v nginx &> /dev/null
then
    echo "Nginx is not installed. Please install Nginx first."
    exit 1
fi

# Start Nginx server
if sudo systemctl start nginx || sudo service nginx start
then
    echo "Nginx server started successfully."
else
    echo "Failed to start Nginx server."
    exit 1
fi

# Check if code deploy is installed
if ! command -v codedeploy-agent &> /dev/null
then
    echo "AWS CodeDeploy Agent is not installed. Please install CodeDeploy agent first."
    exit 1
fi

# Start CodeDeploy agent
if sudo systemctl start codedeploy-agent || sudo service codedeploy-agent start
then
    echo "CodeDeploy agent started successfully."
else
    echo "Failed to start CodeDeploy agent."
    exit 1
fi