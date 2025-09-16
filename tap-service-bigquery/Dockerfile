FROM tomcat:9-jdk11-openjdk
LABEL maintainer="dspeck@burwood.com"

# Add Local Authority file for Authentication
ADD src/main/resources/LocalAuthority.properties /root/config/LocalAuthority.properties

# Add WAR and XML Files
ADD build/libs/tap-service-bigquery-1.1.war /usr/local/tomcat/webapps/tap.war
#ADD tap-service-bigquery-1.1.war /usr/local/tomcat/webapps/tap.war
ADD tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
ADD server.xml /usr/local/tomcat/conf/server.xml
ADD setenv.sh /usr/local/tomcat/bin/setenv.sh

# Create directory for saved data
RUN mkdir -p /usr/local/tomcat/webapps/resultStoreImpl/

# Add Simba driver.  Change version as appopriate.
RUN  \
    wget https://storage.googleapis.com/simba-bq-release/jdbc/SimbaJDBCDriverforGoogleBigQuery42_1.6.3.1004.zip -O /tmp/SimbaJDBCDriverforGoogleBigQuery.zip && \
    unzip /tmp/SimbaJDBCDriverforGoogleBigQuery.zip -d /tmp/simba && \
    mv /tmp/simba/*.jar /usr/local/tomcat/lib/ && \
    rm -rf /tmp/*

EXPOSE 8080
CMD ["catalina.sh", "run"]
