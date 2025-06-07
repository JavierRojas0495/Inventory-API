# Etapa 1: Build con PHP + composer + extensiones para instalar dependencias
FROM php:8.2-cli AS build

# Instala dependencias del sistema y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Instala composer globalmente (oficialmente)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

# Copia archivos de composer para optimizar cache
COPY composer.json composer.lock ./

# Instala dependencias PHP (sin dev y con optimización)
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

# Copia el resto del código
COPY . .

# Etapa 2: Imagen final con Apache y PHP + extensiones necesarias
FROM php:8.2-apache

# Instala extensiones y dependencias para producción
RUN apt-get update && apt-get install -y \
    libpq-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip \
    && a2enmod rewrite

# Copia la aplicación desde la etapa build
COPY --from=build /app /var/www/html

# Da permisos a carpetas necesarias
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copia tu script de entrada y le da permisos
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

# Ejecuta comandos para preparar Laravel
RUN php artisan key:generate --force \
    && php artisan config:clear \
    && php artisan config:cache \
    && php artisan migrate --force || true

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
