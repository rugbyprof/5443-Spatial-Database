/*############################################*/
/* Assignment 1 Solutions */
/* Name: Kiran Tej Badana */
/* Created on: 6/5/2014 */
/*############################################*/
/*Solution 1*/
/*Creating the Database Table Planets*/
create table Planets
(
Name varchar(20),
NumMoons INT,
Type varchar(20),
LengthOfYear FLOAT(7,2)
);
/*Inserting the data values into the database table Planets*/
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Mercury', '0', 'Rocy', '0.24');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Venus', '0', 'Rocy', '0.62');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Earth', '1', 'Rocy', '1');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Mars', '2', 'Rocy', '1.88');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Jupiter', '16', 'Gas', '11.86');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Saturn', '18', 'Gas', '29.46');
INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES ('Pluto', '1', 'Rocy', '247.7');

/*Sloution 2*/
/*Creating the table*/
create table Probes
(
Name varchar(20),
Year INT,
Dest varchar(20)
);

/*inserting the values into tables*/
INSERT INTO `Probes` (`Name`, `Year`, `Dest`) VALUES ('Pioneer 5', '1960', 'sun'), ('Mariner 10', '1974', 'Mercury'), ('Messenger', '2008', 'Mercury'), ('zond', '1964', 'Venus'), ('Viking', '1976', 'Mars'), ('Cassini', '2000', 'Jupiter'), ('galileo', '1995', 'Jupiter');

/*Sloution 3*/

SELECT * FROM Probes;
SELECT * FROM Planets;
describe Probes;
describe Planets;

/*Solution 4*/

select count(*) from Planets;

/*Solution 5*/

select sum(NumMoons) from Planets;

/* Solution 6*/

select count(Name) from Probes where dest='Mars';

/*Solution 7*/

select Name from Probes where Dest in 
(select Name from Planets where NumMoons>0);

/*Solution 8*/
select Name from Probes where Dest in 
(select Name from Planets where Type='Rocky');

/*Solution 9*/

select Name from Probes where Dest in 
(select Name from Planets where LengthOfYear in (
select Min(LengthOfYear) from Planets));

/*Solution 10*/

select Name from Planets where LengthOfYear in (
select Max(LengthOfYear) from Planets);

/*Solution 11*/
select Name from Planets where Type='Gas';

/*Solution 12*/
select Name from Planets where NumMoons>0;


