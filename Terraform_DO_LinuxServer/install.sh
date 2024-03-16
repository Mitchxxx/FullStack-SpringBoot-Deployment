#!/bin/bash

#Install Java
sudo apt upgrade -y
sudo apt update -y
sudo apt install openjdk-17-jdk openjdk-17-jre -y
java  --version

#Install Maven
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update -y
sudo apt-get install maven -y
mvn -version

# install nodejs
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y
node -v

# install npm
sudo apt update
sudo apt install npm -y
npm -v


# Install Nginx

sudo apt install nginx -y