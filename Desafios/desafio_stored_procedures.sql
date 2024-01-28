USE CRM;

-- Stored Procedure para Ordenar Datos de una Tabla
DELIMITER //

CREATE PROCEDURE OrdenarTabla(IN tablaNombre VARCHAR(255), IN campoOrdenamiento VARCHAR(255), IN ordenDescAsc VARCHAR(4))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tablaNombre, ' ORDER BY ', campoOrdenamiento, ' ', ordenDescAsc);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;
-- Ejemplo de uso: CALL OrdenarTabla('customer_dim', 'customer_id', 'ASC');


-- Stored Procedure para Insertar o Eliminar Registro en customer_dim
DELIMITER //

CREATE PROCEDURE InsertarEliminarCliente(IN accion VARCHAR(10), IN customerID INT, IN firstName VARCHAR(255), IN lastName VARCHAR(255), IN email VARCHAR(255), IN phone VARCHAR(20))
BEGIN
    IF accion = 'INSERTAR' THEN
        INSERT INTO customer_dim (first_name, last_name, email, phone) VALUES (firstName, lastName, email, phone);
    ELSEIF accion = 'ELIMINAR' THEN
        DELETE FROM customer_dim WHERE customer_id = customerID;
    END IF;
END //

DELIMITER ;
-- Ejemplo de uso para insertar: CALL InsertarEliminarCliente('INSERTAR', NULL, 'Juan', 'Pérez', 'juan.perez@example.com', '123-456-7890');
-- Ejemplo de uso para eliminar: CALL InsertarEliminarCliente('ELIMINAR', 1, NULL, NULL, NULL, NULL);
