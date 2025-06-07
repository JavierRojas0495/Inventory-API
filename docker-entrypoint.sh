#!/bin/bash
set -e

# Cambiar permisos por si acaso (opcional)
chown -R www-data:www-data storage bootstrap/cache

# Ejecutar migraciones sin que falle el container si hay error
php artisan migrate --force || echo "Migraciones fallidas o ya ejecutadas"

# Limpiar y cachear configuración y rutas para optimizar Laravel
php artisan config:clear
php artisan config:cache
php artisan route:cache

# Finalmente, ejecutar el comando por defecto (apache2)
exec "$@"
