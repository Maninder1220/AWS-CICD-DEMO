#!/bin/bash

# Function to stop a service using systemctl
stop_systemctl_service() {
    service_name=$1
    if systemctl is-active --quiet $service_name; then
        echo "Stopping $service_name using systemctl..."
        sudo systemctl stop $service_name
        echo "$service_name stopped."
    else
        echo "$service_name is not running or managed by systemctl."
    fi
}

# Function to stop a service using service
stop_service() {
    service_name=$1
    if sudo service $service_name status > /dev/null 2>&1; then
        echo "Stopping $service_name using service..."
        sudo service $service_name stop
        echo "$service_name stopped."
    else
        echo "$service_name is not running or managed by service."
    fi
}

# Stop CodeDeploy agent using service command
stop_service codedeploy-agent

# Stop Nginx using systemctl
stop_systemctl_service nginx
