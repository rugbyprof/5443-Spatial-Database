#5443 Quiz 1
# Aparna Vamulapalli


#1 ####################################################################################



CREATE TABLE IF NOT EXISTS `planets` (
  `Name` varchar(30) NOT NULL,
  `NumMoons` int(30) NOT NULL,
  `Type` varchar(30) NOT NULL,
  `LengthOfYear` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Mercury', 0, 'Rocky', 0.24),
('Venus', 0, 'Rocky', 0.62),
('Earth', 1, 'Rocky', 1),
('Mars', 2, 'Rocky', 1.88),
('Jupiter', 16, 'Gas', 11.86),
('Satum', 18, 'Gas', 29.46),
('Pluto', 1, 'Rocky', 247.7);


#2#####################################################################################


CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(30) NOT NULL,
  `year` int(30) NOT NULL,
  `dest` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner 10', 1974, 'Mercury'),
('Messenher', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter');


#3#######################################################################################

SELECT * 
FROM planets;
DESCRIBE planets;


SELECT *
FROM Probes;
DESCRIBE Probes;

#4#######################################################################################
 
 SELECT COUNT(Name)
 FROM planets;
 
 #5######################################################################################
 
 SELECT SUM(NumMoons)
 FROM planets;
 
 #6######################################################################################
 SELECT COUNT(dest)
 FROM Probes
 WHERE dest= 'Mars%' ;
 
 #7#######################################################################################
   SELECT Probes.name
  FROM planets JOIN Probes
  ON (planets.name=Probes.dest)
  WHERE  NumMoons>0;
  
 #8#######################################################################################

  SELECT Probes.name
  FROM planets JOIN Probes
  ON (planets.name=Probes.dest)
  WHERE  type='Rocky';
  
 #9#######################################################################################
 
 SELECT Probes.name
  FROM planets JOIN Probes
  ON (planets.name=Probes.dest)
  WHERE  LengthOfYear is MIN;
  
 #10######################################################################################
 
 SELECT Name
FROM 
(SELECT MAX(LengthOfYear) AS S FROM planets)X;
 
 #11######################################################################################
 
 
 SELECT Name
 FROM planets
 WHERE Type like 'Gas%';
 
 #12######################################################################################
 
 SELECT Name
 FROM planets
 WHERE  NumMoons>0;
  
 
 
 
 
 
 
 