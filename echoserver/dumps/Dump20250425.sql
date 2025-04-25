-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: books
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add book',7,'add_book'),(26,'Can change book',7,'change_book'),(27,'Can delete book',7,'delete_book'),(28,'Can view book',7,'view_book'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add order',9,'add_order'),(34,'Can change order',9,'change_order'),(35,'Can delete order',9,'delete_order'),(36,'Can view order',9,'view_order'),(37,'Can add order item',10,'add_orderitem'),(38,'Can change order item',10,'change_orderitem'),(39,'Can delete order item',10,'delete_orderitem'),(40,'Can view order item',10,'view_orderitem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `author` varchar(500) NOT NULL,
  `cost` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (2,'Метро 2033','Дмитрий Глуховский',700),(3,'Преступление и наказание','Федор Достоевский',500),(5,'Последнний солдат СССР','Алекс Шу',400),(7,'Чиназес','Арсен Маркарян',52),(8,'1984','Джордж Оруэлл',500),(9,'Бойцовский клуб','Чак Паланик',600),(10,'Барлиона','Василий Маханенко',500),(11,'Самый странный нуб','Артем Каменистый',700),(12,'Цветы для Элджернона','Дэниел Киз',600),(13,'Сто лет одиночества','Маркес Габриэль Гарсия',400),(14,'Мастер и маргарита','Михаил Булгаков',500),(23,'Мы','Евгений Замятин',10),(24,'Мы','Евгений Замятин',10),(25,'Мы','Евгений Замятин',10),(26,'Мы','Евгений Замятин',10),(27,'Мы','Евгений Замятин',10),(28,'Мы','Евгений Замятин',10),(29,'Мы','Евгений Замятин',10),(30,'Мы','Евгений Замятин',10),(31,'Мы','Евгений Замятин',10),(32,'Мы','Евгений Замятин',10),(33,'Мы','Евгений Замятин',10),(34,'Мы','Евгений Замятин',10),(35,'Мы','Евгений Замятин',10),(36,'Мы','Евгений Замятин',10),(37,'Мы','Евгений Замятин',10);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'echo','book'),(9,'echo','order'),(10,'echo','orderitem'),(8,'echo','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-03-01 07:16:03.242333'),(2,'auth','0001_initial','2025-03-01 07:16:04.077250'),(3,'admin','0001_initial','2025-03-01 07:16:04.279594'),(4,'admin','0002_logentry_remove_auto_add','2025-03-01 07:16:04.289902'),(5,'admin','0003_logentry_add_action_flag_choices','2025-03-01 07:16:04.299171'),(6,'contenttypes','0002_remove_content_type_name','2025-03-01 07:16:04.487947'),(7,'auth','0002_alter_permission_name_max_length','2025-03-01 07:16:04.580289'),(8,'auth','0003_alter_user_email_max_length','2025-03-01 07:16:04.609239'),(9,'auth','0004_alter_user_username_opts','2025-03-01 07:16:04.618652'),(10,'auth','0005_alter_user_last_login_null','2025-03-01 07:16:04.697848'),(11,'auth','0006_require_contenttypes_0002','2025-03-01 07:16:04.701868'),(12,'auth','0007_alter_validators_add_error_messages','2025-03-01 07:16:04.710335'),(13,'auth','0008_alter_user_username_max_length','2025-03-01 07:16:04.803851'),(14,'auth','0009_alter_user_last_name_max_length','2025-03-01 07:16:04.896163'),(15,'auth','0010_alter_group_name_max_length','2025-03-01 07:16:04.920716'),(16,'auth','0011_update_proxy_permissions','2025-03-01 07:16:04.932556'),(17,'auth','0012_alter_user_first_name_max_length','2025-03-01 07:16:05.023870'),(18,'sessions','0001_initial','2025-03-01 07:16:05.080589'),(19,'echo','0001_initial','2025-03-01 08:47:49.706593'),(20,'echo','0002_user','2025-03-21 15:26:41.822386'),(21,'echo','0003_order_orderitem','2025-03-29 08:32:47.597857');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1ile9v76um6e2se96b70jh5jpt11fvhy','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FRO:56tsRh-8h_P9eVHG6s9q8BJPppc49hIz1Og9Jajw8yE','2026-04-25 09:33:50.658974'),('1qj4uabrgj1ijf74v4c323y4fqocyozl','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LJt:Y4v5qbXD0MYzhOcC8V8u_DMBkuTHgR7RFE0prFEVzZM','2026-04-25 15:50:29.935216'),('27f1k0weu1znth891in75rt83kasvdyk','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FOz:qvBX6Fy1FzBGyYf5JrfqrHAn4PiSMMQRz_P9YMYLQ7k','2026-04-25 09:31:21.950323'),('37pf6trb34mzypba0fig7klxuv1umd10','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FSt:Tm9jaZ5xvNQU9CVJ7oQ6LUv2QgdppwL-3LoFhjtj_QM','2026-04-25 09:35:23.123942'),('39ieop7q21jq4q4tqssa076bkw0jafpo','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LL5:wbhvSfBCjgFGjWRpkY1Vi6IZUH4Mv9JrQRQ_fTbXcUo','2026-04-25 15:51:43.781213'),('5o9uajno9ejkv7b8kclnj71anek4153r','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LcM:p28-Bgf0RCaZgSKYZ-vzdMtBZU4ZNUMP5_SJjmwAh_o','2026-04-25 16:09:34.928538'),('6joy0gt3mf5779p0zu2yhhqko6v3fwfz','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8Kx0:lb359INSGry8mVDVVQjdLv3r5jlySOV8mfhcxl7lt4g','2026-04-25 15:26:50.106342'),('6vo1930dks8znr8v3573lrgc8b6c67oe','.eJxNjsEKAjEMRH9F5rxIymZl7bcIUrsFF4rV2gqy9N9Nowcvj0xmyGSDd7nAbpg7ylpigIU5zowBrpZryqJPldhw53hQhk4mnX_7nYb-DB6Vi9qXL-WoT08pxES0J5GP6m5S-4Y1rQ1Ir5BdjOd7Xr18oqn2AX_FMFM:1ty9d0:QPHWgKAkkfs4dLIw0rIsx_lW93Ivz4i0sm1Mglc0q90','2025-04-11 13:20:06.374911'),('9n1f4lk7mnj0b60mn2krajrdive8t63u','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FI0:_uukbH3mhjlXrkZ58zLleNsSPtWgkkqCrf1gl0crh2g','2026-04-25 09:24:08.187612'),('9qwc46m3w1scs3w27xugq3vsgyntb2h2','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8Kmw:GOCRHtGTHHcauZrO1Ns_7obZfjbdpAa-CO8NHlNF8tk','2026-04-25 15:16:26.281291'),('c4g75j1vkilzz0hjy97rfeboakxue0f5','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LWX:IIJ31NcH38v9wiOT8jo-PVzUSrXeUJ3YfH6qxOF76b8','2026-04-25 16:03:33.692050'),('dlcrc34wx59c27amatg7upjlgiy3yvp5','.eJxVjEEOwiAQRe_C2jQQYAbcaQ9ChgGCMdpEysp491LThW7f---_RaC-1tBbfoVbEmehQJx-YSS-5-duMtdl-oqDTXNv6_K4DHQ9Vn9ppVZHZ1KUgLZIZgXaeMzOgMSUDBYHjBGt9ujYFQAiGOe-WMnaRTKoWIrPBpN8Ndc:1u8LbN:gvmKg8y8SpFDdXlXAZKahGE3kfQRaSp2wKVX6zY2YZM','2026-04-25 16:08:33.950867'),('ezbd8ht3ud4pk2hiil0km5uxmwwyer2c','.eJxVi0sOwiAQhu_C2jQIhA7u1IOQfxgmGKNNbFkZ7241Xej2ezxNRl9a7nN95IuYg3Fm98sY5VrvH1FLm4av2Nhw7vMy3Y4rOm3V39owt_UD2zSyB4UCHj2Sp6TeRhVEIUIkR1DUvecoQYooa3BKTNZRsTCvN5v4Nts:1ty5aQ:nn7DmmlvH-MIJjiXPQ5Ge2Dd0MvIvdJ4h3GpUFZDoWw','2025-04-11 09:01:10.008579'),('g93c7kl6rnl0eqchkqzec8d7c88oos7l','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LZO:2O_tG5tboNHXj_QLyC5vf07djgfwzxiXC6a9t68_uE0','2026-04-25 16:06:30.031074'),('gdbjc3fd1t4as5k84k1ttqjcxs3rbyal','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8KvI:I8kIXUP6SyB4Tfm5c_0ePd36HKRnki8Sd0SYQCc442M','2026-04-25 15:25:04.532201'),('jsjd4exzxmklypv2fbbzynnmsuh8ob79','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FWI:2IiSOHTSJ7R_m5r_G93acfbb7x0AI0Fl8By3dGj0tKc','2026-04-25 09:38:54.705194'),('kf4aa2i2gph7uit176aamqmz2dm5wp3u','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8Lf2:13skfA6cYBjAc0JecaNpYU4e5wR6F6ENZe8cq111wME','2026-04-25 16:12:20.409791'),('mw076012s9dve3kq1zooumqxqz6zn8r5','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8Kzw:3HFEDmhjEK4qvROEEEj59ppoBfWup-yLuxW192C2CS8','2026-04-25 15:29:52.374400'),('n3i4dudjak4wem25do6ju0c8hmlua9yq','.eJxVjEEOwiAQRe_C2jQQYAbcaQ9ChgGCMdpEysp491LThW7f---_RaC-1tBbfoVbEmehQJx-YSS-5-duMtdl-oqDTXNv6_K4DHQ9Vn9ppVZHZ1KUgLZIZgXaeMzOgMSUDBYHjBGt9ujYFQAiGOe-WMnaRTKoWIrPBpN8Ndc:1u8LaD:vT8erNsk7AaUTG63xfzqa1vdeweGwtf7B_rFKfD940Q','2026-04-25 16:07:21.208134'),('ot0x925zsyq7497foqywzgg9mxw2ub49','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FUS:KNsVeyWQ9s1dWxV0bi5srKodqIcNY0rw4wrXq5dQxic','2026-04-25 09:37:00.503718'),('oydnb8b5w1lz1c2py4f97fv8drl2fabg','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8Klm:xoLA3khlVryIC5G4LYj1mlB8unSq1wfuFPMQapQpC9M','2026-04-25 15:15:14.163417'),('q5tvu9i0ap7jkufdr8ncutx2t81tsmuq','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LU9:ADN5JzNjrZnktunANeNJiAWtnfbyqllwJV95HXXakfI','2026-04-25 16:01:05.852591'),('rni9u1vr2nlqp2r50jbmd5bsot013dxk','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LSL:G8C0UP9S6MsthS7v3vsLQFyDOXjhwcYbWHom8k-3-Gs','2026-04-25 15:59:13.824992'),('txd56j3o02i0f3eze1fi3apni78uuc9s','.eJyrVopPLC3JiC8tTi2Kz0xRslLKSS0qKyxU0kGWSEpMzk7NA8mmJmfk64EloGJ6zqXFJfm5jkAhJ6gqFK0ZicUZQH1KtQAmqSae:1tw3QV:Twpr86tNLJLYVMuswreUp2l7w53VgAIhhZ6AVcgK7oM','2025-04-05 18:18:31.937893'),('vbfdgi5mt5uuhxxukp3fpahbqhyuy3jr','e30:1tw2Yy:zUYtnrfCeShBHtTEjEdtXR6pT1bZ07kJ6myd4cc2RpM','2025-04-05 17:23:12.918668'),('w3t7ljqwfys5xzjfhegzok5ncqmhlo5z','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8FPw:3Lkdjk4OUGVNbdYfT_9gOKFsSomIsmeM5IxA9Zki0T4','2026-04-25 09:32:20.406796'),('xbq0rfkk60c52pcudvwwqrghztxz0hyw','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8KsB:z7eQyNQ0QE04M-d7pqk5NNMAab0CWylH0USOGF7-Ii8','2026-04-25 15:21:51.563803'),('xhve4hw72r3k7g1j0s4fvmxy8o7nl3ha','.eJxVjEEOwiAQRe8ya9MwUAZwZz0IgWEajNEmUlbGu2tNF7p977__hJj6WmNv8oiXAkdAOPyynPgq900I12X4ip0N597W5Xb6oGlf_aU1tbodZk1k5qIpWW8dKpsDBjQ6uJEZZ68cllFISTLOsiJNwsF6DsSCysDrDUqPNJs:1u8LN0:lk1bLuebBbktprCIbhlqGaCsQtbr0EucBEhUS6q_cdo','2026-04-25 15:53:42.805099'),('xk53z933u6bzf2udc10fri8irwlzdeel','.eJxVi0sOwiAQQO_C2jRDCwO4sx6EwMwQjNEmUlbGu1tNF7p9n6eKqa819iaPeGF1VNqpwy_Mia5y_xihugxfsbPh3Nu63E4bmvfqb62p1e0LtlgNmXksXByCD8iE5ILRLjvjC0EythjwCCg6S0BhDRPkaRSyXr3eoOw1zA:1u8LdC:Lv9ONMHPeElbQnTrnOBhzvzet5qniXLCq2ISF1zJuHQ','2026-04-25 16:10:26.051131'),('xkkaeiioqxbwpux7qqju5vtjeekq6j7b','.eJxVi0sOAiEQBe_C2kzkM9DtTj0IaegmGKOTyLAy3l00s9Dlq3r1VJH6WmNv8ogXVgdl1O6XJcpXuX-E5LpMX7Gx6dzbutyOA522119aqdXRWQcAbCUYlwABciqgvSRwmrDoYgUNMxGSA5O8x9nosWcJYHnvg3q9AXXMNa8:1tyPxP:dLvn_NgAn_5LrY4sADzBf51sUw96i_xIPCzW_3M-uI8','2026-03-29 06:46:15.994445'),('xwfpa4g09fjy3f99pf9jaaehhjwv77uc','.eJxVi0sOwiAQQO_C2jQwFIa6Uw9CBmYIxmgTKSvj3W1NF7p9n5eK1Jcae5NnvLI6KhPU4Rcmyjd5bEZynYev2Nlw6W2Z76cVnffqb63U6vZpGzgVsgBmROsB2Wty2QQBKzJRGg0wo0PjtUtApZBLDGhxbSdR7w-XHzW1:1u8Lfr:iVvYYCB8bLoWdr8NhnAnxUWInjH8okRoI4kXoOvbmyI','2026-04-25 16:13:11.634647'),('znk97nqewjk53sn3opjzp317g0i4163x','.eJxVi80OwiAMgN-Fs1kQCCve1AchLW3DYuYSByfjuzvNDnr9fp4mY28191UeeWJzMiRN5qlUc_hVhOUm94-XUpfhK3Y2XPvalvm8octe_a0V17p9SDaN5BFCQRo9Jg9JvY3KGBkAIzhARTl6ihy4sJIGp0BgHRSL5vUGllQ56g:1txrKL:GiZVzC9i828_yYpAgMOoZXIRMZ_0310vzUlutLI_CZw','2025-04-10 17:47:37.630385');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `order_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,8,1,1),(2,10,1,1),(3,9,1,1),(4,10,2,1),(5,2,2,1),(6,8,3,1),(7,10,3,1),(12,23,8,1),(13,23,9,1),(14,23,10,1),(15,23,11,1),(16,23,12,1),(17,23,13,1),(18,23,14,1),(19,23,15,1),(20,23,16,1),(21,27,17,1),(22,27,18,1),(23,27,19,1),(24,27,20,1),(25,27,21,1),(26,27,22,1);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  `total_price` double DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-03-29 09:12:23',2,1600),(2,'2025-03-29 09:13:27',2,1200),(3,'2025-03-29 09:56:49',4,1000),(4,'2025-04-25 09:34:08',1,10),(5,'2025-04-25 09:35:40',1,10),(6,'2025-04-25 09:37:18',1,10),(7,'2025-04-25 09:39:04',1,10),(8,'2025-04-25 15:15:23',1,10),(9,'2025-04-25 15:16:35',1,10),(10,'2025-04-25 15:22:04',1,10),(11,'2025-04-25 15:25:17',1,10),(12,'2025-04-25 15:27:03',1,10),(13,'2025-04-25 15:30:05',1,10),(14,'2025-04-25 15:50:42',1,10),(15,'2025-04-25 15:51:56',1,10),(16,'2025-04-25 15:53:55',1,10),(17,'2025-04-25 15:59:26',1,10),(18,'2025-04-25 16:01:18',1,10),(19,'2025-04-25 16:03:46',1,10),(20,'2025-04-25 16:06:43',1,10),(21,'2025-04-25 16:09:47',1,10),(22,'2025-04-25 16:12:33',1,10);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password` varchar(256) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_role` varchar(100) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_staff` tinyint DEFAULT '0',
  `is_active` tinyint DEFAULT '1',
  `is_superuser` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'lervqq','pbkdf2_sha256$870000$cu5gg4ckoO2Y81jj15RVpu$ei7w4zSrfjSLZ0nOh63sNblnnhW+RPquxBfhPyeO6v8=','betekhtinms@ya.ru','Michael','admin','2025-04-25 16:12:20',0,1,0),(2,'betemich','pbkdf2_sha256$870000$Wh7jPYekPx7BgLs7a8LKmv$iyykCaYRQdRa1/cDRs4C6GIbW824NZjb6j6aE5qAamU=','b2@mail.ru','Michael','user','2025-04-12 09:32:40',0,1,0),(4,'bee','pbkdf2_sha256$870000$mx5p9RMVPnGDdrgDTH2Sk4$rEq3GuR38cFM5vmtdyN/9I6rb7Khn2uXcU5Lzy75Wu0=','beee@mail.ru','be','user','2025-03-29 09:56:33',0,1,0),(5,'7vladis','argon2$argon2id$v=19$m=102400,t=2,p=8$RkVpalE5aWVzcVg0M2JFa0dycVdJRQ$P2x/Ji281hC4lfoYDzOmEOfFbcFmxvhGNaiuQ2WNlPM','val@a.ru','Владос','user','2025-04-08 17:00:53',0,1,0),(6,'rus','argon2$argon2id$v=19$m=102400,t=2,p=8$bjZxaFBWcTlySUhZcE5DZHRRTzJ0Rg$aWnBmspne5Eummc+mMPDULQd50PeW1z/oKkvB5AXUCg','goida@rururu.ru','Шаман','user','2025-04-10 18:39:08',0,1,0),(12,'login5deae083-b097-4d23-8db9-7f4c527609f7','argon2$argon2id$v=19$m=102400,t=2,p=8$RnNpcVZzTWROdnM1N2VmZURzTnlWdA$3bEyVxGQbJxKW9k97j/TzN19UaIOzXZpCKdEpQ5B8bw','emailbaba0bd7-6493-425b-adc8-e411f994fb96@ya.ru','Art','user',NULL,0,1,0),(13,'logind3cc5e1d-3e83-4efb-88bc-38942b64e2a0','argon2$argon2id$v=19$m=102400,t=2,p=8$WGJnemFickN0ZHBvZ2xydUIzenlEbA$x6UOWSKlQH5pzdUZq2OHrOzb472VJI24x1cherUC2AM','email9b2da327-0544-42d4-8995-69a938944d19@ya.ru','Art','user',NULL,0,1,0),(14,'login01a732e9-fff5-448c-9959-c243b42f1e3f','argon2$argon2id$v=19$m=102400,t=2,p=8$ZDRuTHoySkpGMUdzeERWamhaYUYwRw$MzJDIuy+2fCnNCoBkEonTKIBr0cIllEeEoQm/cKyD0o','email06458a95-fbd4-4805-bab5-619dd81501e1@ya.ru','Art','user',NULL,0,1,0),(15,'login73e30904-4174-45db-823f-aa38ee623ecf','argon2$argon2id$v=19$m=102400,t=2,p=8$aEFTajk4Z29OWnlsNGVTRER0dzRnMw$b2+MdvDB6y6zLYDrEQrWByUZm6GKKjiOsGxbwmIQhP8','emaild85a97ac-45bd-4a83-982c-93035ae664be@ya.ru','Art','user',NULL,0,1,0),(16,'loginb779147d-e44b-4e8a-88e6-22f592aaffeb','argon2$argon2id$v=19$m=102400,t=2,p=8$RXpwbWlKSk9TTDdxR09LVksyV1NCYw$8nPXM9o7WAPzuj+SBWKMdmfr0bNjSdQs+isYe+lg3Y8','emaildf9786bd-e996-4097-acfa-78346a450733@ya.ru','Art','user','2025-04-25 16:08:34',0,1,0),(17,'login8f73ddd7-88e8-4296-ae3a-6b2fd331a58b','argon2$argon2id$v=19$m=102400,t=2,p=8$YXNjRTRDTjJSQ0FxZnJMbXhmTkpMYw$Jci4LuNpgM3WANxUL7MUAJEIuleeuwI3iJhxTwfKL1Y','email99192607-80de-408e-addb-63f60a1fa6ed@ya.ru','Art','user','2025-04-25 16:10:26',0,1,0),(18,'login7e07c075-fd35-4cdd-98ac-95a53e01e33aTutut','argon2$argon2id$v=19$m=102400,t=2,p=8$a0gxYUZodVRMeEdqZXJKNmxhUTF2dg$RsRmAVfSb38thFbs+Y0sRmsi57zrC7VEsWHT/onKSss','emaila0dd9aa3-6f66-4932-ac41-165374cd797c@ya.ru','Art','user','2025-04-25 16:13:12',0,1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-25 21:15:38
