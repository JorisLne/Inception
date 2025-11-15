#!/bin/bash

# Create the init.sql file
touch init.sql

# Add SQL commands to the file
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> init.sql
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" >> init.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" >> init.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> init.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ADMIN_USER'@'%' WITH GRANT OPTION;" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

# Create mysqld dir
mkdir -p /run/mysqld

# Initialize BD moving init.sql to MariaDB's start dir
mv init.sql /etc/mysql/init.sql

# Start the MySQL daemon
exec "mysqld"
