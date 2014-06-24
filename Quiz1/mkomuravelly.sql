# 5443 Quiz 1
# Madhuri Komuravelly

# 1 ##############

CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(70) DEFAULT NULL,
  `NumMoons` int(30) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `LengthOfYear` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Planets`
--

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Mercury', 0, 'Rocky', 0.24),
('Venus', 0, 'Rocky', 0.62),
('Earth', 1, 'Rocky', 1),
('Mars', 2, 'Rocky', 1.88),
('jupiter', 16, 'Gas', 11.86),
('Saturn', 18, 'Gas', 29.46),
('Pluto', 1, 'Rocky', 247.7);




# 2 #################

CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(40) NOT NULL,
  `year` int(50) NOT NULL,
  `dest` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Probes`
--

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter');
 



# 3 ###################
SELECT*
FROM Planets;

DESCRIBE Planets;

SELECT * 
FROM Probes;

DESCRIBE Probes;

# 4 ##################
SELECT COUNT( Name ) 
FROM Planets;

# 5 ##################
SELECT SUM( NumMoons ) 
FROM Planets;

# 6 ##################
SELECT COUNT(name)  
FROM Probes
WHERE dest = 'Mars';

# 7 #####################
SELECT Probes.name 
FROM Probes 
JOIN Planets
ON Probes.dest=Planets.Name
WHERE Planets.NumMoons>0;

# 8 ###############
SELECT Probes.name
FROM Probes
JOIN Planets 
ON Planets.Name=Probes.dest 
WHERE Planets.Type='Rocky';

# 9 ##################
SELECT Probes.name
FROM Probes 
JOIN Planets
ON Probes.dest=Planets.Name
WHERE LengthOfYear = (
SELECT MIN(LengthOfYear) 
FROM Planets);

# 10 ################
SELECT Name 
FROM Planets
WHERE LengthOfYear = 
(SELECT MAX(LengthOfYear)
FROM Planets);  

# 11 #################
SELECT Name 
FROM Planets
WHERE Type='Gas'; 

# 12 #################
SELECT Name 
FROM Planets
WHERE NumMoons>0; 

# 13 ##########################

SELECT Planets.Name,Probes.name
FROM Planets
LEFT JOIN Probes 
ON Planets.Name=Probes.dest;
