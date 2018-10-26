-- --------------------------------------------------------
-- Host:                         192.168.1.20
-- Versión del servidor:         5.7.24-0ubuntu0.16.04.1 - (Ubuntu)
-- SO del servidor:              Linux
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para inventi
CREATE DATABASE IF NOT EXISTS `inventi` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `inventi`;

-- Volcando estructura para tabla inventi.areas
DROP TABLE IF EXISTS `areas`;
CREATE TABLE IF NOT EXISTS `areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Volcando datos para la tabla inventi.areas: ~6 rows (aproximadamente)
DELETE FROM `areas`;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` (`id`, `name`, `icon`) VALUES
	(1, 'Desconocida', NULL),
	(2, 'Administrativo', NULL),
	(3, 'Bodega', NULL),
	(4, 'Tecnologia', NULL),
	(5, 'Comercial', NULL),
	(6, 'Diseño', NULL);
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.articles
DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `people_id` varchar(250) DEFAULT '0',
  `content` varchar(255) NOT NULL,
  `create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `area_id` (`area_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `FK_articles_areas` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `FK_articles_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `FK_articles_locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.articles: ~1 rows (aproximadamente)
DELETE FROM `articles`;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` (`id`, `category_id`, `area_id`, `location_id`, `people_id`, `content`, `create`, `change`) VALUES
	(1, 1, 1, 1, '00000000000000000000000000000002', 'Cedula: \nNombre: NN\nUser: NN\nCargo: NN\nPiloto: Monteverde\nEstado: NN\nSupervisor: NN\nRol: Supervisores\nEjecutivo_de_experiencia: NN\nGenero: NN\nCuadrilla: NN\n', '2018-10-26 15:44:39', '2018-10-26 15:44:39'),
	(2, 3, 5, 1, '00000000000000000000000000000002', 'Cedula: \nNombre: Karen Montoya Betancur\nUser: karen.montoya\nCargo: Coordinadora Comercial\nPiloto: Monteverde\nEstado: Activo\nSupervisor: Rodrigo\nRol: Coordinadora \nEjecutivo_de_experiencia: Jefe del Jefe \nGenero: FEM\nCuadrilla: 0', '2018-10-26 16:39:27', '2018-10-26 16:39:27');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.barcodes
DROP TABLE IF EXISTS `barcodes`;
CREATE TABLE IF NOT EXISTS `barcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `hex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `bin` varbinary(255) NOT NULL,
  `create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_barcodes_articles` (`article_id`),
  CONSTRAINT `FK_barcodes_articles` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.barcodes: ~0 rows (aproximadamente)
DELETE FROM `barcodes`;
/*!40000 ALTER TABLE `barcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `barcodes` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.categories: ~2 rows (aproximadamente)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `icon`) VALUES
	(1, 'Hardware', NULL),
	(2, 'Software', NULL),
	(3, 'Otros', NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.comments
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `post_id` (`article_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.comments: ~0 rows (aproximadamente)
DELETE FROM `comments`;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.countries
DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `shape` polygon NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.countries: ~0 rows (aproximadamente)
DELETE FROM `countries`;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.events
DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.events: ~0 rows (aproximadamente)
DELETE FROM `events`;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.locations
DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Volcando datos para la tabla inventi.locations: ~2 rows (aproximadamente)
DELETE FROM `locations`;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` (`id`, `name`, `icon`) VALUES
	(1, 'Central', NULL),
	(2, 'Robledo', NULL);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.serials
DROP TABLE IF EXISTS `serials`;
CREATE TABLE IF NOT EXISTS `serials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `article_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `serial` text NOT NULL,
  `create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(1000) DEFAULT ' ',
  PRIMARY KEY (`id`),
  KEY `FK_serials_articles` (`article_id`),
  CONSTRAINT `FK_serials_articles` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.serials: ~5 rows (aproximadamente)
DELETE FROM `serials`;
/*!40000 ALTER TABLE `serials` DISABLE KEYS */;
INSERT INTO `serials` (`id`, `name`, `article_id`, `total`, `serial`, `create`, `change`, `notes`) VALUES
	(1, 'CPU', 1, 1, 'Sin serial', '2018-10-26 15:49:42', '2018-10-26 15:52:18', 'CPU Color Negro MaxiTech'),
	(2, 'Procesador', 1, 1, 'NA', '2018-10-26 16:01:15', '2018-10-26 16:01:15', 'Intel(R) Pentium(R) Dual CPU E2200 @ 2.20GHz 2.19GHz'),
	(3, 'Id. Producto (Windows)', 1, 1, '00426-OEM-8992662-00010', '2018-10-26 16:02:13', '2018-10-26 16:02:13', 'No se recibe licencia física.'),
	(4, 'Windows', 1, 1, 'NA', '2018-10-26 16:03:02', '2018-10-26 16:03:02', 'WIN7 x86'),
	(5, 'Monitor LG FLATRON W1943C-PF', 1, 1, '012NDPH9440', '2018-10-26 16:05:43', '2018-10-26 16:05:43', 'Model: W1943CV\nFCC ID: BEJW1943SV\nAdaptador Corriente: HANED607408015837'),
	(7, 'Teclado', 1, 1, 'DBKB6912140901773', '2018-10-26 16:24:01', '2018-10-26 16:24:01', 'Argom ARG-KB-6912\nUSB'),
	(8, 'Mouse', 1, 0, '33C83039604258', '2018-10-26 16:25:15', '2018-10-26 16:25:15', 'USB\nOptical\nM/N: NetScroll 120'),
	(9, 'MAC ', 2, 1, 'NN', '2018-10-26 16:40:05', '2018-10-26 16:40:05', 'Mac Escritorio con mouse, teclado, monitor incluido, y adaptador de corriente.');
/*!40000 ALTER TABLE `serials` ENABLE KEYS */;

-- Volcando estructura para vista inventi.serial_usage
DROP VIEW IF EXISTS `serial_usage`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `serial_usage` 
) ENGINE=MyISAM;

-- Volcando estructura para vista inventi.serial_usage
DROP VIEW IF EXISTS `serial_usage`;
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `serial_usage`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `serial_usage` AS select `serials`.`name` AS `name`,count(`serials`.`name`) AS `count`,`serials`.`total` AS `total`,`serials`.`serial` AS `serial` from (`serials` join `article_serials`) where (`serials`.`id` = `article_serials`.`serial_id`) group by `serials`.`name` order by `count` desc,`serials`.`name`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
