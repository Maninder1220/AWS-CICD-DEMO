#!/bin/bash

# Define the application's URL
APP_URL="http://localhost"  # Change this to your application's URL
APP_PORT="80"                # Change this if your app runs on a different port

# Function to check if Nginx is running
check_nginx() {
    if systemctl is-active --quiet nginx; then
        echo "Nginx is running."
        return 0
    else
        echo "Nginx is not running."
        return 1
    fi
}

# Function to check if the application is responding
check_application() {
    response=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL:$APP_PORT")
    if [ "$response" -eq 200 ]; then
        echo "Application is up and running (HTTP $response)."
        return 0
    else
        echo "Application is not reachable (HTTP $response)."
        return 1
    fi
}

# Validate Nginx and the application
echo "Validating Nginx service..."
if check_nginx && check_application; then
    echo "Validation successful."
else
    echo "Validation failed."
    exit 1  # Exit with an error code
fi
