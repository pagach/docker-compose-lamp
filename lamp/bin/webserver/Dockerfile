FROM php:8.3.6-apache

#Run apache as root to avoid file permissions issues
# Create a non-root user to run our application
RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -m appuser

RUN apt-get -y update --fix-missing
RUN apt-get upgrade -y

# Install tools & libraries
RUN apt-get -y install apt-utils nano wget dialog \
    build-essential git curl libcurl4 libcurl4-openssl-dev libzip-dev zip

# Install important libraries
RUN apt-get -y install --fix-missing apt-utils build-essential \
    libsqlite3-dev libsqlite3-0 mariadb-client zlib1g-dev \
    libicu-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev nodejs libonig-dev

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# NodeJs and NPM
RUN apt-get install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_20.x | bash \
    && apt-get install nodejs -yq

# ImageMagick
RUN apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick

# PHP Extensions
#RUN pecl install xdebug-2.6.0 \
#    && docker-php-ext-enable xdebug \
# Install and configure PHP extensions
RUN docker-php-ext-install opcache && \
  docker-php-ext-install pdo_mysql && \
  docker-php-ext-install pdo_sqlite && \
  docker-php-ext-install mysqli && \
  docker-php-ext-install curl && \
  docker-php-ext-install zip && \
  docker-php-ext-install intl && \
  docker-php-ext-install mbstring && \
  docker-php-ext-configure gd --with-freetype --with-jpeg && \
  docker-php-ext-install -j$(nproc) gd

# Install and enable PECL extensions like Redis
RUN pecl install redis \
    && docker-php-ext-enable redis

RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf && \
    a2enconf fqdn && \
    a2enmod rewrite headers

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
  sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf && \
  sed -i 's/www-data/appuser/g' /etc/apache2/envvars

# Copy application source
COPY --chown=appuser:appuser . /var/www/html${APACHE_DOCUMENT_ROOT}

# Permissions for Symfony specific directories
RUN chown -R appuser:appuser /var/www/html

# Use non-root user
USER appuser

# Set working directory
WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
