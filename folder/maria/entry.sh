#!/bin/bash

set -e  # stop script if any command fails

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Read secrets from files
MYSQL_ROOT_PASSWORD=$(cat $DB_ROOT_PWD_PATH)
MYSQL_PASSWORD=$(cat $DB_PWD_PATH)

# create .sql
cat > $SQL_FILE_PATH <<EOF
-- set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

-- create WordPress user and grant privileges
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

-- apply privilege changes
FLUSH PRIVILEGES;
EOF

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "First run: initializing MariaDB"

	service mysql start 
	# wait until MySQL is ready
	until mysqladmin ping >/dev/null 2>&1; do
		echo "Waiting for MariaDB to start..."
		sleep 1
	done
	mysql -u root < $SQL_FILE_PATH
	service mysql stop
fi

exec mysqld --user=mysql --console
