# 5443 Quiz 1
# Yaswanth Amaraneni

# 1 ###############################

CREATE TABLE Planets 
( Name VarChar(10),
NumMoons INTEGER (2),
Type VARCHAR(8),
LengthOfYear(3,2)
);

# 2 ###############################

CREATE TABLE Probes 
( name VarChar(10),
year INTEGER (4),
dest VARCHAR(8),
);

# 3 ###############################

SELECT *
FROM Planets;
DESCRIBE Planets;

SELECT *
FROM Probes;

DESCRIBE Probes;

# 4 ##############################

SELECT COUNT(Name)
FROM Planets;

# 5 ##############################

SELECT SUM(NumMoons)
FROM Planets;

# 6 ################################

SELECT COUNT(name)
FROM Probes
WHERE dest = 'Mars';

# 7 ################################

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
                                  WHERE LengthOfYear <= ALL(SELECT LengthOfYear FROM Planets));

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

