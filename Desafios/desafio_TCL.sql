USE CRM;

-- Transacción para la tabla `employee_dim`
START TRANSACTION;

-- Si queremos eliminar el empleado con employee_id = 1
-- Primero, actualizamos los registros en interaction_fact y customer_preferences_dim para no referenciar a este empleado
UPDATE interaction_fact
SET employee_id = (SELECT employee_id FROM employee_dim WHERE employee_id <> 1 LIMIT 1)
WHERE employee_id = 1;

UPDATE customer_preferences_dim
SET preferred_employee_id = (SELECT employee_id FROM employee_dim WHERE employee_id <> 1 LIMIT 1)
WHERE preferred_employee_id = 1;

-- Script para eliminar el registro del empleado
DELETE FROM employee_dim WHERE employee_id = 1;

-- Rollback comentado
-- ROLLBACK;

-- Commit, para aplicar los cambios
COMMIT;

-- Sentencia para re-insertar registro eliminado
-- INSERT INTO employee_dim (employee_id, first_name, last_name, role, email, phone) VALUES (1, 'Alice', 'Smith', 'Manager', 'alice.smith@example.com', '555-111-2222');





-- Transacción para la tabla `service_dim`
START TRANSACTION;

-- Insertar nuevas categorías de servicio primero
INSERT INTO service_category_dim (service_category_id, category_name, description)
VALUES
  (11, 'Cloud Services', 'Services related to cloud computing'),
  (12, 'Data Analytics', 'Data analysis and consulting services'),
  (13, 'CRM Solutions', 'Custom CRM software and solutions'),
  (14, 'IT Security', 'IT security assessment and solutions'),
  (15, 'App Development', 'Mobile application development services'),
  (16, 'E-commerce Solutions', 'E-commerce platform setup and management'),
  (17, 'VR Training', 'Virtual reality based training solutions'),
  (18, 'Blockchain', 'Blockchain consulting and development services');

-- Inserta 8 nuevos registros en `service_dim`
INSERT INTO 
  service_dim (service_category_id, description, price)
VALUES
  (11, 'Cloud Storage Service', 100);

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (12, 'Data Analytics Consulting', 200);

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (13, 'Custom CRM Solutions', 300);

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (14, 'IT Security Assessment', 150);

-- Primer savepoint después del 4to registro
SAVEPOINT after_four_inserts;

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (15, 'Mobile App Development', 350);

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (16, 'E-commerce Platform Setup', 250);

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (17, 'Virtual Reality Training', 400);

INSERT INTO
  service_dim (service_category_id, description, price)
VALUES
  (18, 'Blockchain Consulting Service', 500);

-- Segundo savepoint después del 8vo registro
SAVEPOINT after_eight_inserts;

-- Eliminar el savepoint de los primeros 4 registros si es necesario
-- ROLLBACK TO after_four_inserts;

-- Confirmar los cambios realizados en la transacción
COMMIT;
