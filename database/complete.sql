-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.36-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para inventi
CREATE DATABASE IF NOT EXISTS `inventi` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `inventi`;

-- Volcando estructura para tabla inventi.articles
DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `articles_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.articles: ~5 rows (aproximadamente)
DELETE FROM `articles`;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` (`id`, `category_id`, `content`) VALUES
	(1, 1, 'Lapton 1la'),
	(2, 1, 'Pc 1 Nuevo'),
	(8, 2, 'New');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.article_serials
DROP TABLE IF EXISTS `article_serials`;
CREATE TABLE IF NOT EXISTS `article_serials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `serial_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`article_id`),
  KEY `tag_id` (`serial_id`),
  CONSTRAINT `article_serials_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`),
  CONSTRAINT `article_serials_ibfk_2` FOREIGN KEY (`serial_id`) REFERENCES `serials` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.article_serials: ~3 rows (aproximadamente)
DELETE FROM `article_serials`;
/*!40000 ALTER TABLE `article_serials` DISABLE KEYS */;
INSERT INTO `article_serials` (`id`, `article_id`, `serial_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(4, 2, 2);
/*!40000 ALTER TABLE `article_serials` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.barcodes
DROP TABLE IF EXISTS `barcodes`;
CREATE TABLE IF NOT EXISTS `barcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `hex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `bin` varbinary(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_barcodes_articles` (`article_id`),
  CONSTRAINT `FK_barcodes_articles` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.barcodes: ~0 rows (aproximadamente)
DELETE FROM `barcodes`;
/*!40000 ALTER TABLE `barcodes` DISABLE KEYS */;
INSERT INTO `barcodes` (`id`, `article_id`, `hex`, `bin`) VALUES
	(1, 1, '00ff01', '\0�');
/*!40000 ALTER TABLE `barcodes` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.categories: ~2 rows (aproximadamente)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `icon`) VALUES
	(1, 'Hardware', NULL),
	(2, 'Software', NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.comments
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`article_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.comments: ~4 rows (aproximadamente)
DELETE FROM `comments`;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `article_id`, `message`) VALUES
	(1, 1, 'Comment1'),
	(2, 1, 'Comment2'),
	(3, 2, 'Comment3'),
	(4, 2, 'Comment4');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.countries
DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `shape` polygon NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.countries: ~2 rows (aproximadamente)
DELETE FROM `countries`;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` (`id`, `name`, `shape`) VALUES
	(1, 'Left', _binary 0x00000000010300000001000000050000000000000000003E4000000000000024400000000000004440000000000000444000000000000034400000000000004440000000000000244000000000000034400000000000003E400000000000002440),
	(2, 'Right', _binary 0x000000000103000000010000000500000000000000008051400000000000002440000000000000544000000000000044400000000000004E4000000000000044400000000000004940000000000000344000000000008051400000000000002440);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.events
DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.events: ~1 rows (aproximadamente)
DELETE FROM `events`;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`id`, `name`, `datetime`) VALUES
	(1, 'Backup', '2019-01-01 13:01:01');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.serials
DROP TABLE IF EXISTS `serials`;
CREATE TABLE IF NOT EXISTS `serials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `total` int(11) NOT NULL,
  `serial` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.serials: ~2 rows (aproximadamente)
DELETE FROM `serials`;
/*!40000 ALTER TABLE `serials` DISABLE KEYS */;
INSERT INTO `serials` (`id`, `name`, `total`, `serial`) VALUES
	(1, 'Placa base', 1, 'adadad-adadad'),
	(2, 'mouse', 1, 'ggs6dg56dg-sdg6+1d56g1-sdg1d6');
/*!40000 ALTER TABLE `serials` ENABLE KEYS */;

-- Volcando estructura para vista inventi.serial_usage
DROP VIEW IF EXISTS `serial_usage`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `serial_usage` (
	`name` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`count` BIGINT(21) NOT NULL,
	`total` INT(11) NOT NULL,
	`serial` TEXT NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para tabla inventi.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `location` point DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.users: ~2 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `location`) VALUES
	(1, 'user1', 'pass1', NULL),
	(2, 'user2', 'pass2', NULL),
	(3, 'admin', 'admin', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para vista inventi.serial_usage
DROP VIEW IF EXISTS `serial_usage`;
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `serial_usage`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `serial_usage` AS select `name`, count(`name`) AS `count`, `total`, `serial` from `serials`, `article_serials` where `serials`.`id` = `article_serials`.`serial_id` group by `name` order by `count` desc, `name` ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
