-- Crear usuario con permisos de solo lectura
CREATE USER 'usuario_lectura'@'localhost' IDENTIFIED BY 'password';
-- Crear usuario con permisos de lectura, inserción y modificación
CREATE USER 'usuario_modificacion'@'localhost' IDENTIFIED BY 'password';

-- Asignar permisos de solo lectura al usuario 'usuario_lectura' para todas las tablas
GRANT SELECT ON CRM.* TO 'usuario_lectura'@'localhost';

-- Asignar permisos de lectura, inserción y actualización al usuario 'usuario_modificacion' para todas las tablas
GRANT SELECT, INSERT, UPDATE ON CRM.* TO 'usuario_modificacion'@'localhost';

-- Nota: No se otorgan permisos de DELETE para cumplir con la consigna de que ninguno pueda eliminar registros.

FLUSH PRIVILEGES;
