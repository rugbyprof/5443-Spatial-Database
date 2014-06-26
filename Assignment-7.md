#### Assignment 7

Given this example:

```sql
SELECT SHAPE as Poly 
FROM `state_borders` 
WHERE state = 'California'
```

And this one:

```sql
SELECT SHAPE AS POINT
FROM  `earth_quakes` 
```

And the functions:

`Contains` or `Within`

Can you join these two queries (or tables actually) so that we can get 
all the `Earth Quakes` that occurred in a single `State` ?


Your Answer:

```sql

select state,earth_quakes.shape from state_borders,earth_quakes where contains(state_borders.shape,earth_quakes.shape) and state="California"



```
