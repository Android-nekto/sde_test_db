#!/bin/bash

# Скачиваем Docker образ PostgreSQL. Не нужно, т.к. скачает, если не найдет локально.
sudo docker pull postgres:latest

# Путь к репозиторию определяю как переменную
path=`realpath sde_test_db*`
echo $path

# Запускаем контейнер PostgreSQL. Можно без указания пути -v echo $path:echo $path
sudo docker run --name  postgres-container -e POSTGRES_PASSWORD="@sde_password012" -e POSTGRES_USER="test_sde" -e POSTGRES_DB="demo" -v echo $path:echo $path -p 5432:5432 -d postgres

# Выводим информацию о базе данных в контейнере PostgreSQL
sudo docker exec postgres-container psql -U test_sde -d demo -c "SELECT * FROM pg_database"

# Путь к запускаемому файлу определяю как переменную. Копируем файл для заполнения БД в контейнер (так как при каждом запуске папка очищается)
pathsql=`find $(pwd) -name demo.sql` && echo $pathsql  && sudo docker cp echo $pathsql postgres-container:/var/lib/postgresql/data/

# Даем время на внесение изменений
sleep 5

#  Запускаем скрипт для заполнения БД
sudo docker exec postgres-container psql -U test_sde -d demo -f //var/lib/postgresql/data/demo.sql

# Выводим сообщение об успешном завершении скрипта
echo "Инициализация БД прошла успешна."