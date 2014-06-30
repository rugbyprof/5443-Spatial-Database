Get closest military installation to point

Spatial operators: http://www.postgresql.org/docs/8.2/static/functions-geometry.html
Spatial functions: http://postgis.net/docs/reference.html

Spatial Reference System Identifier: [SRID](http://en.wikipedia.org/wiki/SRID) 

```sql
SELECT ogc_fid,ST_Distance(ST_GeometryFromText ('Point(-120 33)',4269) , M.wkb_geometry) as distance
FROM military_installations M
Order by distance asc
limit 1
```

Get closest military installation to point (version 2) (different answer)
```sql
SELECT ogc_fid,ST_GeometryFromText ('Point(-120 33)',4269) <-> M.wkb_geometry as distance
FROM military_installations M
Order by distance asc
limit 1
```

Find the geometry that encloses the point

```sql
SELECT ogc_fid,  *
FROM state_borders S
WHERE ST_Within(ST_GeometryFromText ('Point(-98.92 31.76)',4269) , ST_SetSRID(S.wkb_geometry,4269)) = TRUE
```

Find all the geometries that touch the geometry that contains a specific point

```sql
SELECT S2.wkb_geometry, S2.state
FROM state_borders as s1 , state_borders as s2 
WHERE ST_Within(ST_GeometryFromText ('Point(-98.92 31.76)',4269) , ST_SetSRID(S1.wkb_geometry,4269)) = TRUE
AND ST_Touches(S1.wkb_geometry,S2.wkb_geometry)
```

Get the length of all roads in a particular area, in this case
an entire table

```sql
SELECT sum(ST_Length(wkb_geometry))
FROM  california_roads
```


```sql
SELECT 
  sum(ST_Area(wkb_geometry)) as area
FROM california_landuse
WHERE type = 'cemetery'
```