#!/bin/sh
amazon-linux-extras install -y docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user
pip3 install docker-compose
wget https://raw.githubusercontent.com/tonysanchez64/hello-2048/main/docker-compose.yml
docker-compose pull
docker-compose up -d 
