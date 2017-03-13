#!/bin/bash
# -*- ENCODING: UTF-8 -*-

docker rm academicaTPI2017
docker rmi mariadb_tpi2017
docker build -t mariadb_tpi2017 .
docker run --name academicaTPI2017 -p 3306:3006 -e MYSQL_ROOT_PASSWORD=1234 -d mariadb_tpi2017


