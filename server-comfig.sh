#! /bin/bash 
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xf apache-maven-3.9.9-bin.tar.gz -C /opt
sudo echo "export JAVA_HOME=/usr/lib/jvm/default-java 
export M3_HOME=/opt/apache-maven-3.9.9 
export MAVEN_HOME=/opt/apache-maven-3.9.9
export PATH=${M3_HOME}/bin:${PATH}" > /etc/profile.d/maven.sh
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

cd /home/ubuntu
git clone https://github.com/akshay1601/addressbook.git
cd addressbook
mvn package