# Etapa 1: Build con PHP y extensiones necesarias
FROM php:8.2-cli AS build

RUN apt-get update && apt-get install -y libpq-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

COPY . .

# Etapa 2: Producción con PHP + Apache
FROM php:8.2-apache

RUN apt-get update && apt-get install -y libpq-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip \
    && a2enmod rewrite

COPY --from=build /app /var/www/html

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

RUN php artisan key:generate --force && \
    php artisan config:clear && \
    php artisan config:cache && \
    php artisan migrate --force || true

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
