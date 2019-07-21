# Подготовка проекта

## Разделение конфигураций приложения

При необходимости создаём копированием второй (локальный) файл конфигурации `application-dev.properties`

В настройках лончера IDE (IntelliJ IDEA) указываем аргумент запуска приложения (Program arguments): `--spring.profiles.active=dev`

Настраиваем боевой файл конфигурации.

Удостовериться, что в файлах конфигурации присутствует параметр `hostname`, так как будут разные сервера исполнения. При необходимости поправить url в коде.

# Подготовка сервера

## Предварительные настройки сервера

**(debian 10 buster)**

### Добавляем пользователя в sudo

Под root:

```shell
$ nano /etc/group
```

Ищем сроку `sudo:some:things`, вконце строки вписываем себя: `sudo:some:things:user_name`

### Настройка репозиториев сервера

```shell
$ sudo nano /etc/apt/sources.list
```

Добавить при необходмости:

```
deb http://deb.debian.org/debian buster main
deb-src http://deb.debian.org/debian buster main

deb http://deb.debian.org/debian buster-updates main
deb-src http://deb.debian.org/debian buster-updates main
```

Выполнить:

```shell
$ apt-get update
```

## Установка на сервере ssh-server

```shell
$ apt-get install -y openssh-server
```

## Сертификат для ssh-авторизации без ввода пароля

**На ssh-клиенте**

Используем bash. Для Windows bash можно получить, установив Git.

```powershell
> bash --login
```

```shell
$ ssh-keygen.exe
```

На вопросы утвердительно отвечаем (можно по умолчанию).

Смотрим сертификат:

```shell
$ cat ~/.ssh/id_rsa.pub
```

Копируем сертификат на ssh-сервер (Linux):

```shell
$ scp ~/.ssh/id_rsa.pub user_name@<ip>:/home/user_name/
```

**На сервере**

Перемещаем файл в каталог .ssh с переименовыванием:

```shell
user_name@machine:~$ mkdir .ssh
user_name@machine:~$ cd .ssh
user_name@machine:~/.ssh$ mv ~/id_rsa.pub ./authorized_keys
```

## Установка и настройка ПО на севере

Ставим nginx, PostgreSQL и JDK

```shell
$ sudo apt-get install -y nginx postgresql default-jdk
```

### Настройка пользователя postgres

```shell
$ sudo -u postgres psql
```

```sql
alter user postgres with password 'pass';
```

### Создаём БД

```sql
create database sweater;
```

### Настройка nginx

```shell
$ sudo nano /etc/nginx/sites-enabled/default
```

```nginx
location / {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://localhost:8080;
}

location /img/ {
    alias /home/user_name/uploads/;
}
```

Сигнал для nginx перечитать конфиг:

```shell
$ sudo nginx -s reload
```

Создаём директорию uploads в каталоге пользователя:

```shell
$ mkdir uploads
```

# Выполнение deploy

```shell
$ ./scripts/deploy.sh
```