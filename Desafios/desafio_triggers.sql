-- Creación de la tabla LOG para purchase_fact
CREATE TABLE purchase_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(10),
    operation_timestamp DATETIME,
    user VARCHAR(100),
    purchase_id INT,
    details TEXT
);

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

-- Creación de la tabla LOG para customer_feedback_fact
CREATE TABLE feedback_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(10),
    operation_timestamp DATETIME,
    user VARCHAR(100),
    feedback_id INT,
    details TEXT
);

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
