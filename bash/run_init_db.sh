#!/bin/bash

# Запускаем контейнер PostgreSQL. Можно без указания пути -v echo $path:echo $path
docker run --name sde-pg -p 5432:5432 --rm -e POSTGRES_USER=test_sde -e POSTGRES_PASSWORD=@sde_password012 -e POSTGRES_DB=demo -e PGDATA=/var/lib/postgresql/data/pgdata -v /Users/AGNikolaev/Desktop/learning/sde_test_db/sql:/var/lib/postgresql/data -d postgres

# Даем время на внесение изменений
sleep 20

#  Запускаем скрипт для заполнения БД
docker exec sde-pg psql -U test_sde -d demo -f /var/lib/postgresql/data/init_db/demo.sql

# Выводим сообщение об успешном завершении скрипта
echo "Инициализация БД прошла успешна."

