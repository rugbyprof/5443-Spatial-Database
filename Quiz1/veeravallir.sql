# 5443 Quiz 1 
# Ramakrishna Veeravalli 

# 1 #####################################

CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(20) NOT NULL,
  `NumMoons` int(11) NOT NULL,
  `Type` varchar(20) NOT NULL,
  `LengthOfYear` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`)
 VALUES
('Mercury', 0, 'Rocky', 0.24),
('Venus', 0, 'Rocky', 0.62),
('Earth', 1, 'Rocky', 1),
('Mars', 2, 'Rocky', 1.88),
('Jupiter', 16, 'Gas', 11.86),
('Saturn', 18, 'Gas', 29.46),
('Pluto', 1, 'Rocky', 247.7);


# 2 ############################################


CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(20) NOT NULL,
  `year` int(11) NOT NULL,
  `dest` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `Probes` (`name`, `year`, `dest`) 
VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter');



#  3 #########################################

SELECT * FROM `Planets`;

DESCRIBE `Planets` ;


SELECT * FROM `Probes` ; 

DESCRIBE `Probes` ;

# 4 ################################################

SELECT COUNT( DISTINCT Name ) 
FROM Planets;




# 5 #############################################

SELECT  SUM(numMoons)  
 FROM Planets;

# 6 #############################################

SELECT  COUNT(*)
 FROM Probes
   WHERE  dest ='Mars' ;

# 7 ##############################################

SELECT Probes.name
FROM Probes
JOIN Planets ON Planets.Name = Probes.dest
WHERE Planets.NumMoons >0
LIMIT 0 , 30;


# 8 ###############################################\

SELECT Probes.name
FROM Probes
JOIN Planets ON Planets.Name = Probes.dest
WHERE Planets.Type =  'Rocky'
LIMIT 0 , 30;

# 9 ##################################################

SELECT Probes.name
FROM Probes
JOIN Planets ON Planets.Name = Probes.dest
WHERE Planets.LengthOfYear = ( 
SELECT MIN( Planets.LengthOfYear ) 
FROM Planets );


# 10 ################################################

SELECT Name
FROM Planets
WHERE LengthOfYear = ( 
SELECT MAX( LengthOfYear ) 
FROM Planets );


# 11 ################################################


SELECT Name
FROM Planets
WHERE TYPE =  'Gas'
LIMIT 0 , 30;

# 12 ##################################################

SELECT Name
FROM Planets
WHERE NumMoons >0
LIMIT 0 , 30;

# 13 #################################################

SELECT Planets.Name, Probes.name
FROM Planets
LEFT JOIN Probes ON Planets.Name = dest;