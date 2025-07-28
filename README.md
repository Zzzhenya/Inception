* buildkit error/warning
	
	https://docs.docker.com/engine/deprecated/#buildkit-build-information

* apt : apt does not have a stable CLI interface
	
	https://askubuntu.com/questions/990823/apt-gives-unstable-cli-interface-warning

* -y : say yes to all the installation queries

	https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/

	https://blog.packagecloud.io/you-need-apt-get-update-and-apt-get-upgrade/

* daemon:off - run nginx in the foreground
	
	https://quinn.io/2014/03-26-running-nginx-in-the-foreground/

* docker ps : list of running docker containers
	
	https://labex.io/tutorials/docker-how-to-retrieve-the-id-or-name-of-a-running-docker-container-414848

* RUN, CMD, ENTRYPOINT, PID1, Shell and Exec forms - 

	https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/

* debconf: delaying package configuration, since apt-utils is not installed
	
	https://stackoverflow.com/questions/51023312/docker-having-issues-installing-apt-utils

* OpenSSL  

	https://shape.host/resources/installing-openssl-on-debian-12-a-comprehensive-guide

	https://olivierkonate.medium.com/openssl-ssl-tls-toolkit-basics-db390cca7187


* Docker volumes - 

	https://docs.docker.com/engine/storage/volumes/

* Dockerfile - basic commans: 

	https://dev.to/prodevopsguytech/writing-a-dockerfile-beginners-to-advanced-31ie#3-basics-of-a-dockerfile

* nginx conf

	ssl_prefer_server_ciphers on; - 

		https://www.youtube.com/watch?v=P1v6QA0W7Xw

		https://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_prefer_server_ciphers

		https://security.stackexchange.com/questions/203684/who-is-responsible-for-choosing-a-tls-cipher-suite-the-client-or-the-server


* Mariadb abort error:

	https://stackoverflow.com/questions/43593736/used-chown-for-var-lib-mysql-to-change-owner-from-root-now-getting-error-1049

	RUN mkdir -p /var/lib/mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

	https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-debian-11

* Docker compose version

	https://stackoverflow.com/questions/76156527/what-does-the-first-line-in-the-docker-compose-yml-file-that-specifies-the-ve


* ENTRYPOINT

	www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/

* Cannot start php, unable to create PID file

	https://stackoverflow.com/questions/45540492/cannot-start-php-because-it-is-unable-to-create-pid-file

* 

#-docker system prune -a -f
#-docker volume rm srcs_mariadb
#-docker volume rm srcs_wordpress
#-docker volume rm wordpress
#-docker volume rm mariadb
#-clean

# debug: build_mariadb
# 	#echo $(HERE)
# 	#build_mariadb
# 	#docker run -it -v databse:/home/login/data nginx:latest /bin/bash
# 	docker run --env-file srcs/.env -it -v $(HERE)requirements/volumes/mariadb:/home/login/data mariadb:latest /bin/bash
# 	#docker run --env-file srcs/.env -it -mount type=volume database:/home/login/data mariadb:latest /bin/bash
	
# 	#docker run -it --env-file srcs/.env -v $(HERE)requirements/volumes/mariadb:/home/login/data mariadb:latest /bin/bash

# test: compose #build_mariadb
# # 	docker run --env-file srcs/.env mariadb:latest
# 	#docker run -it --env-file srcs/.env -v $(HERE)requirements/volumes/mariadb:/home/login/data mariadb:latest
# 	docker exec -it mariadb /bin/bash

# start: start_mariadb start_nginx #network



# build_nginx:
# 	docker build -t nginx srcs/requirements/nginx

# build_mariadb:
# 	docker build -t mariadb srcs/requirements/mariadb

# build_wordpress:
# 	docker build -t wordpress srcs/requirements/wordpress

# start_wordpress: build_wordpress
# 	docker run --env-file srcs/.env  wordpress:latest

# start_nginx: build_nginx
# 	#docker run --name nginxcontainer nginx
# 	docker run --env-file srcs/.env  nginx:latest #--network=my-bridge-network

# start_mariadb: build_mariadb
# 	docker run --env-file srcs/.env -v $(HERE)/requirements/volumes/mariadb:/home/login/data mariadb:latest
# #--network=my-bridge-network

# build: build_nginx build_mariadb

#network:
#	docker network create -d bridge my-bridge-network

#docker run --mount type=volume,src=myvolume,dst=/data,ro,volume-subpath=/foo
