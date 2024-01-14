USE CRM;

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