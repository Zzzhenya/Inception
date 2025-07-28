#!/bin/bash

set -x
set -e

echo "Checking mandatory env variables"

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


echo "setting up wordpress"
sleep 2

if [ ! -f /var/www/html/success.txt ]; then
	echo "downloading wp cli"
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	echo "downloading wordpress"
	wp core download https://wordpress.org/latest.tar.gz --allow-root --path=/var/www/html
	
	sleep 10
	echo "create wp config file"

	if [ ! -f /var/www/html/wp-config.php ]; then
		wp config create --allow-root \
			--dbname=${MYSQL_DATABASE} \
			--dbuser=${MYSQL_USER} \
			--dbpass=${MYSQL_PASSWORD} \
			--dbhost=mariadb \
			--path=/var/www/html
	fi
	sleep 2

	echo "create wp admin user"

	if wp user get ${ADMIN_USER} --allow-root --path=/var/www/html >/dev/null 2>&1; then
		echo $?
		echo "admin user exists"
	else
		wp core install --allow-root \
		 --url=${DOMAIN_NAME} \
		 --title=Inception --admin_user=${ADMIN_USER} \
		 --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} \
		 --path=/var/www/html --skip-email
	fi

	sleep 2
	echo "create wp user"

	if wp user get ${WP_USER} --allow-root --path=/var/www/html >/dev/null 2>&1; then
		echo "wordpress user exists"
	else
		wp user create --allow-root ${WP_USER} ${WP_USER_EMAIL} \
		 --path=/var/www/html \
		 --user_pass=${WP_USER_PASSWORD} \
		 --role=author
	fi

	echo "complete setting up wordpress"
	touch /var/www/html/success.txt
else
	echo "bash_script: wordpress available and already setup" 
fi 

echo "launch wordpress"

php-fpm7.4 -F

