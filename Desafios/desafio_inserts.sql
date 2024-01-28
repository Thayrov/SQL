-- Inserciones para service_category_dim
USE CRM;

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