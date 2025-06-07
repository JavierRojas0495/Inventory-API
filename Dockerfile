# Imagen base oficial de PHP con Apache
FROM php:8.2-apache

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    zip unzip git curl libzip-dev libpq-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar los archivos del proyecto al contenedor
COPY . .

# Cambiar DocumentRoot a /public
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Permisos para Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader || true

# Copiar script de arranque
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Exponer puerto 80 (default)
EXPOSE 80

# Aquí vamos a modificar la configuración de Apache para usar el puerto de Render

# En el script docker-entrypoint.sh (que tú tienes), añadiremos estas líneas para
# reemplazar el puerto 80 por el valor de la variable $PORT

# Puedes editar docker-entrypoint.sh y añadir esto antes de arrancar Apache:
#
#   if [ -n "$PORT" ]; then
#       sed -i "s/Listen 80/Listen $PORT/" /etc/apache2/ports.conf
#       sed -i "s/<VirtualHost \*:80>/<VirtualHost *:$PORT>/" /etc/apache2/sites-available/000-default.conf
#   fi
#
#   apache2-foreground

# Así Apache escuchará en el puerto que Render le asigne (en $PORT)

# Comando de arranque
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
