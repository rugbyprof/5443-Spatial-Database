### CMPS 5443 - Spatial Database Quiz 1

#### Instructions:

- Log in to PhpMyAdmin using your credentials.
- Use your database to answer the questions below.
- You will submit your quiz by adding a file called quiz-1.sql to your Github repository that contains all the SQL answers for the questions below.
- Rows that start with a # are comments. Don't use any other comment type!
- I've pretty much done the first few questions for you in an example below.
- IMPORTANT: SQL keywords are ALL CAPS! I will take points if keywords are not in all caps.
- An example format that you will follow is below. Notice how SQL queries start each SELECT,FROM,WHERE,JOIN portion of a query on a new line:

```sql
# 5443 Quiz 1
# First Last Name

# 1 #################################################

CREATE TABLE table_name
(
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size),
....
);

# 2 #################################################

CREATE TABLE table_name
(
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size),
....
);

# 3  #################################################

SELECT * 
FROM Planets;

DESCRIBE Planets;

SELECT * 
FROM Probes;

DESCRIBE Probes;

# 4 #################################################

SELECT *
FROM Planets
WHERE some where clause
JOIN some join clause

```
- I should be able to cut and paste your file into phpMyAdmin and run it. It should then create the tables, and run each query displaying all the results.

### Quiz Questions

#### Part One: Create Tables

- Create two tables in your database on cs2.
- One table is called Planets and the second is called Probes.
- Choose types that BEST FIT this data, and that MINIMIZE table space.
- You will lose points for misspelling the table names / column names.
- You will really lose points for not choosing the correct data types (because your queries will suffer).

(1) Create `Planets`

| Name	    | NumMoons	| Type	 | LengthOfYear |
|-----------|-----------|--------|--------------|
| Mercury   |	0       | Rocky  | 0.24         |
| Venus	    | 0	        | Rocky  | 0.62         |
| Earth	    | 1	        | Rocky  | 1            |
| Mars      | 2         | Rocky  | 1.88         |
| Jupiter	| 16        | Gas	 | 11.86        |
| Saturn	| 18        | Gas	 | 29.46        |
| Pluto	    | 1	        | Rocky	 | 247.7        |

(2) Create `Probes`


| name       | year | dest    |
|------------|------|---------|
| Pioneer 5  | 1960 | sun     |
| Mariner 10 | 1974 | Mercury |
| Messenger  | 2008 | Mercury |
| Zond       | 1964 | Venus   |
| Viking     | 1976 | Mars    |
| Cassini    | 2000 | Jupiter |
| Galileo    | 1995 | Jupiter |


#### Part Two: SQL Queries

- (3) Show the results of select * from tablename and describe tablename for both tables.
- (4) Write an SQL querry showing how many planets there are in the database. Your query should return '7'.
- (5) Write an SQL querry showing how many moons there are in the database. Your query should return '38'.
- (6) Write an SQL query showing the number of probes that went to Mars. Your query should return a single number.
- (7) Write an SQL querry showing every probe that went to a planet which has moons. Your query should return a list of probe names.
- (8) Write an SQL query that shows the names of every probe that went to a rocky planet. Your query should return a list of probe names.
- (9) Write an SQL query that shows the probe which experienced the shortest year. Your query should return a list of probe names.
- (10) Write an SQL query which shows the planet with the longest year. Your query should return 'Pluto'.
- (11) Write an SQL query that shows all the gas giant planets. Your query should return a list of planets.
- (12) Write an SQL query that show all planets with at least one moon. Your query should return a list of planets.
- (13) Write a SQL query that shows each planets name, and a probe if it has one, or blank if it doesn't. Think some kind of join (left or right).
