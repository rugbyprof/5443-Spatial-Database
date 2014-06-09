# 5443 Quiz 1
# Vipin Deshmukh

1 ###########################################

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

4) ######################################
SELECT count(name)
FROM planets

5) ######################################
SELECT count(NumMoons) 
FROM planets

6) ######################################
SELECT count(probes) 
FROM probes 
WHERE planet = 'mars'


7) ######################################
SELECT probe 
FROM probes,planets 
WHERE planet = name and NumMoons > 0
GROUP BY probe;


8) #######################################
SELECT distinct probe 
FROM probes, planets 
WHERE planet = name AND type = "Rocky";

9) ######################################
SELECT probe
FROM probes, planets
WHERE planet = name 
ORDER BY lengthofyear limit 1;

10) #####################################
SELECT name
FROM planets 
ORDER BY lengthofyear DESC limit 1;


11) ######################################
SELECT name
FROM planets
WHERE type = "Gas";

 
12) ######################################
SELECT name
FROM planets 
where name >= 1



