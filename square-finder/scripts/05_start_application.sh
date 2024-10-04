#!/bin/bash

# Function to start a service using systemctl
start_systemctl_service() {
    service_name=$1
    if ! systemctl is-active --quiet $service_name; then
        echo "Starting $service_name using systemctl..."
        sudo systemctl start $service_name
        echo "$service_name started."
    else
        echo "$service_name is already running."
    fi
}

# Function to start a service using service
start_service() {
    service_name=$1
    if ! sudo service $service_name status > /dev/null 2>&1; then
        echo "Starting $service_name using service..."
        sudo service $service_name start
        echo "$service_name started."
    else
        echo "$service_name is already running."
    fi
}

# Start CodeDeploy agent using service command
start_service codedeploy-agent

# Start Nginx using systemctl
start_systemctl_service nginx
