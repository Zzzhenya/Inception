HERE = $(PWD)

all: compose

compose:
	docker compose -f srcs/docker-compose.yml up --build -d
	docker ps | wc -l
	
build_nginx:
	docker build -t nginx srcs/requirements/nginx

build_mariadb:
	docker build -t mariadb srcs/requirements/mariadb

build_wordpress:
	docker build -t wordpress srcs/requirements/wordpress

start_wordpress: build_wordpress
	docker run --env-file srcs/.env  wordpress:latest

start_nginx: build_nginx
	#docker run --name nginxcontainer nginx
	docker run --env-file srcs/.env  nginx:latest #--network=my-bridge-network

start_mariadb: build_mariadb
	docker run --env-file srcs/.env -v $(HERE)/requirements/volumes/mariadb:/home/login/data mariadb:latest
#--network=my-bridge-network

build: build_nginx build_mariadb

#network:
#	docker network create -d bridge my-bridge-network

#docker run --mount type=volume,src=myvolume,dst=/data,ro,volume-subpath=/foo

debug: build_mariadb
	#echo $(HERE)
	#build_mariadb
	#docker run -it -v databse:/home/login/data nginx:latest /bin/bash
	docker run --env-file srcs/.env -it -v $(HERE)requirements/volumes/mariadb:/home/login/data mariadb:latest /bin/bash
	#docker run --env-file srcs/.env -it -mount type=volume database:/home/login/data mariadb:latest /bin/bash
	
	#docker run -it --env-file srcs/.env -v $(HERE)requirements/volumes/mariadb:/home/login/data mariadb:latest /bin/bash

test: compose #build_mariadb
# 	docker run --env-file srcs/.env mariadb:latest
	#docker run -it --env-file srcs/.env -v $(HERE)requirements/volumes/mariadb:/home/login/data mariadb:latest
	docker exec -it mariadb /bin/bash

start: start_mariadb start_nginx #network

stop:
	@-docker ps | wc -l
	@-docker stop wordpress
	@-docker stop mariadb
	@-docker stop nginx
	@-docker ps | wc -l

clean: stop
	-docker image prune -af
	-docker volume prune -af
	-docker network prune -f

fclean: stop
	-docker system prune -a -f
	-docker volume rm srcs_mariadb
	-docker volume rm srcs_wordpres
	-docker volume rm wordpress
	-docker volume rm mariadb
	-clean

status:
	docker ps

log:
	-docker logs nginx
	-docker logs mariadb 
	-docker logs wordpress

