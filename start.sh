# Instalamos dependencias de Composer
composer install

# Arrancamos servicios de PHP y nginx
service php7.3-fpm start
service nginx start

# Descomenta esta linea para abrir una terminal de depuración
# /bin/bash
# Descomenta esta linea para mostrar logs de accesos de nginx
tail -f /var/log/nginx/access.log /var/log/nginx/error.log | ccze