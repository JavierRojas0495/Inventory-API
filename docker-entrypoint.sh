#!/bin/bash
set -e

echo "🔧 Ajustando permisos..."
chown -R www-data:www-data storage bootstrap/cache

echo "📦 Ejecutando migraciones (si es necesario)..."
php artisan migrate --force || echo "⚠️ Migraciones fallidas o ya ejecutadas"

echo "⚙️ Limpiando y cacheando configuración y rutas..."
php artisan config:clear
php artisan config:cache
php artisan route:cache

echo "🚀 Iniciando Apache..."
exec "$@"
