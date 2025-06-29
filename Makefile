all:
	echo "hello"

build:
	docker build -t nginx srcs/requirements/nginx

start:
	#docker run --name nginxcontainer nginx
	docker run nginx:latest

stop:
	docker ps
	docker stop nginx:latest
