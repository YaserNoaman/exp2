FROM centos
MAINTAINER "yaser.eidiko@gmail.com"
RUN yum istall wget -y
RUN yum install java -y
RUN yum install unzip -y
RUN mkdir /TOMCAT
WORKDIR /TOMCAT
COPY apache-tomcat-9.0.35.zip .
RUN unzip apache-tomcat-9.0.35.zip
RUN groupadd  apache
RUN useradd -g apache tomcat
RUN chmod -R 755  /TOMCAT/apache-tomcat-9.0.35/bin
RUN chown -R apache:tomcat /TOMCAT
EXPOSE 8080
COPY exp2/CLASSCODE/FILE/target/addressbook.war /TOMCAT/apache-tomcat-9.0.35/webapps/
CMD ["/TOMCAT/apache-tomcat-9.0.35/bin/catalina.sh" "run"]
