#!/bin/bash

echo "Setting up mariadb..."

sleep 2

set -e
# set -x

if [ -z "${MYSQL_DATABASE}" ] ||
	[ -z "${MYSQL_ROOT_PASSWORD}" ] ||
	[ -z "${MYSQL_USER}" ] || [ -z "${MYSQL_PASSWORD}" ];
then
	if [ -z "${MYSQL_DATABASE}" ]; then echo "Error: mandetory field \"database name\" is missing"
	fi
	if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then echo "Error: mandetory field \"root password\" is missing"
	fi
	if [ -z "${MYSQL_USER}" ]; then echo "Error: mandetory field \"username\" is missing"
	fi
	if [ -z "${MYSQL_PASSWORD}" ]; then echo "Error: mandetory field \"user password\" is missing"
	fi
	exit 1
else
	echo "Launching mariadb..."
fi

if [ ! -f /var/lib/mysql/success.txt ]; then

rm -rf /temp/config.sql

cat << EOF > /temp/config.sql

CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';\
FLUSH PRIVILEGES;
EOF

echo "1"

mysqld --innodb-buffer-pool-load-at-startup=0 &

sleep 2
echo "2"

mysql  < /temp/config.sql

kill $(cat /var/run/mysqld/mysqld.pid)

echo "3"

# fg

sleep 2

touch /var/lib/mysql/success.txt

fi

mysqld

