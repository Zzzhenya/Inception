#!/bin/bash

echo "Setting up mariadb..."

set -e

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
	if [ -z "${MYSQL_PASSWORD}" ]; then echo "Error: mandetory field \"usaer password\" is missing"
	fi
	exit 1
else
	echo "Launching mariadb..."
	#mysql -u root 
	#-p
fi

if [ ! -f /var/lib/mysql/success.txt ]; then

rm -rf /temp/config.sql

cat << EOF > /temp/config.sql

CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
EOF
#FLUSH PRIVILEGES;

cat /temp/config.sql
echo "one"
#service mysql start &
# mysqld &
# echo "two"
# kill $(cat /var/run/mysqld/mysqld.pid)

# cat /temp/config.sql

echo "three"

# 

mysqld &

sleep 2

mysql  < /temp/config.sql

kill $(cat /var/run/mysqld/mysqld.pid)

# fg

sleep 10

#kill $(cat /var/run/mysqld/mysqld.pid)

touch /var/lib/mysql/success.txt

fi

mysqld




#mysql -u root < /temp/config.sql

#mariadbd &
