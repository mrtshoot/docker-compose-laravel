#!/bin/bash
#To cache these settings into a file, which will boost application’s load speed
docker-compose exec app php artisan config:cache
