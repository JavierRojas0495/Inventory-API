# Etapa 1: build de dependencias PHP
FROM composer:2 AS build

WORKDIR /app

# Copiar composer y instalar dependencias
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Copiar todo el proyecto
COPY . .

# Etapa 2: contenedor final con PHP 8.2 + Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    curl \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_pgsql zip

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Establecer el document root en /public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Reescribir configuración de Apache para usar el nuevo document root
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copiar código desde el build stage
COPY --from=build /app /var/www/html

# Copiar script de inicio para Render
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Usar script como entrypoint y ejecutar Apache
ENTRYPOINT ["/start.sh"]
CMD ["apache2-foreground"]

