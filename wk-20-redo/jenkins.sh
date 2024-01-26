#!/bin/bash
sudo apt-get update && sudo apt upgrade -y
sudo apt-get install openjdk-17-jre -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key 
sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install fontconfig openjdk-17-jre
sudo apt-get install jenkins -y 
sudo apt-get systemctl start jenkins
sudo apt-get systemctl enable jenkins