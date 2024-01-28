USE CRM;

-- Función para calcular el total de ventas de un cliente
DELIMITER //

CREATE FUNCTION TotalVentasCliente(customerID INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalVentas INT DEFAULT 0;
    SELECT SUM(total) INTO totalVentas FROM purchase_fact WHERE customer_id = customerID;
    RETURN totalVentas;
END //

DELIMITER ;
-- Ejemplo de uso: SELECT TotalVentasCliente(1);



-- Función para obtener la cantidad de interacciones por tipo
DELIMITER //

CREATE FUNCTION CantidadInteraccionesPorTipo(interactionType VARCHAR(255)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE totalInteracciones INT DEFAULT 0;
    SELECT COUNT(*) INTO totalInteracciones FROM interaction_fact WHERE type = interactionType;
    RETURN totalInteracciones;
END //

DELIMITER ;
-- Ejemplo de uso: SELECT CantidadInteraccionesPorTipo('Consulta');
