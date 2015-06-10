-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2014 at 09:12 PM
-- Server version: 5.1.73-1+deb6u1
-- PHP Version: 5.3.3-7+squeeze23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `panelsks`
--
CREATE DATABASE IF NOT EXISTS `panelsks` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `panelsks`;

--
-- Table structure for table `ftp`
--

CREATE TABLE IF NOT EXISTS `ftp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) NOT NULL,
  `login` varchar(30) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `dir` varchar(255) NOT NULL,
  `type` varchar(5) NOT NULL DEFAULT '1',
  `quota` int(11) NOT NULL DEFAULT '51250',
  `dedi` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

