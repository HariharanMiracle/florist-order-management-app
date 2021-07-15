/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.21 : Database - florist
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`florist` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `florist`;

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_type` varchar(50) DEFAULT NULL,
  `function` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `jobs` */

/*Table structure for table `orderbill` */

DROP TABLE IF EXISTS `orderbill`;

CREATE TABLE `orderbill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` int DEFAULT NULL,
  `payment` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL COMMENT 'ADVANCE, NOT_ADVANCE',
  PRIMARY KEY (`id`),
  KEY `fk_order_orderbill` (`order_no`),
  CONSTRAINT `fk_order_orderbill` FOREIGN KEY (`order_no`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `orderbill` */

insert  into `orderbill`(`id`,`order_no`,`payment`,`date`,`type`) values 
(1,1,200,'2021-07-11','ADVANCE');

/*Table structure for table `orderitem` */

DROP TABLE IF EXISTS `orderitem`;

CREATE TABLE `orderitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `actual_amount` double DEFAULT NULL,
  `adjusted_amount` double DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_orderitem` (`order_id`),
  KEY `fk_orderitem_item` (`item_id`),
  CONSTRAINT `fk_order_orderitem` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderitem_item` FOREIGN KEY (`item_id`) REFERENCES `packageitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `orderitem` */

insert  into `orderitem`(`id`,`name`,`actual_amount`,`adjusted_amount`,`order_id`,`item_id`) values 
(1,'test-item-2',600,600,1,2),
(2,'test-item-3',400,400,1,3);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `manual_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `title` varchar(10) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `religion` varchar(50) DEFAULT NULL,
  `nic_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `telephone_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dead_person_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `funeral_date` date DEFAULT NULL,
  `cemetry` varchar(50) DEFAULT NULL,
  `cremation_burrial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'CREMATION, BURRIAL',
  `bill_to` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `package_id` int DEFAULT NULL,
  `pay_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'CREDIT',
  `order_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'PROCESSING, COMPLETED, CANCELLED',
  `bill_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'PAID, LATE_PAID, UN_PAID',
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_package` (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `orders` */

insert  into `orders`(`id`,`order_no`,`manual_order_no`,`order_date`,`title`,`name`,`address`,`religion`,`nic_no`,`telephone_no`,`dead_person_name`,`funeral_date`,`cemetry`,`cremation_burrial`,`bill_to`,`package_id`,`pay_mode`,`order_status`,`bill_status`,`amount`) values 
(1,'ORD0000000001','ORD0001','2021-07-11','title-test','name-test','address-test','religion-test','nic-test','telephone-test','dead-name-test','2021-07-14','borella','CREMATION','bill-test',1,'CREDIT','PROCESSING','UN_PAID',1000);

/*Table structure for table `package` */

DROP TABLE IF EXISTS `package`;

CREATE TABLE `package` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `package` */

insert  into `package`(`id`,`name`,`amount`) values 
(1,'Silver',1000),
(2,'Gold',0),
(3,'Bronze',0);

/*Table structure for table `packageitem` */

DROP TABLE IF EXISTS `packageitem`;

CREATE TABLE `packageitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemname` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `packageitem` */

insert  into `packageitem`(`id`,`itemname`,`amount`) values 
(1,'test-item-1',500),
(2,'test-item-2',600),
(3,'test-item-3',400),
(4,'test-item-4',2000);

/*Table structure for table `packitm` */

DROP TABLE IF EXISTS `packitm`;

CREATE TABLE `packitm` (
  `id` int NOT NULL AUTO_INCREMENT,
  `packageid` int DEFAULT NULL,
  `packageitemid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_package_packitm` (`packageid`),
  KEY `fk_package_item` (`packageitemid`),
  CONSTRAINT `fk_package_item` FOREIGN KEY (`packageitemid`) REFERENCES `packageitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_package_packitm` FOREIGN KEY (`packageid`) REFERENCES `package` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `packitm` */

insert  into `packitm`(`id`,`packageid`,`packageitemid`) values 
(1,1,2),
(2,1,3);

/*Table structure for table `printjob` */

DROP TABLE IF EXISTS `printjob`;

CREATE TABLE `printjob` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL COMMENT 'PROCESSING, COMPLETED',
  PRIMARY KEY (`id`),
  KEY `fk_printjob_order` (`order_id`),
  CONSTRAINT `fk_printjob_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `printjob` */

insert  into `printjob`(`id`,`order_id`,`status`) values 
(1,1,'PROCESSING');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT 'ADMIN, ASSISTANT',
  `active` tinyint(1) DEFAULT NULL COMMENT '0 => inactive, 1 => active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`name`,`type`,`active`) values 
(5,'admin','tlac+4mlJzfIHbGZgKiVNQ==','ADMIN','Admin',1),
(6,'Assistant','61t1t9TFxaWsweIMohLe0Q==','ASSISTANT','Assistant',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
