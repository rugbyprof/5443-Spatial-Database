# 5443 Spatial Database Quiz-1

# Varun Kumar Ayanala

# 1 ###########################

CREATE TABLE IF NOT EXISTS Planets ( Name VARCHAR(32) NOT NULL, NumMoons INT(5) NOT NULL, Type VARCHAR(32) NOT NULL, LengthOfYear FLOAT(8,3) NOT NULL, PRIMARY KEY ('Name'));

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Mercury', 0, 'Rocky', 0.240);
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Venus', 0, 'Rocky', 0.620);
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Earth', 1, 'Rocky', 1.000);
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Mars', 2, 'Rocky', 1.880);
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Jupiter', 16, 'Gas', 11.860);
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Satrun', 18, 'Gas', 29.460);
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Pluto', 1, 'Rocky', 247.700);

# 2 ###########################

CREATE TABLE IF NOT EXISTS Probes ( name VARCHAR(16) NOT NULL, year INT(5) NOT NULL, dest VARCHAR(16) NOT NULL, PRIMARY KEY('name') );

INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Pioneer 5', 1960, 'Sun');
INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Mariner 10', 1974, 'Mercury');
INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Messenger', 2008, 'Mercury');
INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Zond', 1964, 'Venus');
INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Viking', 1976, 'Mars');
INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Cassini', 2000, 'Jupiter');
INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Galileo', 1995, 'Jupiter');

# 3 ##########################

SELECT * FROM Planets;
DESC Planets;

SELECT * FROM Probes;
DESC Probes;

# 4 ##########################

SELECT COUNT(Name) FROM Planets;

# 5 ##########################

SELECT SUM(NumMoons) FROM Planets;

# 6 ##########################

SELECT COUNT(*) FROM Probes WHERE dest = 'Mars';

# 7 ###########################

SELECT Probes.name FROM Planets JOIN Probes ON (Planets.name = Probes.dest) WHERE NumMoons > 0;

# 8 ###########################

SELECT Probes.name FROM Planets JOIN Probes ON (Planets.name = Probes.dest) WHERE Type = 'Rocky';

# 9 ###########################

SELECT Probes.name FROM Probes WHERE dest IN (SELECT Planets.Name FROM Planets WHERE LengthOfYear <= ALL(SELECT LengthOfYear FROM Planets));

# 10 ###########################

SELECT Name FROM Planets WHERE LengthOfYear = (SELECT MAX(LengthOfYear) FROM Planets);

# 11 ###########################

SELECT Name FROM Planets WHERE Type = 'Gas';

# 12 ###########################

SELECT Name FROM Planets WHERE NumMoons > 0;

#13 ############################

SELECT Planets.Name,Probes.name FROM Planets LEFT JOIN Probes ON (Planets.Name = dest); 
