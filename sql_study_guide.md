---
layout: post
title: Sql Study Guide
---

### SQL
---

#### SELECT , FROM , WHERE 

```SQL
SELECT yr, city 
FROM games
WHERE yr = 2004
```

---
### IN

```SQL
SELECT population
FROM world
WHERE name IN ('France','Germany','Spain')
```

---
Result:
---

---
population: 65350000 
population: 81874000
population: 46163116
---

---
### LIKE & WILDCARD '%'

```SQL
SELECT name FROM bbc
WHERE name LIKE 'Z%'
```
---
### SOME FUNCTIONS

#### CURRENT_TIMESTAMP OR NOW() OR UTC_TIMESTAMP()


- FROM_UNIXTIME
- UNIX_TIMESTAMP
- EXTRACT (YEAR,MONTH,DAY,HOUR,MINUTE,SECOND)
- COUNT
- SUM
