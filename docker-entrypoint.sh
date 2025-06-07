#!/bin/bash
set -e

if [ -n "$PORT" ]; then
    echo "Setting Apache to listen on port $PORT"
    sed -i "s/Listen 80/Listen $PORT/" /etc/apache2/ports.conf
    sed -i "s/<VirtualHost \*:80>/<VirtualHost *:$PORT>/" /etc/apache2/sites-available/000-default.conf
fi

exec "$@"
