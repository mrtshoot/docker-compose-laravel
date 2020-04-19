# Docker Compose for Laravel Infrastructure
this repository provide laravel infrastructure with docker compose orchestrator

### Step1
go to /opt and clone this repository
```
cd /opt;git clone http://git.mobtaker.local/mobtaker-team/docker-compose-laravel.git
```

### Step2
change your directory to cloned directory and cp your env files for php and db and phpmyadmin images and change it to your own information.
```
cp .env/.db.env.example .env/db.env
cp .env/.php.env.example .env/php.env
cp .env/.phpmyadmin.env.example .env/phpmyadmin.env
```

### Step3
cp your local.ini file for php configuration files and add any setting you have like.
```
cp php/.local.ini.example php/local.ini
```

### Step4
cp your app.conf nginx configuration file for server proxy and add your setting.
```
cp nginx/conf.d/.app.conf.example nginx/conf.d/app.conf
```
### Step5
cp your mysql configuration file
```
cp mysql/.mysql.env.example mysql/mysql.env
```


### Step6
clone laravel app repository to your current working directory
```
git clone https://github.com/laravel/laravel.git laravel-app
```

### Step7
add composer to your laravel-app directory
```
cd laravel-app;docker run --rm -v $(pwd):/app composer install
```
if you have local repo run following command
```
cd laravel-app;docker run --rm -v $(pwd):/app YOUR_PRIVATE_REGISTRY_URL/composer install
```

### Step8 (Optional)
Change your docker images with your local repository if you needed.

### Step9
run docker compose command
```
docker-compose up -d
```

### Step10
Create your laravel application key with command
```
docker-compose exec app php artisan key:generate
```

### Step11
To cache these settings into a file, which will boost your application’s load speed, run
```
docker-compose exec app php artisan config:cache
```

### Step12
Creating a User for MySQL
```
docker-compose exec db bash
```
and then 
```
mysql -u root -p
```

on mysql command line to see all databases run
```
show databases;
```

Grant Permission to your user on specific database
```
GRANT ALL ON laravel.* TO 'laraveluser'@'%' IDENTIFIED BY 'your_laravel_db_password';
```

Flush the privileges to notify the MySQL server of the changes:
```
FLUSH PRIVILEGES;
```
and exit from mysql and container mysql

### Step13
You can Migrate your laravel with following command
```
docker-compose exec app php artisan migrate
```
