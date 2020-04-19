#!/bin/bash
#generate a key and copy it to .env
docker-compose exec app php artisan key:generate
