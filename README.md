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
cp mysql/.my.cnf.example mysql/my.cnf
```


### Step6
Create your laravel-app directory and clone your developer repository with following command
```
git clone <Repo_URL> laravel-app
```

### Step7
Install composer.notice that developers code should have composer.json
```
cd laravel-app;docker run --rm -v $(pwd):/app composer install;cd ..
```
if you have local repo run following command
```
cd laravel-app;docker run --rm -v $(pwd):/app YOUR_PRIVATE_REGISTRY_URL/composer install -vvv;cd ..
```

### Step8 (Optional)
Change your docker images with your local repository if you needed.

### Step9
change environment variable for laravel with following configuration
```
cp laravel-app/.env.example laravel-app/.env
```

Change Following Configuration on laravel-app/.env
```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laraveluser
DB_PASSWORD=your_laravel_db_password
```

### Step10
change permission for lumen project to access on it
```
sudo chown -R $USER:$USER laravel-app/
```

### Step11
Set hostname for php app on docker-compose file if you needed.

### Step12
Configure SSH Access to PHP Application for Developers
1. Change SSH port to your own random port in docker-compose
2. Copy example ssh configuration file and change it base on yourself
```
cp ssh_accounts/.sshd_config.example ssh_accounts/sshd_config;cp ssh_accounts/.authorized_keys.example ssh_accounts/authorized_keys
```
3. Input developer ssh public key at the end of ssh_accounts/authorized_keys with specific comment for example name and family

### Step13
run docker compose command
```
docker-compose up -d --build
```

### Step14
Create your laravel application key with command
```
docker-compose exec app php artisan key:generate
```

### Step15
To cache these settings into a file, which will boost your application’s load speed, run
```
docker-compose exec app php artisan config:cache
```

### Step16
Restart ssh service for php app
```
docker-compose exec -u root app service ssh restart
```

### Step17
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

### Step18
You can Migrate your laravel with following command
```
docker-compose exec app php artisan migrate
```
