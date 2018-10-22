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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
