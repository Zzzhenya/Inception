#!/bin/bash

#php-fpm7.4 -F
set -x
#set -e

echo "wordpress 1"

sleep 2
# chmod +x wp-cli.phar

# if [ ! -f /var/www/html/wp-config.php ]; then
if [ ! -f /var/www/html/success.txt ]; then
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	echo "1"

	#./wp-cli.phar core download https://wordpress.org/latest.tar.gz --allow-root --path=/var/www/html || :

	wp core download https://wordpress.org/latest.tar.gz --allow-root --path=/var/www/html
	echo "2"
	env
	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb \
		--path=/var/www/html
	# ./wp-cli.phar config create --allow-root \
	# 	--dbname=${MYSQL_DATABASE} \
	# 	--dbuser=${MYSQL_USER} \
	# 	--dbpass=${MYSQL_PASSWORD} \
	# 	--dbhost=localhost \
	# 	--path=/var/www/html

	sleep 2
	echo "3"
	if wp user get ${ADMIN_USER} >/dev/null 2>&1; then
		echo "user exist"
	else
		wp core install --allow-root \
		 --url=${DOMAIN_NAME} \
		 --title=Inception --admin_user=${ADMIN_USER} \
		 --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} \
		 --path=/var/www/html --skip-email
	fi
		# ./wp-cli.phar core install --allow-root \
		#  --url=${DOMAIN_NAME} \
		#  --title=Inception --admin_user=${ADMIN_USER} \
		#  --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} \
		#  --path=/var/www/html --skip-email

	 sleep 2
	 echo "4"
	# wp user create --allow-root --path=/var/www/html --user_pass= --role=author wpuser1
	# usage: wp user create <user-login> <user-email> 
	# [--role=<role>] 
	# [--user_pass=<password>] 
	# [--user_registered=<yyyy-mm-dd-hh-ii-ss>] 
	# [--display_name=<name>] 
	# [--user_nicename=<nice_name>] 
	# [--user_url=<url>] 
	# [--nickname=<nickname>] 
	# [--first_name=<first_name>] 
	# [--last_name=<last_name>] 
	# [--description=<description>] 
	# [--rich_editing=<rich_editing>] 
	# [--send-email] 
	# [--porcelain]
	if wp user get ${WP_USER} >/dev/null 2>&1; then
		echo "user exists"
	else
		wp user create --allow-root ${WP_USER} ${WP_USER_EMAIL} \
		 --path=/var/www/html \
		 --user_pass=${WP_USER_PASSWORD} \
		 --role=author


		# ./wp-cli.phar user create --allow-root \
		#  --path=/var/www/html \
		#  --user_pass=${WP_PASSWORD} \
		#  --role=author ${WP_USER} ${WP_EMAIL}

		 echo "5"
	fi

	 touch /var/www/html/success.txt
	 echo "6"
else
	echo "bash_script: wordpress available" 
fi 

echo "100"

# rm -rf /var/www/html/wp-config.php

# ./wp-cli.phar config create --allow-root \
# 	--dbname=${MYSQL_DATABASE} \
# 	--dbuser=${MYSQL_USER} \
# 	--dbpass=${MYSQL_PASSWORD} \
# 	--dbhost=mariadb \
# 	--path=/var/www/html

echo "4"

php-fpm7.4 -F
