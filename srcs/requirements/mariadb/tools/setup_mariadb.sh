#!/bin/bash

echo "Setting up mariadb..."

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
	mysqld
fi
