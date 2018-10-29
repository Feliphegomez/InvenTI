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

-- Volcando estructura para tabla inventi.areas
CREATE TABLE IF NOT EXISTS `areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Volcando datos para la tabla inventi.areas: ~6 rows (aproximadamente)
DELETE FROM `areas`;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` (`id`, `name`) VALUES
	(1, 'Desconocida'),
	(2, 'Administrativo'),
	(3, 'Bodega'),
	(4, 'Tecnologia'),
	(5, 'Comercial'),
	(7, 'Diseño');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.articles
CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `user_id` int(32) unsigned zerofill DEFAULT '00000000000000000000000000000000',
  `content` varchar(255) NOT NULL,
  `create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `area_id` (`area_id`),
  KEY `location_id` (`location_id`),
  KEY `FK_articles_users` (`user_id`),
  CONSTRAINT `FK_articles_areas` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `FK_articles_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `FK_articles_locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `FK_articles_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.articles: ~2 rows (aproximadamente)
DELETE FROM `articles`;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` (`id`, `category_id`, `area_id`, `location_id`, `user_id`, `content`, `create`, `change`) VALUES
	(1, 1, 1, 1, 00000000000000000000000000000001, 'Cedula: \nNombre: NN\nUser: NN\nCargo: NN\nPiloto: Monteverde\nEstado: NN\nSupervisor: NN\nRol: Supervisores\nEjecutivo_de_experiencia: NN\nGenero: NN\nCuadrilla: NN\n', '2018-10-26 15:44:39', '2018-10-29 08:15:10'),
	(2, 3, 5, 1, 00000000000000000000000000000003, 'Cedula: \nNombre: Karen Montoya Betancur\nUser: karen.montoya\nCargo: Coordinadora Comercial\nPiloto: Monteverde\nEstado: Activo\nSupervisor: Rodrigo\nRol: Coordinadora \nEjecutivo_de_experiencia: Jefe del Jefe \nGenero: FEM\nCuadrilla: 0', '2018-10-26 16:39:27', '2018-10-29 08:18:15');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.barcodes
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

-- Volcando estructura para tabla inventi.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `permission_id` int(11) DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`id`),
  KEY `KEY` (`id`),
  KEY `FK_cargos_permission` (`permission_id`),
  CONSTRAINT `FK_cargos_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf16 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla inventi.cargos: ~3 rows (aproximadamente)
DELETE FROM `cargos`;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` (`id`, `name`, `permission_id`) VALUES
	(1, 'Administrador', 1),
	(2, 'Usuario Estandar', 2),
	(3, 'Coordinadora', 2);
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla inventi.categories: ~3 rows (aproximadamente)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`) VALUES
	(1, 'Hardware'),
	(2, 'Software'),
	(3, 'Otros');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.comments
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

-- Volcando estructura para tabla inventi.estados
CREATE TABLE IF NOT EXISTS `estados` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`id`),
  KEY `KEY` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf16 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla inventi.estados: ~3 rows (aproximadamente)
DELETE FROM `estados`;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` (`id`, `name`) VALUES
	(1, 'Activo'),
	(2, 'Retirado'),
	(3, 'Vacaciones');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.events
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

-- Volcando estructura para tabla inventi.jefes
CREATE TABLE IF NOT EXISTS `jefes` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `cedula` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla inventi.jefes: ~1 rows (aproximadamente)
DELETE FROM `jefes`;
/*!40000 ALTER TABLE `jefes` DISABLE KEYS */;
INSERT INTO `jefes` (`id`, `cedula`, `name`, `user`, `cargo`) VALUES
	(1, 10101010, 'Rodrigo', NULL, 'Gerencia');
/*!40000 ALTER TABLE `jefes` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.locations
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Volcando datos para la tabla inventi.locations: ~2 rows (aproximadamente)
DELETE FROM `locations`;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` (`id`, `name`) VALUES
	(1, 'Central'),
	(2, 'Robledo');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `permisos` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`id`),
  KEY `KEY` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla inventi.permissions: ~2 rows (aproximadamente)
DELETE FROM `permissions`;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `permisos`) VALUES
	(1, 'Administrador', '{"export":{"quiz":true},"import":{"people":true,"indicators":true},people:{"create":true,"view":true,"edit":true,"delete":true},"calendary":{"create":true,"view":true,"edit":true,"delete":true,"categories":{"view":true,"create":true,"edit":true,"delete":true}},"forum":{"create":true,"view":true,"response":true,"edit":true,"delete":true,"categories":{"view":true,"create":true,"edit":true,"delete":true}},"comments":{"view":true,"create":true,"response":true,"edit":true,"delete":true},"articles":{"view":true,"edit":true,"history":true,"create":true,"delete":true,"categories":{"view":true,"create":true,"edit":true,"delete":true}},"ecards":{"view":true,"edit":true,"history":true,"create":true,"delete":true,"categories":{"view":true,"create":true,"edit":true,"delete":true}},"alerts":{"view":true,"history":true,"create":true,"edit":true,"delete":true},inventary:{"view":true,"history":true,"create":true,"edit":true,"delete":true},"quiz":{"view":true,"create":true,"edit":true,"delete":true,"history":true},"indicators":{"view":true},"stopwatch":{"view":true},"devices":{"view":true}}'),
	(2, 'Usuario Estandar', '{"export":{"quiz":false},"import":{"people":false,"indicators":false},people:{"create":false,"view":true,"edit":false,"delete":false},"calendary":{"create":true,"view":true,"edit":false,"delete":false,"categories":{"view":true,"create":false,"edit":false,"delete":false}},"forum":{"create":true,"view":true,"response":true,"edit":false,"delete":false,"categories":{"view":true,"create":true,"edit":false,"delete":false}},"comments":{"view":true,"create":true,"response":false,"edit":false,"delete":false},"articles":{"view":true,"edit":false,"history":true,"create":false,"delete":false,"categories":{"view":true,"create":false,"edit":false,"delete":false}},"ecards":{"view":true,"edit":false,"history":true,"create":false,"delete":false,"categories":{"view":true,"create":false,"edit":false,"delete":false}},"alerts":{"view":true,"history":true,"create":false,"edit":false,"delete":false},inventary:{"view":true,"history":true,"create":false,"edit":false,"delete":false},"quiz":{"view":true,"create":false,"edit":false,"delete":false,"history":false},"indicators":{"view":true},"stopwatch":{"view":true},"devices":{"view":true}}');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.pilots
CREATE TABLE IF NOT EXISTS `pilots` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`id`),
  KEY `KEY` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla inventi.pilots: ~2 rows (aproximadamente)
DELETE FROM `pilots`;
/*!40000 ALTER TABLE `pilots` DISABLE KEYS */;
INSERT INTO `pilots` (`id`, `name`) VALUES
	(1, 'Monteverde'),
	(2, 'Nobotia');
/*!40000 ALTER TABLE `pilots` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.rols
CREATE TABLE IF NOT EXISTS `rols` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`id`),
  KEY `KEY` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf16 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla inventi.rols: ~5 rows (aproximadamente)
DELETE FROM `rols`;
/*!40000 ALTER TABLE `rols` DISABLE KEYS */;
INSERT INTO `rols` (`id`, `name`) VALUES
	(1, 'Administrador'),
	(2, 'Rol Estandar'),
	(3, 'Guadaño'),
	(4, 'Jardinero'),
	(5, 'Conductor');
/*!40000 ALTER TABLE `rols` ENABLE KEYS */;

-- Volcando estructura para tabla inventi.serials
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

-- Volcando datos para la tabla inventi.serials: ~8 rows (aproximadamente)
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
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `serial_usage` 
) ENGINE=MyISAM;

-- Volcando estructura para tabla inventi.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(32) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `cedula` int(15) NOT NULL,
  `nombre` varchar(150) NOT NULL DEFAULT 'Sin nombre',
  `nick` varchar(50) NOT NULL DEFAULT 'Desconocido',
  `hash` varchar(255) NOT NULL DEFAULT '0',
  `cargo_id` int(2) DEFAULT '0' COMMENT 'appointment',
  `pilot_id` int(2) DEFAULT '0',
  `estado_id` int(2) DEFAULT '0',
  `rol_id` int(2) DEFAULT '0',
  `location_id` int(11) DEFAULT '0',
  `supervisor` int(32) DEFAULT '0',
  `novedad` int(32) DEFAULT '0',
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `ejecutivo_de_experiencia` int(32) DEFAULT '0',
  `genero` varchar(10) DEFAULT '0',
  `avatar` int(32) DEFAULT '0',
  `more` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`cedula`),
  UNIQUE KEY `user` (`nick`),
  KEY `FK_users_cargos` (`cargo_id`),
  KEY `FK_users_pilots` (`pilot_id`),
  KEY `FK_users_estados` (`estado_id`),
  KEY `FK_users_rols` (`rol_id`),
  KEY `FK_users_locations` (`location_id`),
  CONSTRAINT `FK_users_cargos` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`id`),
  CONSTRAINT `FK_users_estados` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`),
  CONSTRAINT `FK_users_locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `FK_users_pilots` FOREIGN KEY (`pilot_id`) REFERENCES `pilots` (`id`),
  CONSTRAINT `FK_users_rols` FOREIGN KEY (`rol_id`) REFERENCES `rols` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf16;

-- Volcando datos para la tabla inventi.users: ~3 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `cedula`, `nombre`, `nick`, `hash`, `cargo_id`, `pilot_id`, `estado_id`, `rol_id`, `location_id`, `supervisor`, `novedad`, `fecha_nacimiento`, `fecha_ingreso`, `ejecutivo_de_experiencia`, `genero`, `avatar`, `more`) VALUES
	(00000000000000000000000000000001, 0, 'Sin definir', 'Desconocido', '0123456789', 1, 1, 1, 0, 0, 2, 0, NULL, NULL, 0, '0', 0, NULL),
	(00000000000000000000000000000002, 1, 'Administrador', 'admin', 'admin', 1, 1, 1, 1, 1, 0, 0, '1993-02-10', '2018-09-17', 0, '1', 0, NULL),
	(00000000000000000000000000000003, 1035858418, 'Karen Montoya Betancur', 'karen.montoya', 'Medellin2018', 1, 1, 1, 0, 0, 0, 0, NULL, NULL, 0, 'MAS', 0, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para vista inventi.serial_usage
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `serial_usage`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `serial_usage` AS select `serials`.`name` AS `name`,count(`serials`.`name`) AS `count`,`serials`.`total` AS `total`,`serials`.`serial` AS `serial` from (`serials` join `article_serials`) where (`serials`.`id` = `article_serials`.`serial_id`) group by `serials`.`name` order by `count` desc,`serials`.`name`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
