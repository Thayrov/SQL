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