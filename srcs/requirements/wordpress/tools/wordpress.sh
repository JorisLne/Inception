#!/bin/bash

# Download WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Set dir permissions
chmod 777 /var/www/wordpress
chmod 777 /var/www/

# Change dir to WordPress installation
cd /var/www/wordpress

if [ ! -f "wp-config.php" ]; then
    # Install WordPress and config DB
    su www-data -s /bin/bash -c "
        wp core download
        wp config create --dbname=\"$MYSQL_DATABASE\" --dbuser=\"$MYSQL_ADMIN_USER\" --dbpass=\"$MYSQL_ADMIN_PASSWORD\" --dbhost=\"$MYSQL_HOSTNAME\"
        wp core install --url='https://$DOMAIN_NAME' --title='HELLO' --admin_user='$MYSQL_ADMIN_USER' --admin_password='$MYSQL_ADMIN_PASSWORD' --admin_email='$MYSQL_ADMIN_MAIL'
        wp option update home 'https://$DOMAIN_NAME'
        wp option update siteurl 'https://$DOMAIN_NAME'
        wp user create '$MYSQL_USER' '$MYSQL_USER_MAIL' --role=author --user_pass='$MYSQL_PASSWORD'
    "
fi



# Start PHP-FPM service
exec php-fpm8.2 -F
