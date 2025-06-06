# Usa una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql zip

# Habilita mod_rewrite
RUN a2enmod rewrite

# Copia los archivos del proyecto al contenedor
COPY . /var/www/html

# Establece el working dir
WORKDIR /var/www/html

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala dependencias
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Da permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Expone el puerto 80
EXPOSE 80

CMD php artisan migrate --force && apache2-foreground
