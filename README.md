# 📦 Curso: Despliegue de Aplicaciones con Docker

## 📑 Proyecto
**Sistema de Portales con MariaDB y phpMyAdmin**

- **Profesor:** Ing. Edison Naranjo (CEC-EPN)  
- **Fecha:** 13 Septiembre 2025  

---

## 📚 Tabla de Contenidos
1. [Integrantes](#-integrantes---grupo-1-municipio-de-quito)  
2. [Clonado del Repositorio](#️-clonado-del-repositorio)  
3. [Archivos del Proyecto](#-archivos-del-proyecto)  
4. [Despliegue Manual](#-despliegue-manual)  
   - [1. Crear Red y Volumen](#1-crear-red-y-volumen)  
   - [2. Desplegar MariaDB](#2-desplegar-mariadb-con-base-de-datos-portaldb)  
   - [3. Desplegar phpMyAdmin](#3-desplegar-phpmyadmin)  
   - [4. Acceso vía Navegador](#4-acceso-vía-navegador)  


## 👨‍👩‍👦 Integrantes - Grupo 1 (Municipio de Quito)

- Carpio Zaquinaula Byron Orlando  
- Villarroel Vera Milton Orlando  
- Mena Segura Edison Fabián  
- Benavides Freire Alex Vicente  
- Gallardo Nicolalde Marcelo Iván  

---

## 🖥️ Clonado del Repositorio

```bash
pwd
/home/netadmin

git clone https://github.com/panivinux/Phpmyadmin-Doker.git

Salida esperada:
Clonando en 'Phpmyadmin-Doker'...
remote: Enumerating objects: 54, done.
remote: Counting objects: 100% (54/54), done.

📂 Archivos del Proyecto
Dentro de la carpeta clonada Phpmyadmin-Doker:
ls -la
Salida esperada:
total 32
drwxrwxr-x  3 netadmin netadmin 4096 sep 13 20:12 .
drwxr-x--- 37 netadmin netadmin 4096 sep 13 20:12 ..
-rw-rw-r--  1 netadmin netadmin 1270 sep 13 20:12 despliegue
-rw-rw-r--  1 netadmin netadmin  128 sep 13 20:12 .env
drwxrwxr-x  8 netadmin netadmin 4096 sep 13 20:12 .git
-rw-rw-r--  1 netadmin netadmin 2044 sep 13 20:12 init.sql
-rw-rw-r--  1 netadmin netadmin 2108 sep 13 20:12 levantar_sistema_portales.sh
-rw-rw-r--  1 netadmin netadmin  452 sep 13 20:12 README.md
🚀 Despliegue Manual

En el archivo despliegue se encuentran los comandos para crear la red, volumen y desplegar los contenedores MariaDB y phpMyAdmin.

1. Crear Red y Volumen
docker network create Sistema_Portales_Red
docker volume create Sistema_Portales_Data
Verificar:
docker network ls
docker volume ls

2. Desplegar MariaDB (con base de datos portaldb)
docker run -d \
  --name Sistema_Portales_Mysql \
  --network Sistema_Portales_Red \
  --env-file .env \
  -v Sistema_Portales_Data:/var/lib/mysql \
  -v "$PWD"/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -p 3306:3306 \
  mariadb:10.11

Verificar que el contenedor está en ejecución:
docker ps
3. Desplegar phpMyAdmin
docker run -d \
  --name Sistema_Portales_phpMyAdmin \
  --network Sistema_Portales_Red \
  -e PMA_HOST=Sistema_Portales_Mysql \
  -p 8080:80 \
  phpmyadmin:5.1.3
4. Acceso vía Navegador
http://localhost:8080
Credenciales de acceso:

Usuario: portaluser

Contraseña: portalpass









