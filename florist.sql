/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 8.0.26 : Database - florist
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

/*Table structure for table `authorities` */

DROP TABLE IF EXISTS `authorities`;

CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  KEY `fk_authorities_users` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `authorities` */

insert  into `authorities`(`username`,`authority`) values 
('admin','ROLE_ADMIN'),
('ROLE_ASSISTANT','ROLE_ASSISTANT'),
('assist','ROLE_ASSISTANT');

/*Table structure for table `orderbill` */

DROP TABLE IF EXISTS `orderbill`;

CREATE TABLE `orderbill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` int DEFAULT NULL,
  `payment` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL COMMENT 'ADVANCE, NOT_ADVANCE',
  PRIMARY KEY (`id`),
  KEY `fk_order_orderbill` (`order_no`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `orderbill` */

insert  into `orderbill`(`id`,`order_no`,`payment`,`date`,`type`) values 
(1,2,0,'2021-10-30','ADVANCE'),
(2,3,5000,'2021-11-06','ADVANCE'),
(3,4,65000,'2021-11-06','ADVANCE'),
(4,3,45000,'2021-11-06','NOT_ADVANCE');

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
  KEY `fk_orderitem_item` (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `orderitem` */

insert  into `orderitem`(`id`,`name`,`actual_amount`,`adjusted_amount`,`order_id`,`item_id`) values 
(1,'test',0,0,2,1),
(3,'Hand Polished Wooden Casket Package (W.K)',65000,50000,3,2),
(4,'Flower Wreath',0,0,3,3),
(5,'Funeral Hearse',0,0,3,4),
(6,'Funeral Dress',0,0,3,5),
(7,'Funeral Pyre',0,0,3,6),
(8,'Lowering Device',0,0,3,7),
(9,'Funeral Parlors Complex',0,0,3,8),
(10,'Deliver',0,0,3,9),
(11,'Other',0,0,3,10),
(12,'Hand Polished Wooden Casket Package (W.K)',65000,65000,4,2),
(13,'Flower Wreath',0,0,4,3),
(14,'Funeral Hearse',0,0,4,4),
(15,'Funeral Dress',0,0,4,5),
(16,'Funeral Pyre',0,0,4,6),
(17,'Lowering Device',0,0,4,7),
(18,'Funeral Parlors Complex',0,0,4,8),
(19,'Deliver',0,0,4,9),
(20,'Other',0,0,4,10),
(21,'Hand Polished Wooden Casket Package (W.K)',65000,65000,5,2),
(22,'Flower Wreath',0,0,5,3),
(23,'Funeral Hearse',0,0,5,4),
(24,'Funeral Dress',0,0,5,5),
(25,'Funeral Pyre',0,0,5,6),
(26,'Lowering Device',0,0,5,7),
(27,'Funeral Parlors Complex',0,0,5,8),
(28,'Deliver',0,0,5,9),
(29,'Other',0,0,5,10);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) DEFAULT NULL,
  `manual_order_no` varchar(50) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `religion` varchar(50) DEFAULT NULL,
  `nic_no` varchar(20) DEFAULT NULL,
  `telephone_no` varchar(20) DEFAULT NULL,
  `dead_person_name` varchar(50) DEFAULT NULL,
  `funeral_date` date DEFAULT NULL,
  `cemetry` varchar(50) DEFAULT NULL,
  `cremation_burrial` varchar(50) DEFAULT NULL COMMENT 'CREMATION, BURRIAL',
  `bill_to` varchar(500) DEFAULT NULL,
  `package_id` int DEFAULT NULL,
  `pay_mode` varchar(20) DEFAULT NULL COMMENT 'CREDIT',
  `order_status` varchar(20) DEFAULT NULL COMMENT 'PROCESSING, COMPLETED, CANCELLED',
  `bill_status` varchar(20) DEFAULT NULL COMMENT 'PAID, LATE_PAID, UN_PAID',
  `amount` double DEFAULT NULL,
  `past_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_package` (`package_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

insert  into `orders`(`id`,`order_no`,`manual_order_no`,`order_date`,`title`,`name`,`address`,`religion`,`nic_no`,`telephone_no`,`dead_person_name`,`funeral_date`,`cemetry`,`cremation_burrial`,`bill_to`,`package_id`,`pay_mode`,`order_status`,`bill_status`,`amount`,`past_date`) values 
(2,'ORD000000002','0001','2021-10-30','test','test','test','test','test','test','test','2021-10-29','test','test','test',1,'test','test','test',0,'2021-10-15');

/*Table structure for table `package` */

DROP TABLE IF EXISTS `package`;

CREATE TABLE `package` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `package` */

insert  into `package`(`id`,`name`,`amount`) values 
(4,'Hand Polished Wooden Casket Package (P.M)',55000),
(3,'Covid-19 Package',25000),
(5,'Hand Polished Wooden Casket Package (W.K)',65000),
(6,'Hand Polished Wooden Casket Package (B.W.K)',85000),
(7,'Spray Finished Wooden Casket (P.M)',110000),
(8,'Spray Finished Wooden Casket (R.K)',145000),
(9,'Spray Finished Wooden Casket (D.S.R.K)',165000),
(10,'Spray Finished Wooden Casket (Plain Double)',225000),
(11,'Spray Finished Wooden Casket (H.M.K)',250000),
(12,'Spray Finished Wooden Casket (Plain Spray)',275000),
(13,'VIP Wooden Casket Package',375000),
(14,'VIP White Wooden Casket Package',425000),
(15,'VIP Black Wooden Casket Package',425000),
(16,'VIP Gold Wooden Casket Package',450000),
(17,'VIP Teak Wooden Casket Package',500000),
(18,'VIP Nadun Wooden Casket Package',1000000);

/*Table structure for table `packageitem` */

DROP TABLE IF EXISTS `packageitem`;

CREATE TABLE `packageitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemname` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `packageitem` */

insert  into `packageitem`(`id`,`itemname`,`amount`) values 
(11,'Covid-19 Package',25000),
(2,'Hand Polished Wooden Casket Package (W.K)',65000),
(30,'Funeral Parlors Complex',0),
(29,'Lowering Device',0),
(28,'Funeral Pyre',0),
(27,'Funeral Hearse',0),
(26,'Flower Wreath',0),
(12,'Hand Polished Wooden Casket Package (P.M)',55000),
(13,'Hand Polished Wooden Casket Package (B.W.K)',85000),
(14,'Spray Finished Wooden Casket (P.M)',110000),
(15,'Spray Finished Wooden Casket (R.K)',145000),
(16,'Spray Finished Wooden Casket (D.S.R.K)',165000),
(17,'Spray Finished Wooden Casket (Plain Double)',225000),
(18,'Spray Finished Wooden Casket (H.M.K)',250000),
(19,'Spray Finished Wooden Casket (Plain Spray)',275000),
(20,'VIP Wooden Casket Package',375000),
(21,'VIP White Wooden Casket Package',425000),
(22,'VIP Black Wooden Casket Package',425000),
(23,'VIP Gold Wooden Casket Package',450000),
(24,'VIP Teak Wooden Casket Package',500000),
(25,'VIP Nadun Wooden Casket Package',1000000),
(31,'Deliver',0),
(32,'Other',0),
(33,'Funeral Dress',0);

/*Table structure for table `packitm` */

DROP TABLE IF EXISTS `packitm`;

CREATE TABLE `packitm` (
  `id` int NOT NULL AUTO_INCREMENT,
  `packageid` int DEFAULT NULL,
  `packageitemid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_package_packitm` (`packageid`),
  KEY `fk_package_item` (`packageitemid`)
) ENGINE=MyISAM AUTO_INCREMENT=154 DEFAULT CHARSET=latin1;

/*Data for the table `packitm` */

insert  into `packitm`(`id`,`packageid`,`packageitemid`) values 
(1,1,1),
(2,2,2),
(3,2,3),
(4,2,4),
(5,2,5),
(6,2,6),
(7,2,7),
(8,2,8),
(9,2,9),
(11,2,10),
(12,3,11),
(13,3,3),
(14,3,4),
(15,3,9),
(16,3,10),
(27,4,3),
(18,4,12),
(20,4,4),
(21,4,5),
(22,4,6),
(23,4,7),
(24,4,8),
(25,4,9),
(26,4,10),
(28,4,26),
(29,4,27),
(30,4,33),
(31,4,28),
(32,4,29),
(33,4,30),
(34,4,31),
(35,4,32),
(36,5,2),
(37,5,26),
(38,5,27),
(39,5,33),
(40,5,28),
(41,5,29),
(42,5,30),
(43,5,31),
(44,5,32),
(45,6,13),
(46,6,26),
(47,6,27),
(48,6,33),
(49,6,28),
(50,6,30),
(51,6,29),
(52,6,31),
(53,6,32),
(54,7,14),
(55,7,26),
(56,7,27),
(57,7,33),
(58,7,28),
(59,7,30),
(60,7,29),
(61,7,31),
(62,7,32),
(63,8,15),
(64,8,26),
(65,8,27),
(66,8,28),
(67,8,33),
(68,8,30),
(69,8,29),
(70,8,31),
(71,8,32),
(72,9,16),
(73,10,17),
(74,10,26),
(75,10,27),
(76,10,33),
(77,10,28),
(78,10,30),
(79,10,29),
(80,10,31),
(81,10,32),
(82,11,18),
(83,11,26),
(84,11,27),
(85,11,33),
(86,11,28),
(87,11,30),
(88,11,29),
(89,11,31),
(90,11,32),
(91,12,19),
(92,12,26),
(93,12,27),
(94,12,33),
(95,12,28),
(96,12,30),
(97,12,29),
(98,12,31),
(99,12,32),
(100,13,20),
(101,13,26),
(102,13,27),
(103,13,33),
(104,13,28),
(105,13,30),
(106,13,29),
(107,13,31),
(108,13,32),
(109,14,21),
(110,14,26),
(111,14,27),
(112,14,33),
(113,14,28),
(114,14,30),
(115,14,29),
(116,14,31),
(117,14,32),
(118,15,22),
(119,15,26),
(120,15,27),
(121,15,33),
(122,15,28),
(123,15,30),
(124,15,29),
(125,15,31),
(126,15,32),
(127,16,23),
(128,16,26),
(129,16,27),
(130,16,33),
(131,16,28),
(132,16,30),
(133,16,29),
(134,16,31),
(135,16,32),
(136,17,24),
(137,17,26),
(138,17,27),
(139,17,33),
(140,17,28),
(141,17,30),
(142,17,29),
(143,17,31),
(144,17,32),
(145,18,25),
(146,18,26),
(147,18,27),
(148,18,33),
(149,18,28),
(150,18,30),
(151,18,29),
(152,18,31),
(153,18,32);

/*Table structure for table `printjob` */

DROP TABLE IF EXISTS `printjob`;

CREATE TABLE `printjob` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL COMMENT 'PROCESSING, COMPLETED',
  PRIMARY KEY (`id`),
  KEY `fk_printjob_order` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `printjob` */

insert  into `printjob`(`id`,`order_id`,`status`) values 
(1,2,'test'),
(2,3,'PROCESSING'),
(3,4,'PROCESSING'),
(4,5,'PROCESSING');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`username`,`password`,`enabled`) values 
('admin','$2a$10$/.wR6GqlNdnzHhBfH..Jd.Dvg1IsQXBrC/8oIta9/eEolDMf/mY/m',1),
('assist','$2a$10$lAXUZJ6xb0Zhh8bQPNiuEe1eqF2yXFwGhhpur4soEgC1IIBjWvyrO',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
