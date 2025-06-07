# Etapa 1: Build
FROM composer:2 AS build

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

COPY . .

# Etapa 2: Producción
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git curl libzip-dev zip \
    && docker-php-ext-install pdo pdo_pgsql zip

# Copia archivos de la build anterior
COPY --from=build /app /var/www/html

# Configura Apache
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Establece permisos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Comandos para preparar Laravel (sin copiar .env.example)
RUN php artisan key:generate --force && \
    php artisan config:clear && \
    php artisan config:cache && \
    php artisan migrate --force || true

# Entry point opcional (si tienes uno)
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
