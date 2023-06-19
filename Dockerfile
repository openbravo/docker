############################################################
# Dockerfile to build openbaravo container images
# Based on ubuntu:22.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y wget vim net-tools ant ant-optional postgresql-14 openjdk-11-jdk-headless
ADD openbravo-3.0PR23Q2.tar.gz /opt
ADD apache-tomcat-8.5.88.tar.gz /opt
ADD entrypoint.sh /entrypoint.sh
RUN chown root:root /entrypoint.sh && chmod +x /entrypoint.sh
RUN useradd --user-group --create-home --base-dir /opt/openbravo --shell /bin/bash openbravo
RUN mv /opt/openbravo-* /opt/openbravo &&\
    mv /opt/apache-tomcat-* /opt/tomcat &&\
    chown -R openbravo:openbravo /opt/openbravo /opt/tomcat
RUN rm -rf /var/lib/apt/lists/*
RUN echo "export CATALINA_OPTS='-server -Djava.awt.headless=true -Xms384M -Xmx1024M'\n\
export CATALINA_HOME=/opt/tomcat\n\
export CATALINA_BASE=/opt/tomcat\n\
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /etc/profile.d/base-variables.sh
ENTRYPOINT ["/entrypoint.sh"]
