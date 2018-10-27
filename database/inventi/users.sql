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

-- Volcando estructura para tabla inventi.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(32) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `cedula` int(15) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `nick` varchar(50) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `cargo` int(2) NOT NULL DEFAULT '0',
  `piloto` int(2) NOT NULL DEFAULT '0',
  `estado` int(2) NOT NULL,
  `supervisor` int(32) NOT NULL,
  `novedad` int(32) DEFAULT '0',
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `rol` int(2) NOT NULL DEFAULT '0',
  `ejecutivo_de_experiencia` int(32) NOT NULL DEFAULT '0',
  `genero` varchar(10) DEFAULT '0',
  `avatar` int(32) NOT NULL DEFAULT '0',
  `more` text,
  `location_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`cedula`),
  UNIQUE KEY `user` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
