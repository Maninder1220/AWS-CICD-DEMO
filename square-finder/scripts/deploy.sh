#!/bin/bash

# Install Nginx if it's not installed on ubuntu 
if ! [ -x "$(command -v nginx)" ]; then
  echo "Nginx is not installed. Installing..."
  sudo apt update -y
  sudo apt install -y nginx
fi

# Install Docker if it's not installed on ubuntu
if ! [ -x "$(command -v docker)" ]; then
  echo "Docker is not installed. Installing..."
  sudo apt update -y
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update -y
  sudo apt install -y docker-ce
fi


# enable and Start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Enable and Start Docker
sudo systemctl enable docker
sudo systemctl start docker
