#!/bin/bash

# Define application directory
APP_DIR="/usr/share/nginx/html"  # Update this to your application's installation directory

# Define the user and group under which your application should run (e.g., www-data for Nginx)
APP_USER="www-data"
APP_GROUP="www-data"

# Set permissions for the application directory and files
echo "Setting permissions for $APP_DIR"

# Set ownership recursively
chown -R $APP_USER:$APP_GROUP $APP_DIR

# Set directory permissions (755) for directories
find $APP_DIR -type d -exec chmod 755 {} \;

# Set file permissions (644) for files
find $APP_DIR -type f -exec chmod 644 {} \;

# Optionally: Clean up temporary files (if necessary)
echo "Cleaning up temporary files..."
TEMP_DIR="/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive/tmp"  # Example path
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
    echo "Temporary files cleaned up."
else
    echo "No temporary files found to clean."
fi

# Log completion
echo "Permissions configured successfully."
