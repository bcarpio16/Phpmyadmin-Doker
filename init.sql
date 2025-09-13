-- Crear tabla portales
CREATE TABLE IF NOT EXISTS portales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    url VARCHAR(500) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insertar datos iniciales
INSERT INTO portales (nombre, url, estado, descripcion) VALUES
('Artes MDMQ PETRIC', 'https://ssomdmq.quito.gob.ec:4943/login', 'OK', 'Sistema de Artes MDMQ PETRIC'),
('CMI FRONT AMBIENTE', 'https://ssomdmq.quito.gob.ec:6450', 'OK', 'Frontal de CMI Ambiente'),
('AMBIENTE FRONT', 'https://ssomdmq.quito.gob.ec:7142', 'OK', 'Frontal de Ambiente'),
('AMBIENTE ADMINISTRACION FRONT', 'https://ssomdmq.quito.gob.ec:5354', 'OK', 'Frontal de Administración de Ambiente'),
('WEB MDMQ ORDENANZAS EXTERNO', 'https://ssomdmq.quito.gob.ec:5356', 'OK', 'Portal web externo de ordenanzas MDMQ'),
('WEB MDMQ ORDENANZAS INTERNO', 'https://ssomdmq.quito.gob.ec:9079', 'OK', 'Portal web interno de ordenanzas MDMQ'),
('MONITOREO PRTG', 'https://ssomdmq.quito.gob.ec:9076', 'OK', 'Sistema de monitoreo PRTG'),
('MOVILIDAD CIUDADANO', 'https://monitoreoprtg.quito.gob.ec', 'OK', 'Portal de movilidad para ciudadanos'),
('MOVILIDAD ADMINISTRACION', 'https://ssomdmq.quito.gob.ec:5391', 'OK', 'Portal administrativo de movilidad'),
('CODIGO MUNICIPAL FRONTEND', 'https://ssomdmq.quito.gob.ec:5393', 'OK', 'Frontend del código municipal'),
('CERTIFICACIONES ELECTRÓNICAS EXT', 'https://codigomunicipal.quito.gob.ec', 'OK', 'Sistema externo de certificaciones electrónicas'),
('CHAT BOT SERVICIOS CIUDADANOS', 'https://sisceqcore.quito.gob.ec', 'OK', 'Chatbot para servicios ciudadanos'),
('Sistema Integrado de Información del Comercio', 'https://chatbot.quito.gob.ec/welcome', 'OK', 'SIIC - Sistema integrado de comercio'),
('SIIC Reportes', 'https://siic.quito.gob.ec', 'OK', 'Sistema de reportes del SIIC');

-- Aplicar cambios de privilegios
FLUSH PRIVILEGES;
