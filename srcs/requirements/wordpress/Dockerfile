#base image
FROM debian:bullseye

#testing
RUN echo "wordpress"

#download updated package information and upgrade
RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install php7.4 php-fpm php-mysql -y --fix-missing

RUN apt install -y wget

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

RUN php-fpm7.4 -v

RUN mkdir -p /run/php-fpm var/run/php-fpm /run/php

COPY tools/init_script.sh tmp/init_script.sh

RUN chmod +x tmp/init_script.sh

#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

#RUN chmod +x wp-cli.phar

#CMD ["php-fpm7.4", "-F"]
CMD ["bash", "/tmp/init_script.sh"]
