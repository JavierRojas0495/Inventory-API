#!/bin/bash

echo "Esperando a que la base de datos esté disponible..."

until php -r "
try {
    new PDO(
        getenv('DB_CONNECTION') . ':host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD')
    );
    echo 'Conexión exitosa a la base de datos.' . PHP_EOL;
    exit(0);
} catch (Exception \$e) {
    echo 'Error de conexión: ' . \$e->getMessage() . PHP_EOL;
    exit(1);
}
"; do
  echo "Reintentando conexión..."
  sleep 3
done

echo "Ejecutando comandos de Laravel..."
php artisan config:clear
php artisan config:cache
php artisan key:generate --force
php artisan migrate --force

echo "Iniciando Apache..."
exec apache2-foreground
