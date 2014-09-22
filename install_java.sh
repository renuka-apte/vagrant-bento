#!/usr/bin/env bash

sudo apt-get install python-software-properties -y

sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update

# Accept License
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install oracle-java7-installer -y

