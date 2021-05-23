FROM centos
MAINTAINER "yaser.eidiko@gmail.com"
RUN yum istall wget -y
RUN yum install java -y
RUN yum install unzip -y
RUN mkdir /TOMCAT
WORKDIR /TOMCAT
COPY
