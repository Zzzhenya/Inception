#base image
FROM debian:bullseye

#testing
RUN echo "Mariadb"

#download updated package information and upgrade
RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf 

RUN mkdir -p /var/lib/mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY tools/setup_mariadb.sh /temp/setup_mariadb.sh

RUN chmod +x /temp/setup_mariadb.sh

EXPOSE 3306

#CMD ["mysqld"]

#ENTRYPOINT ["bash", "/temp/setup_mariadb.sh"]

CMD ["bash", "/temp/setup_mariadb.sh"]