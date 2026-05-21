FROM richarvey/nginx-php-fpm:1.10.3

# Copiar el código del proyecto al contenedor
COPY . /var/www/html

# Configurar el directorio raíz hacia la carpeta public de Laravel
ENV WEBROOT /var/www/html/public
ENV APP_ENV production

# Instalar dependencias necesarias obligando a Composer a pasar la validación
RUN apk add --no-cache nodejs npm \
    && composer install --no-dev --optimize-autoloader --ignore-platform-reqs \
    && npm install \
    && npm run dev

# Exponer el puerto que usa Render
EXPOSE 80
