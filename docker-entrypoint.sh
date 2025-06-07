#!/bin/bash

# Esperar a que la base de datos esté disponible
echo "Esperando a que la base de datos esté disponible..."
until php artisan migrate:status > /dev/null 2>&1; do
  >&2 echo "La base de datos aún no está lista - esperando..."
  sleep 3
done

# Generar clave si no existe
if [ ! -s .env ] || ! grep -q "APP_KEY=base64" .env; then
  echo "Generando clave de aplicación..."
  php artisan key:generate
fi

# Ejecutar migraciones (ignora errores si ya están aplicadas)
echo "Ejecutando migraciones..."
php artisan migrate --force || true

# Ejecutar el comando principal del contenedor
exec "$@"
