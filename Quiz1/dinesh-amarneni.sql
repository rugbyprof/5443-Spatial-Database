# 5443 Quiz 1
# Dinesh Amarneni

#1 ###########################################

CREATE TABLE Planets (
  Name varchar(10) NOT NULL,
  NumMoons int(2) NOT NULL,
  Type varchar(8) NOT NULL,
  LengthOfYear float(8,3) NOT NULL,
  PRIMARY KEY (Name)
);

#2 ###########################################

CREATE TABLE Probes (
  name varchar(10) NOT NULL,
  year int(4) NOT NULL,
  dest varchar(10) NOT NULL,
  PRIMARY KEY (name)
);

#3 ###########################################

SELECT * 
FROM Planets;

SELECT * 
FROM Probes;

DESCRIBE Planets;

DESCRIBE Probes;

#4 ###########################################

SELECT COUNT(Name) AS NumOfPlanets
FROM Planets;

#5 ###########################################

SELECT SUM(NumMoons) AS TotalNumMoons
FROM Planets;

#6 ###########################################

SELECT COUNT(name) AS NumProbesWentMars
FROM Probes
WHERE dest = 'Mars';

#7 ###########################################

SELECT name
FROM Probes
WHERE dest IN (SELECT Name
		FROM Planets
		WHERE NumMoons > 0);

#8 ###########################################

SELECT Probes.name 
FROM Probes
JOIN Planets on dest = Planets.Name 
WHERE Type = 'Rocky';

#9 ###########################################

SELECT Probes.name
FROM Probes 
WHERE dest IN (SELECT Planets.Name 
			FROM Planets
			WHERE LengthOfYear <= ALL(SELECT LengthOfYear
							FROM Planets));

#10 ###########################################

SELECT Name
FROM Planets
WHERE LengthOfYear = (SELECT MAX(LengthOfYear) 
			FROM Planets);
			
#11 ###########################################

SELECT Name 
FROM Planets
WHERE Type = 'GAS';

#12 ###########################################

SELECT Name
From Planets
WHERE NumMoons > 0;

###############################################