# Etapa 1: Build con composer para instalar dependencias
FROM composer:2 AS build

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

COPY . .

# Etapa 2: Producción con PHP + Apache
FROM php:8.2-apache

# Instalar dependencias y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip \
    && a2enmod rewrite

# Copiar la aplicación desde build
COPY --from=build /app /var/www/html

# Dar permisos correctos para Laravel (storage y cache)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

WORKDIR /var/www/html

# Copiar script para el entrypoint (si tienes alguno)
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# No generes APP_KEY ni corras migraciones aquí para evitar problemas en producción,
# eso lo haces manualmente o en el startup de Render con comandos separados.

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
