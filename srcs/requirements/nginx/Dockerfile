FROM debian:bullseye
RUN echo "hello world"
RUN apt-get update -y && apt-get install nginx -y
RUN which nginx
CMD ["nginx"]