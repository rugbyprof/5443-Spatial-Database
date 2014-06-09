-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 05, 2014 at 02:09 PM
-- Server version: 5.5.37-0ubuntu0.12.10.1
-- PHP Version: 5.4.6-1ubuntu1.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `snaveen`
--

-- --------------------------------------------------------

--
-- Table structure for table `palnets`
--

(1) CREATE TABLE IF NOT EXISTS `planets` (
  `Name` varchar(10) DEFAULT NULL,
  `NumMoons` decimal(5,0) DEFAULT NULL,
  `Type` varchar(10) DEFAULT NULL,
  `LengthOfYear` decimal(100,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `palnets`
--

INSERT INTO `planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Mercury', 0, 'Rocky', 0.2400),
('venus', 0, 'Rocky', 0.6200),
('Earth', 1, 'Rocky', 1.0000),
('Mars', 2, 'Rocky', 1.8800),
('Jupiter', 16, 'Gas', 11.86),
('Saturn', 18, 'Gas', 29.46),
('pluto', 1, 'Rocky', 247.7);

(2)

CREATE TABLE IF NOT EXISTS `probes` (
  `name` varchar(10) DEFAULT NULL,
  `Yr` decimal(4,0) DEFAULT NULL,
  `dest` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `probes`
--

INSERT INTO `probes` (`name`, `Yr`, `dest`) VALUES
('pioneer 5', 1960, 'sun'),
('Mariner', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter');


(3) select * from planets;
desc palnets;

(4) select Count(Name) from planets;
(5) select sum(NumMoons) from planets;
(6) select Count(dest) from probes where dest='Mars';
(7) select probes.name from probes join planets on probes.dest=planets.name where NumMoons>0;
(8) select probes.name from probes join planets on probes.dest=planets.name where Type='Rocky';
(9) select probes.name from probes join planets on probes.dest=planets.name in (select min(LengthOfYear) from planets) group by dest;
(10) SELECT name,max(LengthOfYear) from planets where name Like 'P%';
(11) select name from planets where type='Gas';
(12) select name from planets where NumMoons>=1;
