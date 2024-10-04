#!/bin/bash

# Define paths
APP_DIR="/usr/share/nginx/html"          # Where your app should be installed
DEPLOY_DIR="/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive"  # Where the bundle is temporarily stored

# Create the application directory if it doesn't exist
if [ ! -d "$APP_DIR" ]; then
    mkdir -p "$APP_DIR"
fi

# Move the downloaded files to the application directory
cp -r $DEPLOY_DIR/* $APP_DIR/

# Set proper permissions
chown -R www-data:www-data $APP_DIR
chmod -R 755 $APP_DIR

# Check if necessary environment variables or files exist
if [ ! -f "$APP_DIR/.env" ]; then
    echo "Environment file not found, creating default one"
    cp $APP_DIR/.env.example $APP_DIR/.env
fi

# Install dependencies (example for Node.js or any other app)
if [ -f "$APP_DIR/package.json" ]; then
    cd $APP_DIR
    npm install
fi

# Restart services if needed (e.g., Nginx or your application service)
# Example: Restarting Nginx
sudo systemctl restart nginx

# Optional: Set up service to start on boot if not already done
sudo systemctl enable nginx

# Start the application, for example, a Node.js server (change as per your app)
# nohup npm start &

# Log success
echo "Installation and setup completed successfully."
