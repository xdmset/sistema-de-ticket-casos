FROM richarvey/nginx-php-fpm:1.10.3

# Copiar el código del proyecto al contenedor
COPY . /var/www/html

# Copiar la configuración correcta de Nginx para Laravel
COPY nginx.conf /etc/nginx/sites-available/default.conf

# Configurar variables de entorno indispensables para producción
ENV WEBROOT /var/www/html/public
ENV APP_ENV production
ENV APP_URL https://sistema-de-tickets-0j7c.onrender.com

# Solucionar el problema de mayúsculas/minúsculas en Linux antes de compilar
RUN ln -s /var/www/html/resources/js/components /var/www/html/resources/js/Components

# Instalar dependencias necesarias obligando a Composer a pasar la validación
RUN apk add --no-cache nodejs npm \
    && composer install --no-dev --optimize-autoloader --ignore-platform-reqs \
    && npm install \
    && npm run dev

# Limpiar cachés viejas de configuración de Laravel si existieran
RUN php artisan config:clear || true \
    && php artisan view:clear || true

# Exponer el puerto que usa Render
EXPOSE 80
