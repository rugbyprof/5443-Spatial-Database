# 5443 Qiuz 1
# AKHILESH KALARU

# 1 #########################################################################################

CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(8) NOT NULL,
  `NumMoons` int(3) NOT NULL,
  `Type` varchar(8) NOT NULL,
  `LengthOfYear` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Mercury', 0, 'Rocky', 0.24),
('Venus', 0, 'Rocky', 0.62),
('Earth', 1, 'Rocky', 1),
('Mars', 2, 'Rocky', 1.88),
('Jupiter', 16, 'Gas', 11.86),
('Saturn', 18, 'Gas', 29.46),
('Pluto', 1, 'Rocky', 247.7);

# 2 #########################################################################################

CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(13) NOT NULL,
  `year` int(4) NOT NULL,
  `dest` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter ');

# 3 #########################################################################################

SELECT * FROM `Planets` ;
DESCRIBE Planets;
SELECT * FROM `Probes`;
DESCRIBE Probes;

# 4 #########################################################################################

SELECT COUNT(Name) FROM `Planets`;

# 5 #########################################################################################

SELECT SUM(NumMoons) FROM `Planets`;

# 6 #########################################################################################

SELECT COUNT(name) FROM `Probes` WHERE dest = 'Mars'

# 7 #########################################################################################

SELECT name FROM `Probes` WHERE dest IN (SELECT Name FROM `Planets` WHERE NumMoons > 0 );

# 8 #########################################################################################

SELECT name FROM `Probes` WHERE dest IN (SELECT Name FROM `Planets` WHERE TYPE = 'Rocky')

# 9 #########################################################################################

SELECT name FROM `Probes` WHERE dest IN
(SELECT Name FROM `Planets` WHERE LengthOfYear = ( SELECT MIN(LengthOfYear) FROM `Planets`));

# 10 #########################################################################################

SELECT Name FROM `Planets` WHERE LengthOfYear = ( SELECT MAX(LengthOfYear) FROM `Planets`); 

# 11 #########################################################################################

SELECT Name FROM `Planets` WHERE TYPE = 'Gas' ;

# 12 #########################################################################################

SELECT Name FROM `Planets` WHERE NumMoons >= 1 ; 

# 13 #########################################################################################

SELECT Planets.Name,Probes.name FROM `Planets` LEFT OUTER JOIN `Probes` ON (Planets.Name= Probes.dest);
