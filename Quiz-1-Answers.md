#### 1 & 2

Create and load tables with data.

```sql
CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(10) NOT NULL,
  `NumMoons` int(2) NOT NULL,
  `Type` varchar(8) NOT NULL,
  `LengthOfYear` float(5,2) NOT NULL,
  PRIMARY KEY (`Name`)
)

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Earth', 1, 'rocky', 1.00),
('Jupiter', 16, 'Gas', 11.86),
('Mars', 2, 'Rocky', 1.88),
('Mercury', 0, 'Rocky', 0.24),
('Pluto', 1, 'Rocky', 247.70),
('Saturn', 18, 'Gas', 29.46),
('Venus', 0, 'Rocky', 0.62);

CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(10) NOT NULL,
  `year` int(4) NOT NULL,
  `dest` varchar(8) NOT NULL,
  PRIMARY KEY (`name`)
)

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Pioneer 5', 1960, 'sun'),
('Viking', 1976, 'Mars'),
('Zond', 1964, 'Venus');
```

#### 3

Show the results of select * from tablename and describe tablename for both tables.

```sql
SELECT * 
FROM Planets;

DESCRIBE Planets;

SELECT * 
FROM Probes;

DESCRIBE Probes;
```

#### 4

Write an SQL querry showing how many planets there are in the database. Your query should return '7'.

```sql
SELECT COUNT( * ) 
FROM Planets
```

Answer:
```
COUNT(*)
--------
7
```

#### 5

Write an SQL querry showing how many moons there are in the database. Your query should return '38'.

```sql
SELECT SUM( NumMoons ) 
FROM Planets
```

Answer:
```
SUM(NumMoons)
-------------
38
```

#### 6

Write an SQL query showing the number of probes that went to Mars. Your query should return a single number.

```sql
SELECT COUNT( * ) 
FROM Probes
WHERE dest =  'MARS'
```

Answer:
```
COUNT(*)
--------
1
```

#### 7

Write an SQL querry showing every probe that went to a planet which has moons. Your query should return a list of probe names.

```sql
SELECT Probes.name
FROM Probes
WHERE Probes.dest
IN (

SELECT Planets.name
FROM Planets
WHERE Planets.NumMoons >0
)
```

Answer:

```
name
-------
Cassini
Galileo
Viking

```

#### 8

Write an SQL query that shows the names of every probe that went to a rocky planet. Your query should return a list of probe names.

```sql
SELECT Probes.name
FROM Probes
WHERE Probes.dest
IN (

SELECT Planets.name
FROM Planets
WHERE Planets.Type =  'Rocky'
)
```

Answer:

```
name
----------
Mariner 10
Messenger
Viking
Zond

```

#### 9 

Write an SQL query that shows the probe which experienced the shortest year. Your query should return a list of probe names.

```sql
SELECT Probes.name
FROM Probes
WHERE Probes.dest = (

SELECT Planets.Name
FROM Planets
ORDER BY Planets.LengthOfYear ASC 
LIMIT 0 , 1
)
```

Answer:

```
name
----------
Mariner 10
Messenger

```

#### 10

Write an SQL query which shows the planet with the longest year. Your query should return 'Pluto'.

```sql
SELECT Name 
FROM  `Planets` 
ORDER BY LengthOfYear DESC 
LIMIT 0 , 1
```

Answer:
```
Name
-----
Pluto  

```
#### 11

Write an SQL query that shows all the gas giant planets. Your query should return a list of planets.

```sql
SELECT Name
FROM  `Planets` 
WHERE TYPE =  'Gas'
```

Answer:

```
Name
-------
Jupiter
Saturn
```

#### 12

Write an SQL query that show all planets with at least one moon. Your query should return a list of planets.

```sql
SELECT Name
FROM  `Planets` 
WHERE NumMoons >=1
```

Answer:

```
Name
--------
Earth
Jupiter
Mars
Pluto
Saturn
```

#### 13

Write a SQL query that shows each planets name, and a probe if it has one, or blank if it doesn't.

```sql
SELECT Planets.name, Probes.name
FROM Planets
LEFT JOIN Probes ON Planets.name = Probes.dest
```

Answer:

```
name 	name
------- ----------
Earth 	NULL
Jupiter Cassini
Jupiter Galileo
Mars	Viking
Mercury	Mariner 10
Mercury	Messenger
Pluto	NULL
Saturn	NULL
Venus	Zond

```