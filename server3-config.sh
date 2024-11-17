#! /bin/bash 

# if [ -d "/opt/apache-maven-3.9.9" ]; then 
#     echo "Mvaen is installed"
# else
#     wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
#     sudo tar xf apache-maven-3.9.9-bin.tar.gz -C /opt
# fi 

if [ -d "addressbook" ]; then 
    echo "Repo is present"
    cd /home/ubuntu/addressbook
    git pull origin main
else
    git clone https://github.com/akshay1601/addressbook.git
    cd addressbook
fi

# /opt/apache-maven-3.9.9/bin/mvn  package
cd  /home/ubuntu/addressbook
docker build -t project .
docker run -itd --name moneyuncle -p 8080:8080 project
