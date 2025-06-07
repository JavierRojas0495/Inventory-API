#!/bin/sh

echo "⏳ Esperando a que la base de datos esté lista..."
until php artisan migrate --force; do
  echo "🔁 Reintentando migraciones..."
  sleep 5
done

echo "✅ Migraciones aplicadas. Iniciando Apache..."
apache2-foreground
