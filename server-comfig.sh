#! /bin/bash 
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xf apache-maven-3.9.9-bin.tar.gz -C /opt


cd /home/ubuntu
git clone https://github.com/akshay1601/addressbook.git
cd /home/ubuntu/addressbook
/opt/apache-maven-3.9.9/bin/mvn  package