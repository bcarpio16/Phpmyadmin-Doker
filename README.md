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

---

## 👨‍👩‍👦 Integrantes - Grupo 1 (Municipio de Quito)

- Carpio Zaquinaula Byron Orlando  
- Villarroel Vera Milton Orlando  
- Mena Segura Edison Fabián  
- Benavides Freire Alex Vicente  
- Gallardo Nicolalde Marcelo Iván  

---

## 🖥️ Clonado del Repositorio de cualquiera de las 5 cuentas de github

```
pwd
/home/netadmin
```

- Carpio Zaquinaula Byron Orlando
```  
git clone https://github.com/bcarpio16/Phpmyadmin-Doker.git
```
- Villarroel Vera Milton Orlando
```
git clone https://github.com/movillarroel/Phpmyadmin-Doker.git
```
- Mena Segura Edison Fabián
```
git clone https://github.com/panivinux/Phpmyadmin-Doker.git
```
- Benavides Freire Alex Vicente
```
https://github.com/abenavides86/Phpmyadmin-Doker.git
```
- Gallardo Nicolalde Marcelo Iván  
```
git clone https://github.com/panivinux/Phpmyadmin-Doker.git
```

Salida esperada:

Clonando en 'Phpmyadmin-Doker'...
remote: Enumerating objects: 54, done.
remote: Counting objects: 100% (54/54), done.

📂 Archivos del Proyecto

sistema-portales/
│── despliegue 
│── .env
│── init.sql
│── levantar_sistema_portales.sh
│── README.md

🚀 Despliegue Manual

En el archivo despliegue se encuentran los comandos para crear la red, volumen y desplegar los contenedores MariaDB y phpMyAdmin.
1. Crear Red y Volumen
```
docker network create Sistema_Portales_Red
```
```
docker volume create Sistema_Portales_Data
```
Verificar:
```
docker network ls
```
```
docker volume ls
```
2. Desplegar MariaDB (con base de datos portaldb)
```
docker run -d \
  --name Sistema_Portales_Mysql \
  --network Sistema_Portales_Red \
  --env-file .env \
  -v Sistema_Portales_Data:/var/lib/mysql \
  -v "$PWD"/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -p 3306:3306 \
  mariadb:10.11
```
Verificar que el contenedor está en ejecución:
```
docker ps
```
3. Desplegar phpMyAdmin
```
docker run -d \
  --name Sistema_Portales_phpMyAdmin \
  --network Sistema_Portales_Red \
  -e PMA_HOST=Sistema_Portales_Mysql \
  -p 8080:80 \
  phpmyadmin:5.1.3
```
4. Acceso vía Navegador

Abrir en el navegador:

http://localhost:8080

Credenciales de acceso:

    Usuario: portaluser

    Contraseña: portalpass

🚀 Despliegue mediante el script levantar_sistema_portales.sh

```
bash levantar_sistema_portales.sh 
```

Resultrado esperado 

```
Creando red: Sistema_Portales_Red
ea837363cf4ccf04123720a7500ad766c33866e01075d36868496190cfadaa51
Creando volumen: Sistema_Portales_Data
Sistema_Portales_Data
Levantando contenedor MariaDB...
Digest: sha256:e4ad7c5ad8874c2b049cef7566ccf534856b9fcde1c3c89c3251e8fa6fd6915c
Status: Downloaded newer image for mariadb:10.11
eeed5a3778baf4654a9417245ba447000bb08b09abe02d5108a7e5b07f25a866

Levantando contenedor phpMyAdmin...
Digest: sha256:cfeae858a1689af32024fa5f797bfeb6eadb79a94fed71aa90265788224b7303
Status: Downloaded newer image for phpmyadmin:5.1.3
6c75967a920a07448b40d6cc82cc8f5ad233139f3d51ff73502f835c77c94a73

[OK] Sistema levantado correctamente.
----------------------------------------
Base de datos: portaldb
Usuario: portaluser
Contraseña: portalpass
MariaDB: localhost:3306
phpMyAdmin: http://localhost:8080
----------------------------------------
```




