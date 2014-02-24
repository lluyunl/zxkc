-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: zxkc
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `zxkc_dm_ck`
--

DROP TABLE IF EXISTS `zxkc_dm_ck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zxkc_dm_ck` (
  `CKDM` varchar(10) NOT NULL,
  `CKMC` varchar(50) NOT NULL,
  `DR` int(11) NOT NULL,
  `TS` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zxkc_dm_ck`
--

LOCK TABLES `zxkc_dm_ck` WRITE;
/*!40000 ALTER TABLE `zxkc_dm_ck` DISABLE KEYS */;
INSERT INTO `zxkc_dm_ck` VALUES ('01','one',0,'2014-02-19 19:10:07'),('02','two',0,'2014-02-19 19:10:10'),('03','three',0,'2014-02-19 19:10:12');
/*!40000 ALTER TABLE `zxkc_dm_ck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zxkc_dm_ckyy`
--

DROP TABLE IF EXISTS `zxkc_dm_ckyy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zxkc_dm_ckyy` (
  `CKYY` varchar(25) NOT NULL,
  `CKYYMC` varchar(255) NOT NULL,
  `DR` int(11) NOT NULL,
  `TS` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zxkc_dm_ckyy`
--

LOCK TABLES `zxkc_dm_ckyy` WRITE;
/*!40000 ALTER TABLE `zxkc_dm_ckyy` DISABLE KEYS */;
/*!40000 ALTER TABLE `zxkc_dm_ckyy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zxkc_yw_hpck`
--

DROP TABLE IF EXISTS `zxkc_yw_hpck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zxkc_yw_hpck` (
  `UKEY` varchar(32) NOT NULL,
  `HPBH` varchar(15) NOT NULL,
  `CKYY` varchar(20) NOT NULL,
  `CK` varchar(10) DEFAULT NULL,
  `HPSL` decimal(10,2) DEFAULT NULL,
  `CKSJ` date NOT NULL,
  `BZ` text,
  `DR` int(11) NOT NULL,
  `TS` datetime NOT NULL,
  `XGSJ` datetime DEFAULT NULL,
  `CKR` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UKEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zxkc_yw_hpck`
--

LOCK TABLES `zxkc_yw_hpck` WRITE;
/*!40000 ALTER TABLE `zxkc_yw_hpck` DISABLE KEYS */;
/*!40000 ALTER TABLE `zxkc_yw_hpck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zxkc_yw_hprk`
--

DROP TABLE IF EXISTS `zxkc_yw_hprk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zxkc_yw_hprk` (
  `UKEY` varchar(32) NOT NULL COMMENT '注释',
  `HPBH` varchar(15) NOT NULL COMMENT '货品编号',
  `HPMC` varchar(50) DEFAULT NULL COMMENT '货品名称',
  `GHSMC` varchar(50) DEFAULT NULL COMMENT '供货商名称',
  `SHR` varchar(25) DEFAULT NULL COMMENT '送货人',
  `SHRDH` varchar(25) DEFAULT NULL COMMENT '送货人电话',
  `HPSL` decimal(10,2) NOT NULL COMMENT '货品数量',
  `RKR` varchar(25) NOT NULL COMMENT '入库人',
  `RKSJ` date DEFAULT NULL,
  `BZ` text COMMENT '备注',
  `DR` int(11) NOT NULL,
  `TS` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ck` varchar(10) DEFAULT NULL,
  `XGSJ` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='货品入库表，存储货品入库记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zxkc_yw_hprk`
--

LOCK TABLES `zxkc_yw_hprk` WRITE;
/*!40000 ALTER TABLE `zxkc_yw_hprk` DISABLE KEYS */;
/*!40000 ALTER TABLE `zxkc_yw_hprk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zxkc_yw_hpxx`
--

DROP TABLE IF EXISTS `zxkc_yw_hpxx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zxkc_yw_hpxx` (
  `UKEY` varchar(32) NOT NULL COMMENT '主键',
  `HPBH` int(11) NOT NULL COMMENT '货品编号',
  `HPMC` varchar(50) DEFAULT NULL COMMENT '货品名称',
  `BZGG` varchar(30) DEFAULT NULL COMMENT '包装规格',
  `DW` varchar(10) DEFAULT NULL COMMENT '单位',
  `ZXDW` varchar(10) DEFAULT NULL COMMENT '最小单位',
  `DR` int(11) NOT NULL,
  `TS` datetime NOT NULL,
  `LRR` varchar(30) NOT NULL COMMENT '录入人',
  `XGR` varchar(30) NOT NULL COMMENT '修改人',
  `XGSJ` datetime NOT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='货品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zxkc_yw_hpxx`
--

LOCK TABLES `zxkc_yw_hpxx` WRITE;
/*!40000 ALTER TABLE `zxkc_yw_hpxx` DISABLE KEYS */;
/*!40000 ALTER TABLE `zxkc_yw_hpxx` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-23 21:39:48
