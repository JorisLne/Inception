# Base image
FROM debian:bookworm

# Update system, install packages
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y nginx openssl gettext-base \
    # Create dir for SSL certificates
    && mkdir -p /etc/nginx/ssl/certs \
    && mkdir -p /etc/nginx/ssl/private \
    # Clean up package lists
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Nginx config
COPY conf/default.template /etc/nginx/sites-available/default.template

# Copy the entrypoint script and make it executable
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script as the entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Start Nginx (no daemon mode)
CMD [ "nginx", "-g", "daemon off;" ]
