-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.22-MariaDB-log - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ceritaku
DROP DATABASE IF EXISTS `ceritaku`;
CREATE DATABASE IF NOT EXISTS `ceritaku` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `ceritaku`;

-- Dumping structure for table ceritaku.akun
DROP TABLE IF EXISTS `akun`;
CREATE TABLE IF NOT EXISTS `akun` (
  `id_akun` int(11) auto_increment key,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(100) NOT NULL,
  `tanggal_lahir` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ceritaku.akun: ~0 rows (approximately)
/*!40000 ALTER TABLE `akun` DISABLE KEYS */;
/*!40000 ALTER TABLE `akun` ENABLE KEYS */;


-- Dumping structure for table ceritaku.novel
DROP TABLE IF EXISTS `novel`;
CREATE TABLE IF NOT EXISTS `novel` (
  `id_novel` int(11) auto_increment key,
  `id_akun` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL DEFAULT '',
  `sinopsis` text NOT NULL,
  `chapter` int(11) NOT NULL DEFAULT 0,
  `review` float NOT NULL DEFAULT 0,
  KEY `FK__akun` (`id_akun`),
  CONSTRAINT `FK__akun` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ceritaku.novel: ~0 rows (approximately)
/*!40000 ALTER TABLE `novel` DISABLE KEYS */;
/*!40000 ALTER TABLE `novel` ENABLE KEYS */;

-- Dumping structure for table ceritaku.chapter_idnovel
DROP TABLE IF EXISTS `chapter_idnovel`;
CREATE TABLE IF NOT EXISTS `chapter_idnovel` (
  `id_chapter` int(11) NOT NULL,
  `id_novel` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `isi` text NOT NULL,
  PRIMARY KEY (`id_chapter`),
  KEY `FK_chapter_idnovel_novel` (`id_novel`),
  CONSTRAINT `FK_chapter_idnovel_novel` FOREIGN KEY (`id_novel`) REFERENCES `novel` (`id_novel`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ceritaku.chapter_idnovel: ~0 rows (approximately)
/*!40000 ALTER TABLE `chapter_idnovel` DISABLE KEYS */;
/*!40000 ALTER TABLE `chapter_idnovel` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
