# Dockerfile
FROM php:8.2-cli

# Установка системных зависимостей + wget
RUN apt-get update && apt-get install -y \
    libpq-dev \
    wget \
    && docker-php-ext-install pdo pdo_pgsql

# Установка PHPUnit через wget
RUN wget https://phar.phpunit.de/phpunit-9.6.20.phar -O /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit

# Рабочая директория
WORKDIR /var/www/html

# Копирование проекта
COPY . .

# Запуск сервера
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]