#base image
FROM debian:bullseye

#testing
RUN echo "nginx"

#download updated package information and upgrade
RUN apt-get update -y && apt-get upgrade -y

#install nginx
RUN apt-get install nginx -y

#find where nginx gets installed
RUN which nginx

RUN apt-get install openssl

RUN mkdir /etc/ssl/nginx

RUN openssl version -a

RUN openssl req -x509 -nodes -keyout /etc/ssl/nginx/inception.key -out /etc/ssl/nginx/inception.crt -subj "/CN=sde-silv.42.fr" -days 365

#RUN rm -rf /etc/nginx/nginx.conf

#COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/copy.conf /etc/nginx/sites-enabled/nginx.conf
COPY conf/copy.conf /etc/nginx/sites-available/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
#CMD ["nginx"]