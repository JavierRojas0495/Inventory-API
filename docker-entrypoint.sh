#!/bin/bash
set -e

# Cambiar puerto Apache si la variable $PORT está definida (Render la pasa)
if [ -n "$PORT" ]; then
    echo "Setting Apache to listen on port $PORT"
    sed -i "s/Listen 80/Listen $PORT/" /etc/apache2/ports.conf
    sed -i "s/<VirtualHost \*:80>/<VirtualHost *:$PORT>/" /etc/apache2/sites-available/000-default.conf
fi

# Ejecutar el comando por defecto (apache2-foreground)
exec "$@"
