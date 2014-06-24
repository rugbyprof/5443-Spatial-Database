# 5443 Quiz 1
# Kiran Tej Badana

# 1 #################################################

CREATE TABLE Planets
(
	Name VARCHAR(20),
	NumMoons INT,
	Type VARCHAR(20),
	LengthOfYear FLOAT(7,2)
);

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Mercury', '0', 'Rocy', '0.24');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Venus', '0', 'Rocy', '0.62');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Earth', '1', 'Rocy', '1');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Mars', '2', 'Rocy', '1.88');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Jupiter', '16', 'Gas', '11.86');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Saturn', '18', 'Gas', '29.46');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Pluto', '1', 'Rocy', '247.7');

# 2 #################################################

CREATE TABLE Probes
(
	name VARCHAR(20),
	year INT,
	dest VARCHAR(20)
);


INSERT INTO `Probes` (`name`, `year`, `dest`) 
VALUES ('Pioneer 5', '1960', 'sun'), 
		('Mariner 10', '1974', 'Mercury'), 
		('Messenger', '2008', 'Mercury'), 
		('zond', '1964', 'Venus'), 
		('Viking', '1976', 'Mars'), 
		('Cassini', '2000', 'Jupiter'), 
		('galileo', '1995', 'Jupiter');

# 3 #################################################

SELECT * 
FROM Probes;

SELECT * 
FROM Planets;

DESCRIBE Probes;
DESCRIBE Planets;

# 4 #################################################

SELECT COUNT(*) 
FROM Planets;

# 5 #################################################

SELECT SUM(NumMoons) 
FROM Planets;

# 6 #################################################

SELECT COUNT(name) 
FROM Probes 
WHERE dest='Mars';

# 7 #################################################

SELECT name 
FROM Probes 
WHERE dest IN (
SELECT Name 
FROM Planets 
WHERE NumMoons>0);

# 8 #################################################

SELECT name 
FROM Probes 
WHERE dest IN (
SELECT Name 
FROM Planets 
WHERE Type='Rocky');

# 9 #################################################

SELECT name 
FROM Probes 
WHERE dest IN (
SELECT Name 
FROM Planets 
WHERE LengthOfYear IN (
SELECT MIN(LengthOfYear) 
FROM Planets)
);

# 10 #################################################

SELECT Name 
FROM Planets 
WHERE LengthOfYear IN (
SELECT MAX(LengthOfYear) 
FROM Planets);

# 11 #################################################

SELECT Name 
FROM Planets 
WHERE Type='Gas';

# 12 #################################################

SELECT Name 
FROM Planets 
WHERE NumMoons>0;

# 13 #################################################

SELECT Planets.Name,Probes.name 
FROM Planets LEFT OUTER JOIN Probes 
ON (Planets.Name=Probes.dest);