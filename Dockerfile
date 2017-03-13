FROM        mariadb

#MANTAINER gg13008@ues.edu.sv

#ARREGLAR EL SCRIPT CONSEGUIr UNO BUENO

COPY 	 casosAcademica.sql docker-entrypoint-initdb.d/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]

