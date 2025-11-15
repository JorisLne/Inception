# Base image
FROM debian:bookworm

# Update system and install required packages
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip \
    && apt install -y php8.2-fpm php-mysql \
	&& apt clean \
	&& rm -f /var/cache/apk/*

# Copy PHP-FPM configuration file
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/

# Copy the WordPress setup script and make it executable
COPY ./tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh

# Set the script as the container's entry point
CMD ["/usr/local/bin/wordpress.sh"]
