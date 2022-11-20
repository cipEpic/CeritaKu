-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2022 at 07:13 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ceritaku`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `id_akun` int(11) auto_increment key,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(100) NOT NULL,
  `tanggal_lahir` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`id_akun`, `email`, `password`, `nama`, `jenis_kelamin`, `tanggal_lahir`) VALUES
(1, 'dhonihanif354@gmail.com', 'twinet', 'Dhoni', '', '0000-00-00');


-- Table structure for table `novel`
--

CREATE TABLE `novel` (
  `id_novel` int(11) auto_increment,
  `id_akun` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL DEFAULT '',
  `sinopsis` text NOT NULL,
  `chapter` int(11) NOT NULL DEFAULT 0,
  `review` text NOT NULL DEFAULT 'Tidak ada cerita',
  KEY `FK__akun` (`id_akun`),
  CONSTRAINT `FK__akun` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `novel`
--

INSERT INTO `novel` (`id_novel`, `id_akun`, `judul`, `sinopsis`, `chapter`, `review`) VALUES
(3, 1, 'Dhoni', '', 0, '0'),
(4, 1, 'sadsa', 'sadsad', 0, '0');

--
-- Indexes for dumped tables
--
-- --------------------------------------------------------

--
-- Table structure for table `chapter_idnovel`
--

CREATE TABLE `chapter_idnovel` (
  `id_chapter` int(11) auto_increment,
  `id_novel` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `isi` text NOT NULL,
  KEY `FK_chapter_idnovel_novel` (`id_novel`),
  CONSTRAINT `FK_chapter_idnovel_novel` FOREIGN KEY (`id_novel`) REFERENCES `novel` (`id_novel`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
