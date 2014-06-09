
1-3) Create a table in cs460 database to descibe the data below.  
Type will always be rocky or gas.  Length of year is always between 0.24 and 247.7.  No plant has more than 20 moons.  Name is never null.  The default number of moons for a planet should be zero.  Index the field name.

Choose types that BEST FIT this data, and that MINIMIZE table space. 


| Name	    | NumMoons	| Type	 | LengthOfYear |
|-----------|-----------|--------|--------------|
| Mercury   |	0       | Rocky  | 0.24         |
| Venus	    | 0	        | Rocky  | 0.62         |
| Earth	    | 1	        | Rocky  | 1            |
| Mars      | 2         | Rocky  | 1.88         |
| Jupiter	| 16        | Gas	 | 11.86        |
| Saturn	| 18        | Gas	 | 29.46        |
| Pluto	    | 1	        | Rocky	 | 247.7        |

4-6) You should also make a table for the planetary probes.
+------------+------+---------+
| name       | year | dest    |
+------------+------+---------+
| Pioneer 5  | 1960 | sun     |
| Mariner 10 | 1974 | Mercury |
| Messenger  | 2008 | Mercury |
| Zond       | 1964 | Venus   |
| Viking     | 1976 | Mars    |
| Cassini    | 2000 | Jupiter |
| Galileo    | 1995 | Jupiter |
+------------+------+---------+
Scoring:  1 point for making a table, one point for getting the right types, one point for the index, and one point for inserting the data.  Make the table, and show me the results of "select * from tablename" and "describe tablename".

7) Write an SQL querry showing how many planets there are in the database.  Your query should return '7'.


8) Write an SQL querry showing how many moons there are in the database.  Your query should return '38'.


9) Write an SQL query showing the number of probes that went to Mars.  Your query should return a single number.


10) Write an SQL querry showing every probe that went to a planet which has moons.  Your query should return a list of probe names.


11) Write an SQL query that shows the names of every probe that went to a rocky planet.  Your query should return a list of probe names.


12) Write an SQL query that shows the probe which experienced the shortest year.  Your query should return a list of probe names.


13) Write an SQL query which shows the planet with the longest year.  Your query should return 'Pluto'.

14) Write an SQL query that shows all the gas giant planets.  Your query should return a list of planets.

15) Write an SQL query that show all planets with at least one moon.  Your query should return a list of planets.