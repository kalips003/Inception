#!/bin/bash

set -e  # stop script if any command fails

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

echo -e $C_501 "--- IN MARIA ---" $RESET
echo -e $C_104 "MYSQL_DATABASE=$MYSQL_DATABASE" $RESET
echo -e $C_104 "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" $RESET
echo -e $C_104 "MYSQL_USER=$MYSQL_USER" $RESET
echo -e $C_104 "MYSQL_PASSWORD=$MYSQL_PASSWORD" $RESET
echo -e $C_501 "-------------------------" $RESET
echo -e $C_501 "-$SQL_FILE_PATH: ---------------"
cat $SQL_FILE_PATH
echo -e "-------------------------" $RESET

mysqld_safe &

echo -e $C_505 "-TRYING-----------------------" $RESET
ls /var/lib/mysql

# wait until MySQL is ready
until mysqladmin ping >/dev/null 2>&1; do
	echo -e $C_151 "Waiting for MariaDB to start..." $RESET
	sleep 1
done

if ! mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "USE wordpress;" >/dev/null 2>&1; then
	echo -e $C_151 "First run: initializing MariaDB" $RESET
	mysql -u root < $SQL_FILE_PATH
else
	echo -e $C_151 "ALREADY setup" $RESET
fi

killall mariadbd

exec mysqld --user=mysql --console
