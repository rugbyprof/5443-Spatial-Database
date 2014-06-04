---
### SQL Topics Overview
---

#### SELECT , FROM , WHERE 
Example:
```SQL
SELECT yr, city 
FROM games
WHERE yr = 2004
```
Results:

| yr  |	city  |
|-----|------ |
|2004 |	Athens | 

---
### IN
Example:
```SQL
SELECT population
FROM world
WHERE name IN ('France','Germany','Spain')
```
Result:

| population | 
| ---------- |
|  65350000  |
|  81874000  |
|  46163116  |

---
### LIKE & WILDCARD '%'

```SQL
SELECT name FROM bbc
WHERE name LIKE 'Z%'
```
Results:

| name |
|------|
|Zambia|
|Zimbabwe|

---
### PERTINENT FUNCTIONS
---

#### CURRENT_TIMESTAMP OR NOW() OR UTC_TIMESTAMP()

```SQL
SELECT CURRENT_TIMESTAMP , NOW() , UTC_TIMESTAMP()
```
Results:

| CURRENT_TIMESTAMP | NOW()	| UTC_TIMESTAMP() |
|-------------------|-------|-----------------|
|2014-06-04 14:10:05|	2014-06-04 14:10:05	|2014-06-04 13:10:05|

----

#### FROM_UNIXTIME

```SQL
SELECT FROM_UNIXTIME(1401887491)
```

Results:

|FROM_UNIXTIME()|
|----------------|
|2014-06-04 14:11:31    |

#### UNIX_TIMESTAMP

```SQL
SELECT UNIX_TIMESTAMP()
```
Results:

|UNIX_TIMESTAMP()|
|----------------|
|1401887491      |

----

#### EXTRACT [YEAR : MONTH : DAY : HOUR : MINUTE : SECOND]

```SQL
SELECT EXTRACT(YEAR FROM now()) AS OrderYear,
EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS OrderMonth,
EXTRACT(DAY FROM UTC_TIMESTAMP()) AS OrderDay
```
Results:

|OrderYear	| OrderMonth | OrderDay|
|-----------|------------|---------|
|2014       |	6	     |   4     |

----

#### COUNT

```SQL
SELECT COUNT(*) 
FROM table
WHERE some_column = 'some_value'
```

#### SUM

```SQL
SELECT sum(integer_value) 
FROM table
WHERE some_column = 'some_value' /* or LIKE 'some_value' or IN ('some','list','of','values') */
```

#### SUB SELECTS

```SQL
SELECT balance, keepplace, startdate
FROM placement, (
  SELECT balance AS B, MAX(startdate) AS S
   FROM placement
  GROUP BY balance) X
WHERE startdate = X.S
```

#### JOINS

```SQL
SELECT player,stadium
FROM game JOIN goal ON (id=matchid)
```


