#!/bin/bash
# Script: levantar_sistema_portales.sh
# Descripción: Crea red, volumen y levanta MySQL + phpMyAdmin en Docker

# Variables
NETWORK="Sistema_Portales_Red"
VOLUME="Sistema_Portales_Data"
MYSQL_CONTAINER="Sistema_Portales_Mysql"
PHPMYADMIN_CONTAINER="Sistema_Portales_phpMyAdmin"

# Crear red si no existe
if ! docker network ls | grep -q "$NETWORK"; then
  echo "Creando red: $NETWORK"
  docker network create $NETWORK
else
  echo "La red $NETWORK ya existe."
fi

# Crear volumen si no existe
if ! docker volume ls | grep -q "$VOLUME"; then
  echo "Creando volumen: $VOLUME"
  docker volume create $VOLUME
else
  echo "El volumen $VOLUME ya existe."
fi

# Levantar MySQL
echo "Levantando contenedor MySQL..."
docker run -d \
  --name $MYSQL_CONTAINER \
  --network $NETWORK \
  --env-file .env \
  -v $VOLUME:/var/lib/mysql \
  -v "$PWD"/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -p 3306:3306 \
  alpine/mysql:15.2

# Levantar phpMyAdmin
echo "Levantando contenedor phpMyAdmin..."
docker run -d \
  --name $PHPMYADMIN_CONTAINER \
  --network $NETWORK \
  --env-file .env \
  -e PMA_HOST=$MYSQL_CONTAINER \
  -p 8080:80 \
  bitnami/phpmyadmin:5.2.2

echo "✅ Sistema de Portales levantado con éxito."
echo "   - MySQL: localhost:3306"
echo "   - phpMyAdmin: http://localhost:8080"
