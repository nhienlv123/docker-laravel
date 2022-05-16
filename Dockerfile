FROM php:7.4-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

COPY ./ /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN composer update
RUN composer install
RUN php artisan key:generate
RUN docker-php-ext-install pdo pdo_mysql

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user
RUN usermod -aG sudo $user
RUN echo "${user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER $user