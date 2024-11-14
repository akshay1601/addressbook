#! /bin/bash 
sudo apt-get install maven -y
cd /home/ubuntu
git clone https://github.com/akshay1601/addressbook.git
cd addressbook
mvn package