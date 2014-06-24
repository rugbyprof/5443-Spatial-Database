# 5443 Quiz 1
# Dinesh Amarneni

# 1 ###########################################

CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(10) NOT NULL,
  `NumMoons` int(2) NOT NULL,
  `Type` varchar(8) NOT NULL,
  `LengthOfYear` float(8,3) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Dumping data for table `Planets`

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Earth', 1, 'Rocky', 1.000),
('Jupiter', 16, 'Gas', 11.860),
('Mars', 2, 'Rocky', 1.880),
('Mercury', 0, 'Rocky', 0.240),
('Pluto', 1, 'Rocky', 247.700),
('Saturn', 18, 'Gas', 29.460),
('Venus', 0, 'Rocky', 0.620);

# 2 ###########################################

CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(10) NOT NULL,
  `year` int(4) NOT NULL,
  `dest` varchar(10) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Dumping data for table `Probes`

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Pioneer 5', 1960, 'sun'),
('Viking', 1976, 'Mars'),
('Zond', 1964, 'Venus');

# 3 ###########################################

SELECT * 
FROM Planets;

SELECT * 
FROM Probes;

DESCRIBE Planets;

DESCRIBE Probes;

# 4 ###########################################

SELECT COUNT(Name) AS NumOfPlanets
FROM Planets;

# 5 ###########################################

SELECT SUM(NumMoons) AS TotalNumMoons
FROM Planets;

# 6 ###########################################

SELECT COUNT(name) AS NumProbesWentMars
FROM Probes
WHERE dest = 'Mars';

# 7 ###########################################

SELECT name
FROM Probes
WHERE dest IN (SELECT Name
		FROM Planets
		WHERE NumMoons > 0);

# 8 ###########################################

SELECT Probes.name 
FROM Probes
JOIN Planets on dest = Planets.Name 
WHERE Type = 'Rocky';

# 9 ###########################################

SELECT Probes.name
FROM Probes 
WHERE dest IN (SELECT Planets.Name 
			FROM Planets
			WHERE LengthOfYear <= ALL(SELECT LengthOfYear
							FROM Planets));

# 10 ###########################################

SELECT Name
FROM Planets
WHERE LengthOfYear = (SELECT MAX(LengthOfYear) 
			FROM Planets);
			
# 11 ###########################################

SELECT Name 
FROM Planets
WHERE Type = 'GAS';

# 12 ###########################################

SELECT Name
From Planets
WHERE NumMoons > 0;

# 13 ###########################################

SELECT Planets.Name, Probes.name
FROM Planets
LEFT JOIN Probes
ON (Planets.Name = Probes.dest);

###############################################