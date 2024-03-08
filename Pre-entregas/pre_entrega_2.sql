-- Crear esquema para la base de datos
CREATE SCHEMA CRM;

USE CRM;

-- Crear tabla service_category_dim
CREATE TABLE service_category_dim (
  service_category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT NOT NULL
);

-- Crear tabla service_dim
CREATE TABLE service_dim (
  service_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  service_category_id INT NOT NULL,
  description TEXT NOT NULL,
  price INT NOT NULL,
  FOREIGN KEY (service_category_id) REFERENCES service_category_dim(service_category_id)
);

-- Crear tabla customer_dim
CREATE TABLE customer_dim (
  customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(20) UNIQUE DEFAULT 'Not available'
);

-- Crear tabla employee_dim
CREATE TABLE employee_dim (
  employee_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(20) UNIQUE DEFAULT 'Not available'
);

-- Crear tabla time_dim
CREATE TABLE time_dim (
  id_time_dim INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  date_time DATETIME NOT NULL,
  year INT NOT NULL,
  month INT NOT NULL,
  day INT NOT NULL,
  hour INT NOT NULL,
  minute INT NOT NULL,
  second INT NOT NULL
);

-- Crear tabla interaction_fact
CREATE TABLE interaction_fact (
  interaction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  employee_id INT NOT NULL,
  service_id INT NOT NULL,
  id_time_dim INT NOT NULL,
  type VARCHAR(255) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
  FOREIGN KEY (employee_id) REFERENCES employee_dim(employee_id),
  FOREIGN KEY (service_id) REFERENCES service_dim(service_id),
  FOREIGN KEY (id_time_dim) REFERENCES time_dim(id_time_dim)
);

-- Crear tabla purchase_fact
CREATE TABLE purchase_fact (
  purchase_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  date_time_purchase INT NOT NULL,
  total INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
  FOREIGN KEY (date_time_purchase) REFERENCES time_dim(id_time_dim)
);

-- Crear tabla purchase_detail_fact
CREATE TABLE purchase_detail_fact (
  id_purchase_detail INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  purchase_id INT NOT NULL,
  service_id INT NOT NULL,
  purchase_price INT NOT NULL,
  FOREIGN KEY (purchase_id) REFERENCES purchase_fact(purchase_id),
  FOREIGN KEY (service_id) REFERENCES service_dim(service_id)
);

-- Crear tabla customer_preferences_dim
CREATE TABLE customer_preferences_dim (
  preference_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  service_category_id INT NOT NULL,
  preferred_employee_id INT NOT NULL,
  notes TEXT DEFAULT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
  FOREIGN KEY (service_category_id) REFERENCES service_category_dim(service_category_id),
  FOREIGN KEY (preferred_employee_id) REFERENCES employee_dim(employee_id)
);

-- Crear tabla customer_feedback_fact
CREATE TABLE customer_feedback_fact (
  feedback_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  service_id INT NOT NULL,
  rating INT NOT NULL,
  comment TEXT,
  id_time_dim INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
  FOREIGN KEY (service_id) REFERENCES service_dim(service_id),
  FOREIGN KEY (id_time_dim) REFERENCES time_dim(id_time_dim)
);

-- Creación de la tabla LOG para purchase_fact
CREATE TABLE purchase_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(10),
    operation_timestamp DATETIME,
    user VARCHAR(100),
    purchase_id INT,
    details TEXT,
    FOREIGN KEY (purchase_id) REFERENCES purchase_fact(purchase_id)
);

-- Creación de la tabla LOG para customer_feedback_fact
CREATE TABLE feedback_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(10),
    operation_timestamp DATETIME,
    user VARCHAR(100),
    feedback_id INT,
    details TEXT,
    FOREIGN KEY (feedback_id) REFERENCES customer_feedback_fact(feedback_id)
);




-- SCRIPTS DE INSERCIONES




-- Inserciones para service_category_dim
INSERT INTO
  service_category_dim (category_name, description)
VALUES
  ('Software', 'Software related services'),
  ('Hardware', 'Hardware related services'),
  ('Consulting', 'Consulting services'),
  ('Support', 'Technical support services'),
  ('Development', 'Software development services'),
  ('Training', 'Training and education services'),
  ('Maintenance', 'Maintenance services'),
  ('Installation', 'Installation services'),
  ('Networking', 'Networking services'),
  ('Security', 'Security services');

-- Inserciones para customer_dim
INSERT INTO
  customer_dim (first_name, last_name, email, phone)
VALUES
  (
    'John',
    'Doe',
    'john.doe@example.com',
    '123-456-7890'
  ),
  (
    'Jane',
    'Smith',
    'jane.smith@example.com',
    '234-567-8901'
  ),
  (
    'Alice',
    'Johnson',
    'alice.johnson@example.com',
    '345-678-9012'
  ),
  (
    'Bob',
    'Williams',
    'bob.williams@example.com',
    '456-789-0123'
  ),
  (
    'Carol',
    'Brown',
    'carol.brown@example.com',
    '567-890-1234'
  ),
  (
    'David',
    'Jones',
    'david.jones@example.com',
    '678-901-2345'
  ),
  (
    'Eve',
    'Miller',
    'eve.miller@example.com',
    '789-012-3456'
  ),
  (
    'Frank',
    'Davis',
    'frank.davis@example.com',
    '890-123-4567'
  ),
  (
    'Grace',
    'Garcia',
    'grace.garcia@example.com',
    '901-234-5678'
  ),
  (
    'Henry',
    'Rodriguez',
    'henry.rodriguez@example.com',
    '012-345-6789'
  );

-- Inserciones para employee_dim
INSERT INTO
  employee_dim (first_name, last_name, role, email, phone)
VALUES
  (
    'Alice',
    'Smith',
    'Manager',
    'alice.smith@example.com',
    '555-111-2222'
  ),
  (
    'Bob',
    'Johnson',
    'Sales',
    'bob.johnson@example.com',
    '555-333-4444'
  ),
  (
    'Carol',
    'Williams',
    'Developer',
    'carol.williams@example.com',
    '555-666-7777'
  ),
  (
    'David',
    'Brown',
    'Support',
    'david.brown@example.com',
    '555-888-9999'
  ),
  (
    'Eve',
    'Jones',
    'HR',
    'eve.jones@example.com',
    '555-000-1111'
  ),
  (
    'Frank',
    'Miller',
    'Marketing',
    'frank.miller@example.com',
    '555-222-3333'
  ),
  (
    'Grace',
    'Davis',
    'Accounting',
    'grace.davis@example.com',
    '555-444-5555'
  ),
  (
    'Henry',
    'Garcia',
    'IT',
    'henry.garcia@example.com',
    '555-666-7778'
  ),
  (
    'Isaac',
    'Wilson',
    'Operations',
    'isaac.wilson@example.com',
    '555-888-9990'
  ),
  (
    'Jack',
    'Martinez',
    'Sales',
    'jack.martinez@example.com',
    '555-111-2220'
  );

-- Inserciones para time_dim
INSERT INTO
  time_dim (
    date_time,
    year,
    month,
    day,
    hour,
    minute,
    second
  )
VALUES
  ('2024-01-01 08:00:00', 2024, 1, 1, 8, 0, 0),
  ('2024-01-02 09:00:00', 2024, 1, 2, 9, 0, 0),
  ('2024-01-03 10:00:00', 2024, 1, 3, 10, 0, 0),
  ('2024-01-04 11:00:00', 2024, 1, 4, 11, 0, 0),
  ('2024-01-05 12:00:00', 2024, 1, 5, 12, 0, 0),
  ('2024-01-06 13:00:00', 2024, 1, 6, 13, 0, 0),
  ('2024-01-07 14:00:00', 2024, 1, 7, 14, 0, 0),
  ('2024-01-08 15:00:00', 2024, 1, 8, 15, 0, 0),
  ('2024-01-09 16:00:00', 2024, 1, 9, 16, 0, 0),
  ('2024-01-10 17:00:00', 2024, 1, 10, 17, 0, 0),
  ('2024-01-11 18:00:00', 2024, 1, 11, 18, 0, 0),
  ('2024-01-12 19:00:00', 2024, 1, 12, 19, 0, 0),
  ('2024-01-13 20:00:00', 2024, 1, 13, 20, 0, 0),
  ('2024-01-14 21:00:00', 2024, 1, 14, 21, 0, 0),
  ('2024-01-15 22:00:00', 2024, 1, 15, 22, 0, 0),
  ('2024-01-16 23:00:00', 2024, 1, 16, 23, 0, 0);

-- Inserciones para service_dim
INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (1, 'Basic software package', 100),
  (2, 'Advanced hardware setup', 200),
  (3, 'Standard consulting session', 150),
  (4, 'Premium support package', 250),
  (5, 'Custom software development', 300),
  (6, 'Professional training session', 180),
  (7, 'Regular maintenance', 120),
  (8, 'System installation', 220),
  (9, 'Network setup and configuration', 200),
  (10, 'Cybersecurity services', 300);

-- Inserciones para interaction_fact
INSERT INTO
  interaction_fact (
    customer_id,
    employee_id,
    service_id,
    id_time_dim,
    type
  )
VALUES
  (1, 1, 1, 1, 'Consulta'),
  (2, 2, 2, 2, 'Venta'),
  (3, 3, 3, 3, 'Soporte'),
  (4, 4, 4, 4, 'Consulta'),
  (5, 5, 5, 5, 'Venta'),
  (6, 6, 6, 6, 'Soporte'),
  (7, 7, 7, 7, 'Consulta'),
  (8, 8, 8, 8, 'Venta'),
  (9, 9, 9, 9, 'Soporte'),
  (10, 10, 10, 10, 'Consulta');

-- Inserciones para purchase_fact
INSERT INTO
  purchase_fact (customer_id, date_time_purchase, total)
VALUES
  (1, 1, 300),
  (2, 2, 450),
  (3, 3, 500),
  (4, 4, 600),
  (5, 5, 700),
  (6, 6, 800),
  (7, 7, 900),
  (8, 8, 1000),
  (9, 9, 1100),
  (10, 10, 1200);

-- Inserciones para purchase_detail_fact
INSERT INTO
  purchase_detail_fact (purchase_id, service_id, purchase_price)
VALUES
  (1, 1, 300),
  (2, 2, 450),
  (3, 3, 500),
  (4, 4, 300),
  (5, 5, 450),
  (6, 6, 500),
  (7, 7, 300),
  (8, 8, 450),
  (9, 9, 500),
  (10, 10, 300);

-- Inserciones para customer_preferences_dim
INSERT INTO
  customer_preferences_dim (
    customer_id,
    service_category_id,
    preferred_employee_id,
    notes
  )
VALUES
  (1, 1, 1, 'Prefiere atención rápida'),
  (2, 2, 2, 'Prefiere productos ecológicos'),
  (3, 3, 3, 'Le gusta la eficiencia'),
  (4, 4, 4, 'Prefiere atención personalizada'),
  (5, 5, 5, 'Busca ofertas'),
  (6, 6, 6, 'Interesado en nuevos productos'),
  (7, 7, 7, 'Prefiere servicios de alta calidad'),
  (8, 8, 8, 'Interesado en garantías extendidas'),
  (9, 9, 9, 'Prefiere un servicio rápido'),
  (10, 10, 10, 'Le gusta la asesoría detallada');

-- Inserciones para customer_feedback_fact
INSERT INTO
  customer_feedback_fact (
    customer_id,
    service_id,
    rating,
    comment,
    id_time_dim
  )
VALUES
  (1, 1, 5, 'Excelente servicio', 1),
  (2, 2, 4, 'Buen servicio, pero puede mejorar', 2),
  (3, 3, 3, 'Servicio promedio', 3),
  (4, 4, 2, 'No muy satisfecho con el servicio', 4),
  (5, 5, 1, 'Mala experiencia', 5),
  (6, 6, 5, 'Excepcional atención al cliente', 6),
  (
    7,
    7,
    4,
    'Buen desempeño, pero con margen de mejora',
    7
  ),
  (8, 8, 3, 'Satisfactorio', 8),
  (
    9,
    9,
    2,
    'Decepcionado con el tiempo de respuesta',
    9
  ),
  (10, 10, 1, 'Experiencia insatisfactoria', 10);



-- SCRIPTS DE VIEWS



-- Vista de Detalles de Clientes
CREATE VIEW CustomerDetails AS
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  cp.preference_id,
  cp.notes,
  cf.rating,
  cf.comment
FROM
  customer_dim c
  JOIN customer_preferences_dim cp ON c.customer_id = cp.customer_id
  JOIN customer_feedback_fact cf ON c.customer_id = cf.customer_id;

-- Vista de Interacciones por Empleado
CREATE VIEW EmployeeInteractions AS
SELECT
  e.employee_id,
  e.first_name,
  e.last_name,
  COUNT(`if`.interaction_id) AS interaction_count,
  `if`.type
FROM
  employee_dim e
  JOIN interaction_fact `if` ON e.employee_id = `if`.employee_id
GROUP BY
  e.employee_id,
  `if`.type;

-- Vista de Resumen de Ventas
CREATE VIEW SalesSummary AS
SELECT
  p.purchase_id,
  pd.service_id,
  s.description,
  pd.purchase_price
FROM
  purchase_fact p
  JOIN purchase_detail_fact pd ON p.purchase_id = pd.purchase_id
  JOIN service_dim s ON pd.service_id = s.service_id;

-- Vista de Servicios por Categoría
CREATE VIEW ServicesByCategory AS
SELECT
  sc.category_name,
  s.service_id,
  s.description,
  s.price
FROM
  service_dim s
  JOIN service_category_dim sc ON s.service_category_id = sc.service_category_id;

-- Vista de Feedback de Clientes
CREATE VIEW CustomerFeedback AS
SELECT
  cf.customer_id,
  c.first_name,
  c.last_name,
  cf.service_id,
  cf.rating,
  cf.comment
FROM
  customer_feedback_fact cf
  JOIN customer_dim c ON cf.customer_id = c.customer_id;



-- SCRIPTS DE FUNCTIONS



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



-- SCRIPTS DE STORED PROCEDURES



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



-- SCRIPTS DE TRIGGERS



-- Trigger BEFORE INSERT en purchase_fact
DELIMITER $$
CREATE TRIGGER before_purchase_insert
BEFORE INSERT ON purchase_fact
FOR EACH ROW
BEGIN
    INSERT INTO purchase_log(operation_type, operation_timestamp, user, purchase_id, details)
    VALUES ('INSERT', NOW(), CURRENT_USER(), NEW.purchase_id, 'Insert operation before insert on purchase_fact');
END$$
DELIMITER ;

-- Trigger AFTER UPDATE en purchase_fact
DELIMITER $$
CREATE TRIGGER after_purchase_update
AFTER UPDATE ON purchase_fact
FOR EACH ROW
BEGIN
    INSERT INTO purchase_log(operation_type, operation_timestamp, user, purchase_id, details)
    VALUES ('UPDATE', NOW(), CURRENT_USER(), NEW.purchase_id, 'Update operation after update on purchase_fact');
END$$
DELIMITER ;

-- Trigger BEFORE DELETE en customer_feedback_fact
DELIMITER $$
CREATE TRIGGER before_feedback_delete
BEFORE DELETE ON customer_feedback_fact
FOR EACH ROW
BEGIN
    INSERT INTO feedback_log(operation_type, operation_timestamp, user, feedback_id, details)
    VALUES ('DELETE', NOW(), CURRENT_USER(), OLD.feedback_id, 'Delete operation before delete on customer_feedback_fact');
END$$
DELIMITER ;

-- Trigger AFTER INSERT en customer_feedback_fact
DELIMITER $$
CREATE TRIGGER after_feedback_insert
AFTER INSERT ON customer_feedback_fact
FOR EACH ROW
BEGIN
    INSERT INTO feedback_log(operation_type, operation_timestamp, user, feedback_id, details)
    VALUES ('INSERT', NOW(), CURRENT_USER(), NEW.feedback_id, 'Insert operation after insert on customer_feedback_fact');
END$$
DELIMITER ;

