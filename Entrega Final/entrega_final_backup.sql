-- Backup de Datos para la base de datos CRM
-- Tablas incluidas: customer_dim, customer_feedback_fact, customer_preferences_dim, employee_dim, feedback_log, interaction_fact, purchase_detail_fact, purchase_fact, purchase_log, service_category_dim, service_dim, time_dim
-- Comando utilizado: "mysqldump -u root -p --no-create-info CRM > desafio_backup.sql"


-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: CRM
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `customer_dim`
--

LOCK TABLES `customer_dim` WRITE;
/*!40000 ALTER TABLE `customer_dim` DISABLE KEYS */;
INSERT INTO `customer_dim` VALUES (1,'John','Doe','john.doe@example.com','123-456-7890'),(2,'Jane','Smith','jane.smith@example.com','234-567-8901'),(3,'Alice','Johnson','alice.johnson@example.com','345-678-9012'),(4,'Bob','Williams','bob.williams@example.com','456-789-0123'),(5,'Carol','Brown','carol.brown@example.com','567-890-1234'),(6,'David','Jones','david.jones@example.com','678-901-2345'),(7,'Eve','Miller','eve.miller@example.com','789-012-3456'),(8,'Frank','Davis','frank.davis@example.com','890-123-4567'),(9,'Grace','Garcia','grace.garcia@example.com','901-234-5678'),(10,'Henry','Rodriguez','henry.rodriguez@example.com','012-345-6789');
/*!40000 ALTER TABLE `customer_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customer_feedback_fact`
--

LOCK TABLES `customer_feedback_fact` WRITE;
/*!40000 ALTER TABLE `customer_feedback_fact` DISABLE KEYS */;
INSERT INTO `customer_feedback_fact` VALUES (1,1,1,5,'Excelente servicio',1),(2,2,2,4,'Buen servicio, pero puede mejorar',2),(3,3,3,3,'Servicio promedio',3),(4,4,4,2,'No muy satisfecho con el servicio',4),(5,5,5,1,'Mala experiencia',5),(6,6,6,5,'Excepcional atención al cliente',6),(7,7,7,4,'Buen desempeño, pero con margen de mejora',7),(8,8,8,3,'Satisfactorio',8),(9,9,9,2,'Decepcionado con el tiempo de respuesta',9),(10,10,10,1,'Experiencia insatisfactoria',10);
/*!40000 ALTER TABLE `customer_feedback_fact` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_feedback_insert` AFTER INSERT ON `customer_feedback_fact` FOR EACH ROW BEGIN
    INSERT INTO feedback_log(operation_type, operation_timestamp, user, feedback_id, details)
    VALUES ('INSERT', NOW(), CURRENT_USER(), NEW.feedback_id, 'Insert operation after insert on customer_feedback_fact');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_feedback_delete` BEFORE DELETE ON `customer_feedback_fact` FOR EACH ROW BEGIN
    INSERT INTO feedback_log(operation_type, operation_timestamp, user, feedback_id, details)
    VALUES ('DELETE', NOW(), CURRENT_USER(), OLD.feedback_id, 'Delete operation before delete on customer_feedback_fact');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `customer_preferences_dim`
--

LOCK TABLES `customer_preferences_dim` WRITE;
/*!40000 ALTER TABLE `customer_preferences_dim` DISABLE KEYS */;
INSERT INTO `customer_preferences_dim` VALUES (1,1,3,5,'Prefiere atención rápida'),(2,2,3,2,'Prefiere productos ecológicos'),(3,3,3,3,'Le gusta la eficiencia'),(4,4,4,4,'Prefiere atención personalizada'),(5,5,5,5,'Busca ofertas'),(6,6,6,6,'Interesado en nuevos productos'),(7,7,7,7,'Prefiere servicios de alta calidad'),(8,8,8,8,'Interesado en garantías extendidas'),(9,9,9,9,'Prefiere un servicio rápido'),(10,10,10,10,'Le gusta la asesoría detallada');
/*!40000 ALTER TABLE `customer_preferences_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `employee_dim`
--

LOCK TABLES `employee_dim` WRITE;
/*!40000 ALTER TABLE `employee_dim` DISABLE KEYS */;
INSERT INTO `employee_dim` VALUES (1,'Alice','Smith','Manager','alice.smith@example.com','555-111-2222'),(2,'Bob','Johnson','Sales','bob.johnson@example.com','555-333-4444'),(3,'Carol','Williams','Developer','carol.williams@example.com','555-666-7777'),(4,'David','Brown','Support','david.brown@example.com','555-888-9999'),(5,'Eve','Jones','HR','eve.jones@example.com','555-000-1111'),(6,'Frank','Miller','Marketing','frank.miller@example.com','555-222-3333'),(7,'Grace','Davis','Accounting','grace.davis@example.com','555-444-5555'),(8,'Henry','Garcia','IT','henry.garcia@example.com','555-666-7778'),(9,'Isaac','Wilson','Operations','isaac.wilson@example.com','555-888-9990'),(10,'Jack','Martinez','Sales','jack.martinez@example.com','555-111-2220');
/*!40000 ALTER TABLE `employee_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `feedback_log`
--

LOCK TABLES `feedback_log` WRITE;
/*!40000 ALTER TABLE `feedback_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `interaction_fact`
--

LOCK TABLES `interaction_fact` WRITE;
/*!40000 ALTER TABLE `interaction_fact` DISABLE KEYS */;
INSERT INTO `interaction_fact` VALUES (1,1,5,1,1,'Consulta'),(2,2,2,2,2,'Venta'),(3,3,3,3,3,'Soporte'),(4,4,4,4,4,'Consulta'),(5,5,5,5,5,'Venta'),(6,6,6,6,6,'Soporte'),(7,7,7,7,7,'Consulta'),(8,8,8,8,8,'Venta'),(9,9,9,9,9,'Soporte'),(10,10,10,10,10,'Consulta');
/*!40000 ALTER TABLE `interaction_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchase_detail_fact`
--

LOCK TABLES `purchase_detail_fact` WRITE;
/*!40000 ALTER TABLE `purchase_detail_fact` DISABLE KEYS */;
INSERT INTO `purchase_detail_fact` VALUES (1,1,1,300),(2,2,2,450),(3,3,3,500),(4,4,4,300),(5,5,5,450),(6,6,6,500),(7,7,7,300),(8,8,8,450),(9,9,9,500),(10,10,10,300);
/*!40000 ALTER TABLE `purchase_detail_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchase_fact`
--

LOCK TABLES `purchase_fact` WRITE;
/*!40000 ALTER TABLE `purchase_fact` DISABLE KEYS */;
INSERT INTO `purchase_fact` VALUES (1,1,1,300),(2,2,2,450),(3,3,3,500),(4,4,4,600),(5,5,5,700),(6,6,6,800),(7,7,7,900),(8,8,8,1000),(9,9,9,1100),(10,10,10,1200);
/*!40000 ALTER TABLE `purchase_fact` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_purchase_insert` BEFORE INSERT ON `purchase_fact` FOR EACH ROW BEGIN
    INSERT INTO purchase_log(operation_type, operation_timestamp, user, purchase_id, details)
    VALUES ('INSERT', NOW(), CURRENT_USER(), NEW.purchase_id, 'Insert operation before insert on purchase_fact');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_purchase_update` AFTER UPDATE ON `purchase_fact` FOR EACH ROW BEGIN
    INSERT INTO purchase_log(operation_type, operation_timestamp, user, purchase_id, details)
    VALUES ('UPDATE', NOW(), CURRENT_USER(), NEW.purchase_id, 'Update operation after update on purchase_fact');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `purchase_log`
--

LOCK TABLES `purchase_log` WRITE;
/*!40000 ALTER TABLE `purchase_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `service_category_dim`
--

LOCK TABLES `service_category_dim` WRITE;
/*!40000 ALTER TABLE `service_category_dim` DISABLE KEYS */;
INSERT INTO `service_category_dim` VALUES (1,'Software','Software related services'),(2,'Hardware','Hardware related services'),(3,'Consulting','Consulting services'),(4,'Support','Technical support services'),(5,'Development','Software development services'),(6,'Training','Training and education services'),(7,'Maintenance','Maintenance services'),(8,'Installation','Installation services'),(9,'Networking','Networking services'),(10,'Security','Security services'),(11,'Cloud Services','Services related to cloud computing'),(12,'Data Analytics','Data analysis and consulting services'),(13,'CRM Solutions','Custom CRM software and solutions'),(14,'IT Security','IT security assessment and solutions'),(15,'App Development','Mobile application development services'),(16,'E-commerce Solutions','E-commerce platform setup and management'),(17,'VR Training','Virtual reality based training solutions'),(18,'Blockchain','Blockchain consulting and development services');
/*!40000 ALTER TABLE `service_category_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `service_dim`
--

LOCK TABLES `service_dim` WRITE;
/*!40000 ALTER TABLE `service_dim` DISABLE KEYS */;
INSERT INTO `service_dim` VALUES (1,1,'Basic software package',100),(2,2,'Advanced hardware setup',200),(3,3,'Standard consulting session',150),(4,4,'Premium support package',250),(5,5,'Custom software development',300),(6,6,'Professional training session',180),(7,7,'Regular maintenance',120),(8,8,'System installation',220),(9,9,'Network setup and configuration',200),(10,10,'Cybersecurity services',300),(13,11,'Cloud Storage Service',100),(14,12,'Data Analytics Consulting',200),(15,13,'Custom CRM Solutions',300),(16,14,'IT Security Assessment',150),(17,15,'Mobile App Development',350),(18,16,'E-commerce Platform Setup',250),(19,17,'Virtual Reality Training',400),(20,18,'Blockchain Consulting Service',500);
/*!40000 ALTER TABLE `service_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `time_dim`
--

LOCK TABLES `time_dim` WRITE;
/*!40000 ALTER TABLE `time_dim` DISABLE KEYS */;
INSERT INTO `time_dim` VALUES (1,'2024-01-01 08:00:00',2024,1,1,8,0,0),(2,'2024-01-02 09:00:00',2024,1,2,9,0,0),(3,'2024-01-03 10:00:00',2024,1,3,10,0,0),(4,'2024-01-04 11:00:00',2024,1,4,11,0,0),(5,'2024-01-05 12:00:00',2024,1,5,12,0,0),(6,'2024-01-06 13:00:00',2024,1,6,13,0,0),(7,'2024-01-07 14:00:00',2024,1,7,14,0,0),(8,'2024-01-08 15:00:00',2024,1,8,15,0,0),(9,'2024-01-09 16:00:00',2024,1,9,16,0,0),(10,'2024-01-10 17:00:00',2024,1,10,17,0,0),(11,'2024-01-11 18:00:00',2024,1,11,18,0,0),(12,'2024-01-12 19:00:00',2024,1,12,19,0,0),(13,'2024-01-13 20:00:00',2024,1,13,20,0,0),(14,'2024-01-14 21:00:00',2024,1,14,21,0,0),(15,'2024-01-15 22:00:00',2024,1,15,22,0,0),(16,'2024-01-16 23:00:00',2024,1,16,23,0,0);
/*!40000 ALTER TABLE `time_dim` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-04 16:40:06
