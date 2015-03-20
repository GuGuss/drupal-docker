# ralt/drupal

Creates a Drupal environment. DB not provided.

See [here](example/) for a usage example.

Typical workflow:

```
$ mkdir new-project
$ cd new-project/
$ echo "FROM ralt/drupal" > Dockerfile
$ cat > docker-compose.yml << EOF
web:
  build: .
  ports:
    - "8000:80"
  links:
    - db
  volumes:
    - .:/var/www/html

db:
  image: "mariadb"
  environment:
    MYSQL_ROOT_PASSWORD: root
    MYSQL_USER: drupal
    MYSQL_PASSWORD: password
    MYSQL_DATABASE: drupal
  volumes:
    - /var/lib/mysql
EOF
```

Then simply run:

```
$ sudo docker-compose up -d
```

And going to `http://localhost:8000` should give you a Drupal installation.

Some variables should be available to let you connect to mariadb. Here is a sample settings.php:

```php
$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => getenv('DB_1_ENV_MYSQL_DATABASE'),
  'username' => getenv('DB_1_ENV_MYSQL_USER'),
  'password' => getenv('DB_1_ENV_MYSQL_PASSWORD'),
  'host' => getenv('DB_1_PORT_3306_TCP_ADDR'),
  'prefix' => '',
);
```
