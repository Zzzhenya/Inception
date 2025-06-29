all: start
	

build_nginx:
	docker build -t nginx srcs/requirements/nginx

build_mariadb:
	docker build -t mariadb srcs/requirements/mariadb

start_nginx: build_nginx
	#docker run --name nginxcontainer nginx
	docker run -v website:/home/login/data nginx:latest

start_mariadb: build_mariadb
	docker run mariadb:latest

build: build_nginx build_mariadb

debug: build_mariadb
	#docker run -it -v databse:/home/login/data nginx:latest /bin/bash
	docker run -it -v database:/home/login/data mariadb:latest /bin/bash

start: start_mariadb start_nginx 

stop:
	docker ps
	docker stop nginx:latest
	docker stop mariadb:latest
