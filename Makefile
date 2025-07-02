all: compose

compose:
	docker compose -f srcs/docker-compose.yml up --build -d
	docker ps | wc -l
	
build_nginx:
	docker build -t nginx srcs/requirements/nginx

build_mariadb:
	docker build -t mariadb srcs/requirements/mariadb

start_nginx: build_nginx
	#docker run --name nginxcontainer nginx
	docker run -v website:/home/login/data --network=my-bridge-network nginx:latest

start_mariadb: build_mariadb
	docker run --network=my-bridge-network mariadb:latest

build: build_nginx build_mariadb

network:
	docker network create -d bridge my-bridge-network

debug: build_mariadb
	#docker run -it -v databse:/home/login/data nginx:latest /bin/bash
	docker run --env-file srcs/.env -it -v database:/home/login/data mariadb:latest /bin/bash

start: network start_mariadb start_nginx 

stop:
	@docker ps | wc -l
	@docker stop nginx
	@docker stop mariadb
	@docker ps | wc -l
