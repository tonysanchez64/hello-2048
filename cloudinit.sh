#!/bin/sh
sudo yum update -y
sudo yum install docker docker-compose-plugin -y
sudo service docker start
sudo usermod -a -G docker ec2-user
wget https://raw.githubusercontent.com//main/docker-compose.yml
docker-compose pull

