#!/bin/bash

# Run migrations and setup
php artisan p:environment:setup --author="getstarted032@gmail.com" --url="https://yourdomain.com" --timezone="UTC" --cache=redis --session=redis --queue=redis
php artisan p:environment:database
php artisan p:environment:mail
php artisan migrate --seed --force

# Start services
service nginx start
php artisan serve --host=0.0.0.0 --port=80
