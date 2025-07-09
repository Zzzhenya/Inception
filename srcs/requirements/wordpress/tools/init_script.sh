#!/bin/bash

#php-fpm7.4 -F

set -e

sleep 10

# if [ ! -f /home/login/data/wp-config.php ]; then
#wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# mv wp-cli.phar /usr/local/bin/wp

# ./wp-cli.phar core download https://wordpress.org/latest.tar.gz --allow-root --path=/home/login/data/

# ./wp-cli.phar config create --allow-root \
# 	--dbname=${MYSQL_DATABASE} \
# 	--dbuser=${MYSQL_USER} \
# 	--dbpass=${MYSQL_PASSWORD} \
# 	--dbhost=mariadb \
# 	--path=/home/login/data/

# sleep 2

# ./wp-cli.phar core install --allow-root \
#  --url=${DOMAIN_NAME} \
#  --title=Inception --admin_user=${ADMIN_USER} \
#  --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} \
#  --path=/home/login/data/ --skip-email

#  sleep 2

# ./wp-cli.phar user create --allow-root \
#  --path=/home/login/data/ \
#  --user_pass=${WP_PASSWORD} \
#  --role=author ${WP_USER} ${WP_EMAIL}

# fi 

php-fpm7.4 -F
