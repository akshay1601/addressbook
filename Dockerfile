# FROM tomcat:8.5.72-jdk17-openjdk-buster
# ENV MAVEN_HOME=/usr/share/maven
# ENV MAVEN_VERSION=3.9.9

# RUN apt-get update -y
# RUN curl  https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz | tar xzf - -C /usr/share

# RUN mv /usr/share/apache-maven-3.9.9 /usr/share/maven
# RUN  ln -s /usr/share/maven/bin/mvn  /usr/bin/mvn
# RUN  apt-get clean
# RUN  rm -rf /var/lib/apt/lists/*

# WORKDIR /app

# COPY ./src  ./src
# COPY ./pom.xml ./pom.xml

# RUN /usr/bin/mvn package

# RUN cp /app/target/addressbook.war  /usr/local/tomcat/webapps/
# EXPOSE 8080
# CMD ["catalina.sh","run"]

FROM hackyo/maven:3.9-jdk-17  AS build-stage
WORKDIR /app
# RUN mvn dependency:go-offline
COPY ./src  ./src
COPY ./pom.xml ./pom.xml
RUN mvn package

FROM maven:3.8.4-openjdk-17-slim
COPY --from=build-stage  /app/target/*.war  /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]
