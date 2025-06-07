#!/bin/bash

# Esperar que la base de datos esté lista
echo "Esperando a que la base de datos esté disponible..."
until php -r "try {
    new PDO(
        getenv('DB_CONNECTION') . ':host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD')
    );
    echo 'Conexión a la base de datos exitosa.';
} catch (Exception \$e) {
    echo 'Esperando conexión...';
    sleep(3);
    exit(1);
}";
do
  sleep 3
done

# Comandos de Laravel
echo "Ejecutando comandos de Laravel..."
php artisan config:clear
php artisan config:cache
php artisan key:generate --force
php artisan migrate --force

# Iniciar Apache
echo "Iniciando Apache..."
exec apache2-foreground
