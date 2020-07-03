-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: onlineBusiness
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer_info`
--

DROP TABLE IF EXISTS `customer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_info` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `adress` varchar(45) DEFAULT NULL,
  `phoneNumber` int(14) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_info`
--

LOCK TABLES `customer_info` WRITE;
/*!40000 ALTER TABLE `customer_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `final`
--

DROP TABLE IF EXISTS `final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `final` (
  `given_on` date NOT NULL,
  `scores` int(11) DEFAULT NULL,
  `students` varchar(50) DEFAULT NULL,
  `answers` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`given_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final`
--

LOCK TABLES `final` WRITE;
/*!40000 ALTER TABLE `final` DISABLE KEYS */;
/*!40000 ALTER TABLE `final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_items`
--

DROP TABLE IF EXISTS `inventory_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_items` (
  `id` varchar(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `weight` int(11) DEFAULT NULL,
  `priceVN` int(11) DEFAULT NULL,
  `priceUS` int(11) DEFAULT NULL,
  `specifications` varchar(200) DEFAULT NULL,
  `quantity` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_items`
--

LOCK TABLES `inventory_items` WRITE;
/*!40000 ALTER TABLE `inventory_items` DISABLE KEYS */;
INSERT INTO `inventory_items` VALUES ('CC302068','Com Chay Kho Ga',500,135000,23,NULL,NULL),('CC4797728','Cha Gio Tom Say Mini',200,150000,12,NULL,NULL),('CC623191','Com Chay Sieu Cha Bong',500,140000,23,NULL,NULL),('HH426024','Hat Dieu Rang Cui Binh Phuoc',500,150000,25,NULL,NULL),('KK3756942','Khom Say Deo',250,95000,14,NULL,NULL),('MM2119559','Mang Cau Say Muoi Ot Deo',250,210000,17,NULL,NULL),('MM351542','Me Rim Muoi Ot Deo',500,135000,21,NULL,NULL),('MM3534924','Me Xi Muoi Nhan Chum Ruot',500,135000,19,NULL,NULL),('NN4615655','Nui Lac Kho Bo La Chanh',500,75000,18,NULL,NULL),('TT6383114','Banh Trang Cha Bong Toi',150,65000,8,NULL,NULL),('VV6749974','Vo Buoi Say Chanh',250,165000,12,NULL,NULL),('XX110808','Say Co Xoc Muoi Ot',300,135000,15,NULL,NULL);
/*!40000 ALTER TABLE `inventory_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_list`
--

DROP TABLE IF EXISTS `orders_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_list` (
  `id` varchar(11) NOT NULL,
  `CustName` varchar(45) DEFAULT NULL,
  `CustLast` varchar(45) DEFAULT NULL,
  `CustPhone` varchar(45) DEFAULT NULL,
  `FaceBookId` varchar(50) DEFAULT NULL,
  `Addr` varchar(50) DEFAULT NULL,
  `Location` varchar(10) DEFAULT NULL,
  `ShippingCost` varchar(45) DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `OrederMemo` varchar(50) DEFAULT NULL,
  `ORQ` varchar(500) DEFAULT NULL,
  `ORN` varchar(500) DEFAULT NULL,
  `ORNP` varchar(500) DEFAULT NULL,
  `ORTP` varchar(500) DEFAULT NULL,
  `Stat` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_list`
--

LOCK TABLES `orders_list` WRITE;
/*!40000 ALTER TABLE `orders_list` DISABLE KEYS */;
INSERT INTO `orders_list` VALUES ('SS1050571','sn','sl','12312323','sFB','sAddr','USD','20','2019-12-13','TestingSake','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0;97;117'),('SS2119559','Test','TestLastName','2143213213','dadsasdca','2asdsadas','USD','20','2019-12-13','Test','2;4;1;6;3','Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Khom Say Deo;Banh Trang Cha Bong Toi;Say Co Xoc Muoi Ot','12;23;14;8;15','24;92;14;48;45','223;0;223;243'),('SS302068','Ahmad','Abdoli','09123344321','AhmadTest','1234 Test St, Test, Ga','USD','20','2019-12-13','TestUs','2;4;1;6;3','Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Khom Say Deo;Banh Trang Cha Bong Toi;Say Co Xoc Muoi Ot','12;23;14;8;15','24;92;14;48;45','223;0;223;243'),('SS3253296','Kia','Pey','4703990454','KiaPey','464 Ethel St, Atlanta, Ga','USD','25','2019-12-13','Testing','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0.1;87.3;112.3'),('SS351542','Kia','Pey','4703333123','KiaPeynabard','464 Ethel St, Atlanta, Ga','USD','23','2019-12-13','Testing Kia','2;4;1;6;3','Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Khom Say Deo;Banh Trang Cha Bong Toi;Say Co Xoc Muoi Ot','12;23;14;8;15','24;92;14;48;45','223;0;223;246'),('SS3534924','TestName','TestLastName','12343456654','FaCeTest','1234 Test st, Test Location','VNd','145000','2019-12-13','TestingSake','9;2;4;6','Cha Gio Tom Say Mini;Hat Dieu Rang Cui Binh Phuoc;Nui Lac Kho Bo La Chanh;Say Co Xoc Muoi Ot','150000;150000;75000;135000','1350000;300000;300000;810000','2760000;0;2760000;2905000'),('SS4501394','c','cL','123123123213','CFB','CADDR','USD','20','2019-12-13','Trying','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0;97;117'),('SS4821240','a','al','12312321','af','a add','USD','20','2019-12-13','test','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0;97;117'),('SS5558938','Name','Last','293123132','FBIL','dasdad','USD','20','2019-12-13','Testing','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0;97;117'),('SS6383114','Phuong','Nguyen','4708903450','pnguyen1808','4209 Logans Run Ct, Duluth, GA','USD','15','2019-12-13','Final Test','2;4;1;6;3','Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Khom Say Deo;Banh Trang Cha Bong Toi;Say Co Xoc Muoi Ot','12;23;14;8;15','24;92;14;48;45','223;0.1;200.7;215.7'),('SS7073138','fn','fl','2131232131','fFB','fAddr','USD','12','2019-12-13','Testing','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0;97;109'),('SS8474131','u','u','2231312','uFB','21FB','USD','20','2019-12-13','Testing','1;1;1;1;1','Com Chay Kho Ga;Cha Gio Tom Say Mini;Com Chay Sieu Cha Bong;Hat Dieu Rang Cui Binh Phuoc;Khom Say Deo','23;12;23;25;14','23;12;23;25;14','97;0;97;117');
/*!40000 ALTER TABLE `orders_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_orders`
--

DROP TABLE IF EXISTS `pending_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pending_orders` (
  `id` varchar(10) NOT NULL,
  `Item_Name` varchar(45) DEFAULT NULL,
  `Item_Quantity` int(10) DEFAULT NULL,
  `Item_Net_Price` int(10) DEFAULT NULL,
  `Item_Total_Price` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_orders`
--

LOCK TABLES `pending_orders` WRITE;
/*!40000 ALTER TABLE `pending_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `pending_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SomeTable`
--

DROP TABLE IF EXISTS `SomeTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SomeTable` (
  `Id` int(11) NOT NULL,
  `Frequency` varchar(200) DEFAULT NULL,
  CONSTRAINT `chk_Frequency` CHECK ((`Frequency` in (_utf8mb4'Daily',_utf8mb4'Weekly',_utf8mb4'Monthly',_utf8mb4'Yearly')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SomeTable`
--

LOCK TABLES `SomeTable` WRITE;
/*!40000 ALTER TABLE `SomeTable` DISABLE KEYS */;
/*!40000 ALTER TABLE `SomeTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_table`
--

DROP TABLE IF EXISTS `user_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_table` (
  `userId` varchar(8) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `Pin` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_table`
--

LOCK TABLES `user_table` WRITE;
/*!40000 ALTER TABLE `user_table` DISABLE KEYS */;
INSERT INTO `user_table` VALUES ('1','1','1','1','1','1'),('KP001393','Kia','Peynabard','KiaP393','1802','Kiavash.peynabard@gmail.com'),('MN102419','My','Nguyen','My1024','1234','toBePopulated'),('PN180889','Phuong','Nguyen','PN1808','1802','phuongnguyen889@gmail.com');
/*!40000 ALTER TABLE `user_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-29  1:06:53
