---
### SQL TOPICS
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
### SOME FUNCTIONS
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

#### EXTRACT (YEAR,MONTH,DAY,HOUR,MINUTE,SECOND)

```SQL
SELECT EXTRACT(YEAR FROM now()) AS OrderYear,
EXTRACT(MONTH FROM now()) AS OrderMonth,
EXTRACT(DAY FROM now()) AS OrderDay
```

Results:


|OrderYear	| OrderMonth | OrderDay|
|-----------|------------|---------|
|2014       |	6	     |   4     |

----

#### COUNT


#### SUM



