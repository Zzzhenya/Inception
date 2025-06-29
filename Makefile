all:
	echo "hello"

build:
	docker build -t nginx srcs/requirements/nginx

debug:
	docker run -it -v databse:/home/login/data nginx:latest /bin/bash

start:
	#docker run --name nginxcontainer nginx
	docker run -v databse:/home/login/data nginx:latest

stop:
	docker ps
	docker stop nginx:latest
