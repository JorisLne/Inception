# Base image
FROM debian:bookworm

# Update system and install MariaDB server
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y mariadb-server \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the MariaDB configuration file
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the MariaDB startup script and make it executable
COPY ./tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

# Set the MariaDB startup script as the entry point
CMD ["/usr/local/bin/mariadb.sh"]


# open a shell in the container : docker exec -it mariadb bash
# log to DB using .env ID's : mariadb -u $MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PASSWORD
# select WP DB : USE $MYSQL_DATABASE;
# then : SHOW TABLES;
# then : SELECT * FROM wp_users;