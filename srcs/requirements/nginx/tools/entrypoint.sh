#!/bin/sh

# Generate SSL certificate
if [ ! -f /etc/nginx/ssl/certs/inception.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -out /etc/nginx/ssl/certs/inception.crt \
        -keyout /etc/nginx/ssl/private/inception.key \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}/UID=jlaine"
fi

# Substitute environment variables in the nginx configuration
_DOMAIN_NAME="${DOMAIN_NAME}"
export _DOMAIN_NAME

envsubst '${_DOMAIN_NAME}' < /etc/nginx/sites-available/default.template > /etc/nginx/sites-available/default

# Start Nginx
exec "$@"