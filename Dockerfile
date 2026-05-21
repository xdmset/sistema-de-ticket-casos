FROM richarvey/nginx-php-fpm:latest

# Copiar el código del proyecto al contenedor
COPY . /var/www/html

# Configurar el directorio raíz de Apache/Nginx hacia la carpeta public de Laravel
ENV WEBROOT /var/www/html/public
ENV APP_ENV production

# Instalar dependencias de PHP y compilar el frontend
RUN apk add --no-cache nodejs npm \
    && composer install --no-dev --optimize-autoloader \
    && npm install \
    && npm run dev

# Exponer el puerto que usa Render
EXPOSE 80
