#!/bin/bash
docker run  --name demo-pg-13.3 -p 5432:5432 -e POSTGRES_USER=test_sde -e POSTGRES_PASSWORD=@sde_password012 -e POSTGRES_DB=demo -d -v "$(pwd)":/docker-entrypoint-initdb.d postgres:13.3
