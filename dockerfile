 
FROM        java:8-jdk

MAINTAINER gg13008@ues.edu.sv

#variables de entorno
ENV      JAVA_HOME         /usr/lib/jvm/java-8-openjdk-amd64
ENV 	 GLASSFISH_HOME=/opt/glassfish4
ENV 	 PATH=$PATH:/opt/glassfish4/bin
ENV  	 PASSWORD=glassfish

## NOMBRE POOL Y NOMBRE JDBC RESOURCE
ENV POOL=academicaTPI2017
ENV RESOURCE=academicaRes2017


# actualizando sistema

RUN         apt-get update && \
            apt-get install -y wget unzip zip inotify-tools && \
            rm -rf /var/lib/apt/lists/*

# Installando glassfish

RUN     cd /opt/ && \
	wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
	 unzip glassfish-4.1.zip && \
        rm glassfish-4.1.zip &&\ 
    echo "--- Setup the password file ---" && \
    echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd && \
    echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}" >> /tmp/glassfishpwd  && \
    echo "--- Enable DAS, change admin password, and secure admin access ---" && \
    glassfish4/bin/asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1 && \
    glassfish4/bin/asadmin start-domain && \
    echo "AS_ADMIN_PASSWORD=${PASSWORD}" > /tmp/glassfishpwd && \
    glassfish4/bin/asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin && \
    glassfish4/bin/asadmin --user=admin stop-domain && rm /tmp/glassfishpwd
 
#Haciendo el pool de conexiones y el jdbc resources con asadmin [magic lines] 

COPY mariadb-java-client-1.5.8.jar /opt/glassfish4/glassfish/lib
## COPY (archivoToDeploy.war o .ear) / 

 
RUN   /opt/glassfish4/bin/asadmin start-domain && \
      touch /gfpass && echo AS_ADMIN_PASSWORD=glassfish > /gfpass && \
      /opt/glassfish4/bin/asadmin  --user admin --passwordfile /gfpass create-jdbc-connection-pool --restype javax.sql.DataSource --driverclassname MySql --datasourceclassname org.mariadb.jdbc.MySQLDataSource --steadypoolsize 2 --maxpoolsize 4 --poolresize 1  --ping=true --description miPooltpi2017 --isisolationguaranteed=true --property user=root:password=1234:DatabaseName=acadTPI1:port=3306:serverName=172.17.0.2:url=localhost ${POOL} && \ 
     /opt/glassfish4/bin/asadmin  --user admin --passwordfile /gfpass create-jdbc-resource --connectionpoolid ${POOL} ${RESOURCE}  && \

# iniciando el deploy
##   /opt/glassfish4/bin/asadmin  --user admin --passwordfile /gfpass deploy (archivoToDeploy.war o .ear) && \
     rm /gfpass  

EXPOSE      8080 4848 8181

WORKDIR    /opt/glassfish4/bin/

# Este sera el punto de entrada
CMD         /opt/glassfish4/bin/asadmin start-domain --verbose

