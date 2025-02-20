# Use official PHP image with Apache
FROM php:8.1-apache

# Install required extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable mod_rewrite for Laravel
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Install Composer dependencies
RUN apt-get update && apt-get install -y unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy composer files first (only composer.json since composer.lock might not exist yet)
COPY composer.json ./

# Install dependencies
RUN composer install --no-scripts --no-autoloader

# Copy the rest of the application
COPY . .

# Generate autoloader
RUN composer dump-autoload

# Set file permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
