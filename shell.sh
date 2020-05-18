#!/bin/bash
sudo apt-get update; sudo apt-get -y upgrade
sudo apt-get install -y default-jdk
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update; sudo apt-get -y upgrade
sudo apt-get -y install docker docker.io
[ $? -eq 0 ] && echo " Docker installed successfully" || echo " Docker installation failed."
docker login
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.0
[ $? -eq 0 ] && echo " Elastic Search container deployed " || echo " Elastic Search deployment failed."
