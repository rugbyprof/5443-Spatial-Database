# 5443 Quiz 1
# Sharath kumar Garlapati

# 1 ########################################################

CREATE TABLE Planets (
  Name varchar(10) NOT NULL,
  NumMoons int(2) NOT NULL,
  Type varchar(8) NOT NULL,
  LengthOfYear float(8,3) NOT NULL,
  PRIMARY KEY (Name)
);

#  Dumping data for table `Planets` ######################


INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Earth', 1, 'Rocky', 1.000),
('Jupiter', 16, 'Gas', 11.860),
('Mars ', 2, 'Rocky', 1.880),
('Mercury', 0, 'Rocky ', 0.240),
('Pluto', 1, 'Rocky', 247.700),
('Satum', 18, 'Gas', 29.460),
('Venus', 0, 'Rocky', 0.620);


# 2 ########################################################

CREATE TABLE Probes (
  name varchar(10) NOT NULL,
  year int(4) NOT NULL,
  dest varchar(10) NOT NULL,
  PRIMARY KEY (name)
);

#  Dumping data for table `Probes`  ########################

INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'jupiter'),
('Galileo', 1995, 'Jupiter');

# 3 ########################################################

SELECT * 
FROM Planets;

DESCRIBE Planets;

SELECT * 
FROM Probes;

DESCRIBE Probes;

# 4 ########################################################

SELECT COUNT(Name)
FROM Planets;

# 5 ########################################################

SELECT SUM(NumMoons) 
FROM Planets;

# 6 ########################################################

SELECT COUNT( name ) 
FROM Probes
WHERE dest =  'Mars'

# 7 #########################################################

SELECT Probes.name
FROM  `Probes` 
JOIN Planets ON Planets.Name = dest
WHERE NumMoons

# 8 #########################################################

SELECT Probes.name
FROM  `Probes` 
JOIN Planets ON Planets.Name = dest
WHERE TYPE =  'Rocky'

# 9 #########################################################

SELECT Probes.name
FROM  `Probes` 
JOIN Planets ON Planets.Name = dest
WHERE  LengthOfYear <= ALL(SELECT LengthOfYear	FROM Planets)
							
# 10 #########################################################		

SELECT Name
FROM Planets
WHERE LengthOfYear = ( 
SELECT MAX( LengthOfYear ) 
FROM Planets )

# 11 ##########################################################

SELECT Name
FROM Planets
WHERE TYPE =  'Gas'

# 12 ##########################################################	

SELECT Name
FROM Planets
WHERE NumMoons >0
			
			
# 13 ##########################################################	

SELECT Planets.Name, Probes.name
FROM Planets
LEFT JOIN Probes ON Planets.Name = dest
