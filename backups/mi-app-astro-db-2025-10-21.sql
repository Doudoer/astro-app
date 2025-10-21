-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: mi_app_astro_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `rif_ci` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Cliente Demo 1','J-12345678-9','+58 412-1234567','Direccion 1','2025-10-21 19:52:26'),(2,'Cliente Demo 2','V-98765432-1','+58 412-7654321','Direccion 2','2025-10-21 19:52:26'),(3,'DOUGLAS VILLALOBOS','J400489857','+58 412-7307933','LOS MODINES','2025-10-21 20:04:31'),(5,'IRWIN CANTOS','V17190299','04246112097','LA FLORIDA','2025-10-21 20:19:49');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counters`
--

DROP TABLE IF EXISTS `counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counters` (
  `name` varchar(50) NOT NULL,
  `value` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counters`
--

LOCK TABLES `counters` WRITE;
/*!40000 ALTER TABLE `counters` DISABLE KEYS */;
INSERT INTO `counters` VALUES ('CT',13),('ND',5),('product_code',4);
/*!40000 ALTER TABLE `counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_items`
--

DROP TABLE IF EXISTS `document_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` decimal(14,2) NOT NULL DEFAULT 1.00,
  `unit_price_usd` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `discount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `unit_price_bsf` decimal(18,4) DEFAULT NULL,
  `total_bsf` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `document_id` (`document_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `document_items_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `document_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_items`
--

LOCK TABLES `document_items` WRITE;
/*!40000 ALTER TABLE `document_items` DISABLE KEYS */;
INSERT INTO `document_items` VALUES (2,2,NULL,'SDDFASDFAS',1.00,25.0000,0.00,25.00,NULL,NULL),(4,4,NULL,'Producto prueba',2.00,10.5000,0.00,21.00,2105.2500,4210.50),(5,5,NULL,'P-000001 - BRAGA VERDE',1.00,4781.4700,0.00,4781.47,994019.7983,994019.80),(6,6,NULL,'Producto prueba BCV',3.00,5.2500,0.00,15.75,1052.6250,3157.88),(7,7,NULL,'Producto prueba BCV',3.00,5.2500,0.00,15.75,1052.6250,3157.88),(8,8,NULL,'P002 - Producto de ejemplo B',2.00,25.5000,0.00,51.00,5301.1950,10602.39),(9,9,NULL,'P003 - Producto de ejemplo C',1.00,5.7500,0.00,5.75,1195.3675,1195.37),(10,10,NULL,'Producto sin bcv',1.00,20.0000,0.00,20.00,5015.0000,5015.00),(11,11,NULL,'Producto BCV flow',2.00,7.5000,0.00,15.00,1559.1750,3118.35),(12,12,NULL,'Prod USD',2.00,12.3456,0.00,24.69,12.3456,24.69),(13,13,NULL,'Prod BCV',1.00,5.5000,0.00,5.50,1143.3950,1143.39),(14,14,NULL,'P004 - Braga Azul',200.00,18.0000,0.00,3600.00,3742.0200,748404.00),(15,15,NULL,'Prod USD',2.00,12.3456,0.00,24.69,12.3456,24.69),(16,16,NULL,'Prod BCV',1.00,5.5000,0.00,5.50,1143.3950,1143.39),(17,17,NULL,'P-000004 - BRAGA',1.00,1.0000,0.00,1.00,1.0000,1.00),(18,18,NULL,'P-000004 - BRAGA',1.00,1.0000,0.00,1.00,207.8900,207.89);
/*!40000 ALTER TABLE `document_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_number` varchar(100) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'USD',
  `exchange_rate` decimal(18,6) DEFAULT 1.000000,
  `subtotal_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal_bsf` decimal(18,2) DEFAULT NULL,
  `tax_bsf` decimal(18,2) DEFAULT NULL,
  `total_bsf` decimal(18,2) DEFAULT NULL,
  `bcv_rate` decimal(18,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doc_number` (`doc_number`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (2,'CT-2025-000001','CT',3,'VES',192.200000,25.00,4.00,29.00,'2025-10-21 20:13:04',NULL,NULL,NULL,NULL),(4,'CT-2025-000003','CT',NULL,'VES',200.500000,21.00,3.36,24.36,'2025-10-21 21:23:24',4210.50,673.68,4884.18,NULL),(5,'ND-2025-000002','ND',5,'VES',207.890000,4781.47,765.04,5546.51,'2025-10-21 21:34:48',994019.80,159044.17,1153063.96,NULL),(6,'CT-2025-000004','CT',NULL,'VES',200.500000,15.75,2.52,18.27,'2025-10-21 21:35:56',3157.88,505.26,3663.13,200.500000),(7,'CT-2025-000005','CT',NULL,'VES',200.500000,15.75,2.52,18.27,'2025-10-21 21:39:00',3157.88,505.26,3663.13,200.500000),(8,'ND-2025-000003','ND',3,'VES',207.890000,51.00,8.16,59.16,'2025-10-21 21:40:21',10602.39,1696.38,12298.77,207.890000),(9,'ND-2025-000004','ND',5,'VES',207.890000,5.75,0.92,6.67,'2025-10-21 21:40:57',1195.37,191.26,1386.63,NULL),(10,'CT-2025-000006','CT',NULL,'VES',250.750000,20.00,3.20,23.20,'2025-10-21 21:45:14',5015.00,802.40,5817.40,250.750000),(11,'CT-2025-000007','CT',NULL,'VES',207.890000,15.00,2.40,17.40,'2025-10-21 21:47:53',3118.35,498.94,3617.29,207.890000),(12,'CT-2025-000008','CT',NULL,'USD',1.000000,24.69,3.95,28.64,'2025-10-21 21:54:51',24.69,3.95,28.64,NULL),(13,'CT-2025-000009','CT',NULL,'VES',207.890000,5.50,0.88,6.38,'2025-10-21 21:54:51',1143.39,182.94,1326.34,207.890000),(14,'ND-2025-000005','ND',1,'VES',207.890000,3600.00,576.00,4176.00,'2025-10-21 21:56:54',748404.00,119744.64,868148.64,207.890000),(15,'CT-2025-000010','CT',NULL,'USD',1.000000,24.69,3.95,28.64,'2025-10-21 21:59:03',24.69,3.95,28.64,NULL),(16,'CT-2025-000011','CT',NULL,'VES',207.890000,5.50,0.88,6.38,'2025-10-21 21:59:03',1143.39,182.94,1326.34,207.890000),(17,'CT-2025-000012','CT',5,'USD',1.000000,1.00,0.16,1.16,'2025-10-21 21:59:34',1.00,0.16,1.16,NULL),(18,'CT-2025-000013','CT',5,'VES',207.890000,1.00,0.16,1.16,'2025-10-21 21:59:45',207.89,33.26,241.15,207.890000);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price_usd` decimal(14,2) NOT NULL DEFAULT 0.00,
  `stock` decimal(14,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'P002','Producto de ejemplo B',25.50,50.00,'2025-10-21 19:52:26'),(3,'P003','Producto de ejemplo C',5.75,200.00,'2025-10-21 19:52:26'),(4,'P004','Braga Azul',18.00,100.00,'2025-10-21 20:01:24'),(6,'P005','BRAGA ROJ',18.00,100.00,'2025-10-21 20:19:24'),(7,'P-000001','BRAGA VERDE',23.00,0.00,'2025-10-21 20:56:47'),(8,'P-000002','BRAGA VERDE D',50.00,0.00,'2025-10-21 20:58:17'),(9,'P-000003','OOOO',1.00,0.00,'2025-10-21 21:58:00'),(10,'P-000004','BRAGA',1.00,0.00,'2025-10-21 21:58:24');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(128) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('05325fab31090568a727fbd974c551801a4740bd5f9fa2474363aa8b3361df234cb29d721ed5be537824c431b44c5298',1,'2025-10-21 21:29:42','2025-10-28 21:29:42'),('05d90b9f953b32d0acb114003314d8ab6f3e0f6fffec74b092d011509795eb1eb3f403107323c366cc5cc95250b01c47',1,'2025-10-21 19:00:25','2025-10-28 19:00:25'),('226c42a04fcec444141f145b33d11bb1b18f30dbf2bd2d7b3e871f4c3119681de5a159dd227a419152d4be1e2fa65af0',1,'2025-10-21 19:11:15','2025-10-28 19:11:15'),('357b6c3863c96238c696aca7d2b1b1d3d01b35dbd9a4c396ab18fd373e24a37358411fb23645dc65c8cc8d22739150cf',1,'2025-10-21 16:46:48','2025-10-28 16:46:48'),('43c8ed736f574ad38670eb03452609f1ccec033938dc655d41261c055464d0913a7ec41fe8bfebb4b09b329dc0161fa6',1,'2025-10-21 18:58:40','2025-10-28 18:58:40'),('4c510d95e8db1db5224da78a92aef21c2052ee7e8f71a89425984339ea6e88ae25ad48a9f35524b1585a98cd86bae313',1,'2025-10-21 19:02:09','2025-10-28 19:02:09'),('5a6a4909d877d8263e0aa52fedcef4337afec0ec0170c456db5e988f241abe9340866438db3745d33c5711f1f159f998',1,'2025-10-21 20:20:52','2025-10-28 20:20:52'),('6408a4565fb43e42c4a3867236c67902db6ebeb00da9fd5c9ef625043a626df9a67c684c4ee37ee28171dab6eb5bf09c',1,'2025-10-21 19:00:15','2025-10-28 19:00:15'),('72a9bf2b319e8f16b1f689c73f9a1b5abbcb97f85e0265e521b75af06c55d0a1620e3a74a0dc6b8a0d36a1a9764ad5d5',1,'2025-10-21 17:07:35','2025-10-28 17:07:35'),('79beb5b581679c74ccbad47798241960f4fbc18b6927412b2fb0db871f835f7c06afca1ea79b27ac88d1b56da6d33032',1,'2025-10-21 19:29:10','2025-10-28 19:29:10'),('admin-sid-1761078074986-248',2,'2025-10-21 20:21:14','2025-10-23 00:21:14'),('admin-sid-1761078074989-312',4,'2025-10-21 20:21:14','2025-10-23 00:21:14'),('admin-sid-1761081804595-920',6,'2025-10-21 21:23:24','2025-10-23 01:23:24'),('admin-sid-1761082556380-795',7,'2025-10-21 21:35:56','2025-10-23 01:35:56'),('admin-sid-1761082740478-361',8,'2025-10-21 21:39:00','2025-10-23 01:39:00'),('admin-sid-1761083114668-645',9,'2025-10-21 21:45:14','2025-10-23 01:45:14'),('admin-sid-1761083273933-954',10,'2025-10-21 21:47:53','2025-10-23 01:47:53'),('admin-sid-1761083691360-587',11,'2025-10-21 21:54:51','2025-10-23 01:54:51'),('admin-sid-1761083943396-898',12,'2025-10-21 21:59:03','2025-10-23 01:59:03'),('b4c9b26d23be2b8329173e4690b3321a51e44b2fe942ff5f3e2f245f3889dfb61dee9eca6ae3107c2b4783fdccfc50f9',1,'2025-10-21 19:31:06','2025-10-28 19:31:06'),('cd8fbc4a9c9e1e355a0d4183cc9c80ad54bd0f83e07838315247a2e4d4c2a05bb057fc95ab668790ab129e601f03e017',1,'2025-10-21 19:21:03','2025-10-28 19:21:03');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creado_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(50) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','$2b$10$RpiAorewADsNhatO1mwdJOkW.U1PGgVlWBXFkcL2iP9hpUUuUFFpG','2025-10-21 16:35:59','admin'),(2,'test_admin_1761078074958','x','2025-10-21 20:21:14','admin'),(4,'test_admin_1761078074962','x','2025-10-21 20:21:14','admin'),(5,'test_user_1761078074974','x','2025-10-21 20:21:14','user'),(6,'test_admin_1761081804586','x','2025-10-21 21:23:24','admin'),(7,'test_admin_1761082556372','x','2025-10-21 21:35:56','admin'),(8,'test_admin_1761082740466','x','2025-10-21 21:39:00','admin'),(9,'test_admin_1761083114660','x','2025-10-21 21:45:14','admin'),(10,'test_admin_1761083273925','x','2025-10-21 21:47:53','admin'),(11,'test_admin_1761083691348','x','2025-10-21 21:54:51','admin'),(12,'test_admin_1761083943389','x','2025-10-21 21:59:03','admin');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-21 18:03:28
