# 5443 Quiz 1
# Yaswanth Amaraneni

# 1 ###############################

CREATE TABLE IF NOT EXISTS `Planets` (`Name` varchar(10) NOT NULL,`NumMoons` int(2) NOT NULL,`Type` varchar(8) NOT NULL,`LengthOfYear` float(3,2) NOT NULL,PRIMARY KEY (`Name`);
# Dumping data for table `Planets`########
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Earth', 1, 'rocky', 1.00),
('Jupiter', 16, 'Gas', 9.99),
('Mars', 2, 'Rocky', 1.88),
('Mercury', 0, 'Rocky', 0.24),
('Pluto', 1, 'Rocky', 9.99),
('Saturn', 18, 'Gas', 9.99),
('Venus', 0, 'Rocky', 0.62);

# 2 ###############################

CREATE TABLE Probes ( name VarChar(10),year INTEGER (4),dest VARCHAR(8));

# Dumping data for table `Probes`##########

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Pioneer 5', 1960, 'sun'),
('Viking', 1976, 'Mars'),
('Zond', 1964, 'Venus');


# 3 ###############################

SELECT *FROM Planets;
DESCRIBE Planets;
SELECT *FROM Probes;
DESCRIBE Probes;

# 4 ##############################

SELECT COUNT(Name)FROM Planets;

# 5 ##############################

SELECT SUM(NumMoons)FROM Planets;

# 6 ################################

SELECT COUNT(name)FROM Probes WHERE dest = 'Mars';

# 7 ################################

SELECT name FROM Probes WHERE dest IN (SELECT Name FROM Planets WHERE NumMoons > 0);

#8 #################################

SELECT Probes.name FROM Probes JOIN Planets on dest = Planets.Name WHERE Type = 'Rocky';

#9 #################################

SELECT Probes.name FROM Probes WHERE dest IN (SELECT Planets.Name FROM Planets WHERE LengthOfYear <= ALL(SELECT LengthOfYear FROM Planets));

#10 ################################

SELECT Name FROM Planets WHERE LengthOfYear = (SELECT MAX(LengthOfYear) FROM Planets);
			
#11 ################################

SELECT Name FROM Planets WHERE Type = 'GAS';

#12 ################################

SELECT Name From Planets WHERE NumMoons > 0;

#13 ################################

SELECT Planets.Name,Probes.name FROM Planets LEFT JOIN Probes ON (Planets.Name = dest); 

