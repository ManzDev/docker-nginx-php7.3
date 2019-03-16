FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

WORKDIR /var/www/html

RUN apt-get update -y && apt-get install -y --no-install-recommends php7.3-fpm \
      php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-mysql \
      php7.3-phpdbg php7.3-mbstring php7.3-gd php7.3-imap php7.3-pspell \
      php7.3-recode php7.3-tidy php7.3-dev php7.3-intl php7.3-curl \
      php7.3-zip php7.3-xml php7.3-sqlite3 pkg-config libpng-dev libjpeg-dev \
      composer ccze nginx localepurge unzip

ENV COMPOSER_ALLOW_SUPERUSER 1

# Eliminamos cache de apt y otros
RUN apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# Copiamos nuestra configuración de Nginx al contenedor
COPY nginx.conf /etc/nginx/sites-available/default

# Copiamos al raíz el script de entrada
COPY start.sh /start.sh

# Establecemos idioma y zona horaria
ENV TZ=Europe/London
RUN echo $TZ > /etc/timezone && \
    sed -i 's/^# *\(es_ES.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen
ENV LANGUAGE=es_ES.UTF-8
ENV LANG=es_ES.UTF-8
ENV LC_ALL=es_ES.UTF-8

ENTRYPOINT ["sh", "/start.sh"]