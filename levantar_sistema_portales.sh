#!/bin/bash
# Script completo para levantar MariaDB + phpMyAdmin con portadb
################################################################
#CURSO: DESPLIEGUE DE APLICACIONES CON DOCKER
#SISTEMA DE PORTALES MARIADB Y PHPMYYADMIN
#PROFESOR: Ing. Edison Naranjo CEC-EPN
#FECHA: 13 Septiembre 2025
################################################################
#INTEGRANTES GRUPO 1 MUNICIPIO DE QUITO
#BYRON CARPIO
#MILTON VILLAROEL
#EDISON MENA
#ALEX BENAVIDES
#MARCELO GALLARDO
#################################################################

# Variables
NETWORK="Sistema_Portales_Red"
VOLUME="Sistema_Portales_Data"
MYSQL_CONTAINER="Sistema_Portales_Mysql"
PHPMYADMIN_CONTAINER="Sistema_Portales_phpMyAdmin"
MYSQL_IMAGE="mariadb:10.11"
PHPMYADMIN_IMAGE="phpmyadmin:5.1.3"
MYSQL_PORT=3306
PHPMYADMIN_PORT=8080

# Credenciales solo para imprimir, pero toma del archivo .env
DB_USER="portaluser"
DB_PASS="portalpass"
DB_NAME="portaldb"

# Colores
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

#Crea RED
  echo "Creando red: $NETWORK"
  docker network create $NETWORK

#Crea Volumen
  echo "Creando volumen: $VOLUME"
  docker volume create $VOLUME

# Levantar MariaDB
echo "Levantando contenedor MariaDB..."
docker run -d \
  --name $MYSQL_CONTAINER \
  --network $NETWORK \
  --env-file .env \
  -v $VOLUME:/var/lib/mysql \
  -v "$PWD"/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -p ${MYSQL_PORT}:3306 \
  $MYSQL_IMAGE

# Levantar phpMyAdmin
echo "Levantando contenedor phpMyAdmin..."
docker run -d \
  --name $PHPMYADMIN_CONTAINER \
  --network $NETWORK \
  -e PMA_HOST=$MYSQL_CONTAINER \
  -p ${PHPMYADMIN_PORT}:80 \
  $PHPMYADMIN_IMAGE

# Imprimir información de acceso
echo -e "${GREEN}[OK]${NC} Sistema levantado correctamente."
echo "----------------------------------------"
echo "Base de datos: ${DB_NAME}"
echo "Usuario: ${DB_USER}"
echo "Contraseña: ${DB_PASS}"
echo "MariaDB: localhost:${MYSQL_PORT}"
echo "phpMyAdmin: http://localhost:${PHPMYADMIN_PORT}"
echo "----------------------------------------"

