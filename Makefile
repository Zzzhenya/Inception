all:
	echo "hello"

build:
	docker build -t nginx srcs/requirements/nginx

run:
	docker run nginx:latest