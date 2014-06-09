# 5443 Quiz 1
# Rohit Mukherjee
# 1 ##############################################

CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(12) NOT NULL,
  `NumMoons` int(5) NOT NULL,
  `Type` varchar(12) NOT NULL,
  `LengthOfYears` float(8,3) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Planets`
--

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYears`) VALUES
('Earth', 1, 'Rocky', 1.000),
('Jupiter', 16, 'Gas', 11.860),
('Mars', 2, 'Rocky', 1.880),
('Mercury', 0, 'Rocky', 0.240),
('Pluto', 1, 'Rocky', 247.700),
('Saturn', 18, 'Gas', 29.460),
('Venus', 0, 'Rocky', 0.620);

# 2 ##############################################
CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(12) NOT NULL,
  `NumMoons` int(5) NOT NULL,
  `Type` varchar(12) NOT NULL,
  `LengthOfYears` float(8,3) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Planets`
--

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYears`) VALUES
('Earth', 1, 'Rocky', 1.000),
('Jupiter', 16, 'Gas', 11.860),
('Mars', 2, 'Rocky', 1.880),
('Mercury', 0, 'Rocky', 0.240),
('Pluto', 1, 'Rocky', 247.700),
('Saturn', 18, 'Gas', 29.460),
('Venus', 0, 'Rocky', 0.620);


# 3 ##############################################
SELECT * 
FROM  `Planets` ;
DESCRIBE Planets;


Full texts	Field	Type	Null	Key	Default	Extra
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Name	varchar(12)	NO	PRI	NULL	
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	NumMoons	int(5)	NO		NULL	
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Type	varchar(12)	NO		NULL	
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	LengthOfYears	float(8,3)	NO		NULL	
	 
	 
SELECT * 
FROM  `Probes` ;
DESCRIBE  `Probes`;



Full texts	Field	Type	Null	Key	Default	Extra
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	name	varchar(12)	NO		NULL	
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	year	int(5)	NO		NULL	
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	dest	varchar(12)	NO		NULL	
	 
	 
# 4 #################################################
	 
	 SELECT Name FROM `Planets`;
	 
	 COUNT(Name)
      7

	 
# 5 #################################################

SELECT SUM(NumMoons) FROM `Planets` ;

SUM(NumMoons)
38

# 6 #################################################

SELECT COUNT(dest) FROM `Probes` WHERE  dest = 'Mars';

COUNT(dest)
1

# 7 #################################################

SELECT Probes.name
FROM Probes
JOIN Planets ON ( dest = Planets.Name ) 
WHERE Planets.NumMoons >=1;




Full texts	name
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Viking
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Cassini
	 
	 
# 8 #################################################	



SELECT Probes.name FROM Probes JOIN Planets ON (dest=Planets.Name) WHERE Planets.Type ='Rocky';



Full texts	name
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Mariner 10
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Messenger
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Zond
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Viking 
	 
	 
# 9 #################################################	 
	 
	 SELECT Probes.name FROM Probes JOIN Planets ON (dest=Planets.Name) WHERE Planets.LengthOfYears <1;
	 
	 
Full texts	name
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Mariner 10
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Messenger
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Zond
	 
	# 10 #################################################	  
	
	 SELECT Probes.name FROM Probes JOIN Planets ON (dest=Planets.Name) WHERE LengthOfYears =MAX(LengthOfYears);
	 
	 
Full texts	name
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Cassini
	 
	 # 11 #################################################	  
	 
	 
	 
	 
	 
	 
	 
	 # 12 #################################################	

SELECT Name FROM `Planets` WHERE NumMoons >=1;


Full texts	Name
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Earth
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Jupiter
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Mars
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Pluto
	 Edit Edit	 Edit Inline Edit	 Copy Copy	Delete Delete	Saturn