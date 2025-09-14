📦 Curso: Despliegue de Aplicaciones con Docker - Sistema de Portales
📑 Información del Proyecto

Profesor: Ing. Edison Naranjo (CEC-EPN)
Fecha: 13 Septiembre 2025
👥 Integrantes - Grupo 1 (Municipio de Quito)

    Carpio Zaquinaula Byron Orlando

    Villarroel Vera Milton Orlando

    Mena Segura Edison Fabián

    Benavides Freire Alex Vicente

    Gallardo Nicolalde Marcelo Iván

🚀 Script Completo de Despliegue
bash

#!/bin/bash

# 📦 Curso: Despliegue de Aplicaciones con Docker
# 📋 Sistema de Portales con MariaDB y phpMyAdmin

echo "🚀 Iniciando despliegue del Sistema de Portales..."
echo "📅 Fecha: $(date)"
echo "----------------------------------------"

# Verificar directorio actual
echo "📂 Directorio actual:"
pwd

# Clonar el repositorio
echo "🔽 Clonando repositorio..."
git clone https://github.com/panivinux/Phpmyadmin-Doker.git

# Navegar al directorio del proyecto
cd Phpmyadmin-Doker

# Listar archivos del proyecto
echo "📋 Archivos del proyecto:"
ls -la

# Crear red Docker
echo "🌐 Creando red Docker..."
docker network create Sistema_Portales_Red

# Crear volumen para persistencia de datos
echo "💾 Creando volumen de datos..."
docker volume create Sistema_Portales_Data

# Verificar creación
echo "🔍 Verificando red y volumen creados:"
docker network ls | grep Sistema_Portales_Red
docker volume ls | grep Sistema_Portales_Data

# Desplegar MariaDB
echo "🐬 Desplegando MariaDB..."
docker run -d \
  --name Sistema_Portales_Mysql \
  --network Sistema_Portales_Red \
  --env-file .env \
  -v Sistema_Portales_Data:/var/lib/mysql \
  -v "$PWD"/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -p 3306:3306 \
  mariadb:10.11

# Esperar a que MariaDB se inicie completamente
echo "⏳ Esperando inicialización de MariaDB..."
sleep 10

# Verificar contenedor MariaDB
echo "🔍 Verificando estado de MariaDB:"
docker ps | grep Sistema_Portales_Mysql

# Desplegar phpMyAdmin
echo "🌐 Desplegando phpMyAdmin..."
docker run -d \
  --name Sistema_Portales_phpMyAdmin \
  --network Sistema_Portales_Red \
  -e PMA_HOST=Sistema_Portales_Mysql \
  -p 8080:80 \
  phpmyadmin:5.1.3

# Verificar contenedores
echo "🔍 Verificando estado de todos los contenedores:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Mostrar información de acceso
echo "----------------------------------------"
echo "🎉 ¡Despliegue completado!"
echo "----------------------------------------"
echo "📊 ACCESO AL SISTEMA:"
echo "URL: http://localhost:8080"
echo "Usuario: portaluser"
echo "Contraseña: portalpass"
echo "----------------------------------------"
echo "📊 PUERTOS:"
echo "MySQL: 3306"
echo "phpMyAdmin: 8080"
echo "----------------------------------------"

# Verificar logs iniciales
echo "📝 Logs iniciales de MariaDB:"
docker logs Sistema_Portales_Mysql | tail -10

echo "📝 Logs iniciales de phpMyAdmin:"
docker logs Sistema_Portales_phpMyAdmin | tail -5

echo "✅ Script de despliegue finalizado."

📋 Comandos Adicionales de Verificación y Gestión
bash

# Verificar estado detallado de los contenedores
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Ver logs en tiempo real
docker logs -f Sistema_Portales_Mysql
docker logs -f Sistema_Portales_phpMyAdmin

# Acceder a la consola de MariaDB
docker exec -it Sistema_Portales_Mysql mysql -u portaluser -pportalpass portaldb

# Detener contenedores
docker stop Sistema_Portales_Mysql Sistema_Portales_phpMyAdmin

# Iniciar contenedores detenidos
docker start Sistema_Portales_Mysql Sistema_Portales_phpMyAdmin

# Eliminar contenedores
docker rm Sistema_Portales_Mysql Sistema_Portales_phpMyAdmin

# Eliminar red y volumen (¡CUIDADO: elimina todos los datos!)
docker network rm Sistema_Portales_Red
docker volume rm Sistema_Portales_Data

📝 Estructura del Proyecto
text

Phpmyadmin-Doker/
├── despliegue          # Script de despliegue
├── .env               # Variables de entorno (usuario: portaluser, contraseña: portalpass)
├── init.sql           # Script de inicialización de la base de datos
├── levantar_sistema_portales.sh  # Script de inicio
└── README.md          # Documentación

🔧 Solución de Problemas Comunes
bash

# Si el puerto 8080 está en uso, cambiar por otro puerto:
# Editar el script cambiando -p 8080:80 por -p 8081:80 o otro puerto disponible

# Si los contenedores no se inician correctamente:
docker logs Sistema_Portales_Mysql  # Ver errores de MariaDB
docker logs Sistema_Portales_phpMyAdmin  # Ver errores de phpMyAdmin

# Si hay problemas de conexión entre contenedores:
docker network inspect Sistema_Portales_Red

¡Sistema desplegado exitosamente! 🎉
