-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 05, 2014 at 03:13 PM
-- Server version: 5.5.37-0ubuntu0.12.10.1
-- PHP Version: 5.4.6-1ubuntu1.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `thackbarth`
--

-- --------------------------------------------------------

--
-- Table structure for table `planets`
--

CREATE TABLE IF NOT EXISTS `planets` (
  `Name` varchar(12) NOT NULL,
  `NumMoons` int(10) NOT NULL,
  `Type` varchar(12) NOT NULL,
  `LengthOfYear` decimal(20,2) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `planets`
--

INSERT INTO `planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Earth', 1, 'Rocky', 1.00),
('Jupiter', 16, 'Gas', 11.86),
('Mars', 2, 'Rocky', 1.88),
('Mercury', 0, 'Rocky', 0.24),
('Pluto', 1, 'Rocky', 247.70),
('Satum', 18, 'Gas', 29.46),
('Venus', 0, 'Rocky', 0.62);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
