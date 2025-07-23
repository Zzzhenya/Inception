#!/bin/bash

#set -x
set -e

#rm -rf /var/www/html/*

if [ -z "${MYSQL_DATABASE}" ] ||
	[ -z "${MYSQL_ROOT_PASSWORD}" ] ||
	[ -z "${MYSQL_USER}" ] || [ -z "${MYSQL_PASSWORD}" ];
then
	echo "MYSQL env data missing"
	exit 1
elif [ -z "${ADMIN_USER}" ] || [ -z "${DOMAIN_NAME}" ] || [ -z "${ADMIN_PASSWORD}" ] || [ -z "${ADMIN_EMAIL}" ];
then
	echo "Admin env data missing"
	exit 2
elif [ -z "${WP_USER}" ] || [ -z "${WP_USER_EMAIL}" ] || [ -z "${WP_USER_PASSWORD}" ];
then
	echo "WP User env data missing"
	exit 3
else
	echo "Launching mariadb..."
	#mysql -u root 
	#-p
fi


echo "wordpress 1"

#|| :

sleep 2

if [ ! -f /var/www/html/success.txt ]; then
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	echo "1"

	wp core download https://wordpress.org/latest.tar.gz --allow-root --path=/var/www/html

	echo "2"
	# env
	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb \
		--path=/var/www/html
	
	sleep 2
	echo "3"

	if wp user get ${ADMIN_USER} --allow-root --path=/var/www/html >/dev/null 2>&1; then
		# wp user get ${ADMIN_USER} --allow-root --path=/var/www/html
		echo "admin user exists"
	else
		wp core install --allow-root \
		 --url=${DOMAIN_NAME} \
		 --title=Inception --admin_user=${ADMIN_USER} \
		 --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} \
		 --path=/var/www/html --skip-email
	fi

	sleep 2
	echo "4"

	if wp user get ${WP_USER} --allow-root --path=/var/www/html >/dev/null 2>&1; then
		# wp user get ${WP_USER} --allow-root --path=/var/www/html
		echo "wordpress user exists"
	else
		wp user create --allow-root ${WP_USER} ${WP_USER_EMAIL} \
		 --path=/var/www/html \
		 --user_pass=${WP_USER_PASSWORD} \
		 --role=author
	fi

	echo "5"

	touch /var/www/html/success.txt
	echo "6"
else
	echo "bash_script: wordpress available and already setup" 
fi 

echo "7"

# rm -rf /var/www/html/wp-config.php

# ./wp-cli.phar config create --allow-root \
# 	--dbname=${MYSQL_DATABASE} \
# 	--dbuser=${MYSQL_USER} \
# 	--dbpass=${MYSQL_PASSWORD} \
# 	--dbhost=mariadb \
# 	--path=/var/www/html

echo "4"

php-fpm7.4 -F
