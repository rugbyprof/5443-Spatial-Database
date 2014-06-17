### MySQL - Nearest Point of Interest Query

Let me start by saying I came across this article http://www.plumislandmedia.net/mysql/haversine-mysql-nearest-loc/ written by [Ollie Jones](http://www.plumislandmedia.net/author/admin/), and as much as I would like to take credit for his well written article, I wouldn't dare. Below is an adapted version to our class. 

Now on with the lesson:

One of the most common questions in our GIS enabled world is: "What's the closest _______ to my current location?" We all use our smart phones to perform geo-location aware searches. So, instead of relying on someone else app, lets create our own.

![Restaurants](http://cs2.mwsu.edu/~griffin/5443/media/burger_king.400.png)

We already discussed [GDAL](http://www.gdal.org/) and the power it gives us with `ogr2ogr` in [this](https://github.com/rugbyprof/5443-Spatial-Database/blob/master/OsmAndShapeFiles.md) lesson.

### Geo Terms
Latitudes and longitudes are expressed in (at least) a couple different formats:

- Degrees Minutes Seconds 
    - Lat: 43° 42' 46.4148'' N
    - Lon: 79° 20' 30.5988'' W
- Decimal Degrees 
    - Lat: 43.712893
    - Lon: -79.341833

As you can see, the decimal degrees looks a lot more friendly, at least from a computer science perspective. Degrees Minutes Seconds, just looks like a lot of string processing to me, so we'll use the latter. 

| Lat Lon        |   Prime Meridian           |
|:--------------:|:------------:|
|![](http://cs2.mwsu.edu/~griffin/5443/media/latlon.400.png)| ![](http://cs2.mwsu.edu/~griffin/5443/media/prim_meridian.png)|



#### Latitude

Latitude describes how far north or south of the equator a point is located.  Points along the equator have latitudes of zero. The north pole has a positive (north) latitude of 90, and the south pole a negative (south) latitude of -90. Accordingly, northern-hemisphere locations have positive latitude, and southern-hemisphere locations have negative latitude.

#### Longitude 

Longitude describes how far east a point is, from the prime meridian: an arbitrary line on the earth surface running from pole to pole. The Empire State Building in New York City, USA, has a negative (west) longitude, specifically -73.9857. The Taj Mahal in Agra, India, has a positive (east) longitude, specifically 78.0422. The Greenwich Observatory near London, England, has, by definition, a longitude of zero.

Latitudes therefore are values in the range [-90, 90]. Longitudes are values in the range (-180, 180].  These values are sometimes expressed in degrees, minutes, and seconds, rather than degrees and decimals.  If you’re intending to do calculations, convert the minutes and seconds to decimals first.

Some USA-centric applications mess up the longitudes, representing them as positive rather than negative. If you’re debugging something be on the lookout for this.

A nautical mile is defined as a minute (1/60th of a degree) of latitude. So, a degree is 60.0 nautical miles, 69.0 statute miles, or 111 045 meters (111.045 km).  For the purpose of the kind of calculation we’re doing here, we’ll assume the earth is a sphere.  It isn’t really; it bulges a bit at the equator, but for a location-finder problem the spherical assumption is good enough.

This formula (111.045 km per degree) works fine when you’re moving north or south: if you are changing your latitude but not your longitude. It also works if you’re moving east or west — changing your longitude — along the equator.  But north or south of the equator, the lines of longitude get closer together, so if you move a degree to the east or west, you move less than 111.045 km.  The distance you actually move when you go one degree east or west is actually this number of km.

1
111.045 * cos(latitude)
The Great Circle Distance Formula
What’s the distance along the surface of the (spherical) earth between two arbitrary points, in degrees, given by their latitude and longitude in degrees?  That’s determined by the Spherical Cosine Law, or the Haversine Formula, which is this in MySQL syntax.

1
2
3
DEGREES(ACOS(COS(RADIANS(lat1)) * COS(RADIANS(lat2)) *
             COS(RADIANS(long1) - RADIANS(long2)) +
             SIN(RADIANS(lat1)) * SIN(RADIANS(lat2))))
It’s the distance along the surface of the spherical earth. It works equally well when the locations in question are your apartment and your local supermarket, or when they are the airports in Sydney, Australia and Reykjavik, Iceland. Notice that this result is in degrees.  That means we have to multiply it by  111.045, our value for km per degree, if we want the distance in km.

Querying the Nearest Locations
Cool. So to find the nearest points in a database to a given point, we can write a query like this.  Let’s use the point with latitude 42.81 and longitude -70.81. This MySQL query finds the fifteen nearest points to the given point in order of distance.

1
2
3
4
5
6
7
8
9
10
11
12
SELECT zip, primary_city, latitude, longitude,
      111.045* DEGREES(ACOS(COS(RADIANS(latpoint))
                 * COS(RADIANS(latitude))
                 * COS(RADIANS(longpoint) - RADIANS(longitude))
                 + SIN(RADIANS(latpoint))
                 * SIN(RADIANS(latitude)))) AS distance_in_km
 FROM zip
 JOIN (
     SELECT  42.81  AS latpoint,  -70.81 AS longpoint
   ) AS p
 ORDER BY distance_in_km
 LIMIT 15
Notice the use of the join to put latpoint and longpoint into the query. It’s convenient to write the query that way because latpoint and longpoint are referred to multiple times in the formula.

Great. We’re done, right? Not so fast! This query is accurate,  but it is very slow.

Optimization
The query is slow because It must compute the haversine formula for every possible pair of points. So it makes your MySQL server do a lot of math, and it forces it to scan through your whole location table.  How can we optimize this?  It would be nice if we could use indexes on the latitude and longitude columns in the table. To do this, let’s introduce a constraint. Let’s say we only care about points in the zip code table that are within 50 km of the (latpoint, longpoint). Let’s figure out how to use an index to eliminate points that are further away.

Remember, from our background information earlier in this article, that a degree of latitude is 111.045 km.  So, if we have an index on our latitude column, we can use a SQL clause like this to eliminate the points that are too far north or too far south to possibly be within 50 km.

1
2
latitude BETWEEN latpoint - (50.0 / 111.045)
             AND latpoint + (50.0 / 111.045)
This WHERE clause lets MySQL use an index to omit lots of latitude points before computing the haversine distance formula. It allows MySQL to perform a range scan on the latitude index.

Finally, we can use a similar but more complex SQL clause to eliminate points that are too far east or west.  This clause is more complex because degrees of longitude are smaller distances the further away from the equator we move. This is the formula.

1
2
longitude BETWEEN longpoint - (50.0 / (111.045 * COS(RADIANS(latpoint))))
              AND longpoint + (50.0 / (111.045 * COS(RADIANS(latpoint))))
So, putting it all together, this query finds the neareast 15 points that are within a  bounding box of 50km of the (latpoint,longpoint).

```sql
SELECT z.zip,
       z.primary_city,
       z.latitude, z.longitude,
       p.distance_unit
                * DEGREES(ACOS(COS(RADIANS(p.latpoint))
                * COS(RADIANS(z.latitude))
                * COS(RADIANS(p.longpoint) - RADIANS(z.longitude))
                + SIN(RADIANS(p.latpoint))
                * SIN(RADIANS(z.latitude)))) AS distance_in_km
 FROM zip AS z
 JOIN (   /* these are the query parameters */
       SELECT  42.81  AS latpoint,  -70.81 AS longpoint,
               50.0 AS radius,      111.045 AS distance_unit
   ) AS p
 WHERE z.latitude
    BETWEEN p.latpoint  - (p.radius / p.distance_unit)
        AND p.latpoint  + (p.radius / p.distance_unit)
   AND z.longitude
    BETWEEN p.longpoint - (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
        AND p.longpoint + (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
 ORDER BY distance_in_km
 LIMIT 15
```

This query, even though it’s a bit complicated, takes advantage of your latitude and longitude indexes and works efficiently.

Notice as part of the overall query that we JOIN this little subquery.

1
2
SELECT  42.81  AS latpoint,  -70.81 AS longpoint,
        50.0 AS radius,      111.045 AS distance_unit
The purpose of this is to make it easier for application software to provide the parameters needed for the query. latpoint and longpoint are the specific location for which you need nearby places. radius specifies how far away the search should go. Finally distance_unit should be 111.045 if you want to give your distances in kilometers and 69.0 if you want them in statute miles.

Limiting diagonal distance
But, this bounding-box query has the potential of returning some points that lie more than 50km diagonally from your (latpoint, longpoint): it’s only checking a bounding rectangle, not the diagonal distance. Let’s enhance the query to eliminate points more than 50km as the crow flies.

```sql
SELECT zip, primary_city,
       latitude, longitude, distance
  FROM (
 SELECT z.zip,
        z.primary_city,
        z.latitude, z.longitude,
        p.radius,
        p.distance_unit
                 * DEGREES(ACOS(COS(RADIANS(p.latpoint))
                 * COS(RADIANS(z.latitude))
                 * COS(RADIANS(p.longpoint - z.longitude))
                 + SIN(RADIANS(p.latpoint))
                 * SIN(RADIANS(z.latitude)))) AS distance
  FROM zip AS z
  JOIN (   /* these are the query parameters */
        SELECT  42.81  AS latpoint,  -70.81 AS longpoint,
                50.0 AS radius,      111.045 AS distance_unit
    ) AS p
  WHERE z.latitude
     BETWEEN p.latpoint  - (p.radius / p.distance_unit)
         AND p.latpoint  + (p.radius / p.distance_unit)
    AND z.longitude
     BETWEEN p.longpoint - (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
         AND p.longpoint + (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
 ) AS d
 WHERE distance <= radius
 ORDER BY distance
 LIMIT 15
```

Using Miles Instead of Km
Finally, many people need to use miles instead of km for their distances.  This is straightforward.  Just change the value of the distance_unit to 69.0.

That’s the query for a typical store-finder or location-finder application based on latitude and longitude.  You should be able to adapt it to your use without too much trouble.

Adapting this query to other location-table definitions
This query is, of course, written to run with a particular table definition for zip, a US zip code table.  That zip  table has columns named zip, primary_city, latitude, and longitude, among others. Notice that the table is referred to by FROM zip AS z in the query. That makes it have the alias z.

Your location table very likely has different columns. It should be straightforward to rewrite this query to use yours.  Look for the columns referred to as z.something in the query, and replace those with the column names from your table. So, for example, if your table is called SHOP and has shopname, shoplat, and shoplong columns, you’ll put z.shopname in place of z.primary_city and so forth. You’ll refer to your table by mentioning FROM SHOP as z in the query.

```sql
DELIMITER $$
DROP FUNCTION IF EXISTS `initial_bearing`$$
CREATE FUNCTION `initial_bearing`(
        lat1 DOUBLE, lon1 DOUBLE,
        lat2 DOUBLE, lon2 DOUBLE
     ) RETURNS DOUBLE
    NO SQL
    DETERMINISTIC
    COMMENT 'Returns the initial bearing, in degrees, to follow the great circle route
             from point (lat1,lon1), to point (lat2,lon2)'
    BEGIN
    RETURN (360.0 +
      DEGREES(ATAN2(
       SIN(RADIANS(lon2-lon1))*COS(RADIANS(lat2)),
       COS(RADIANS(lat1))*SIN(RADIANS(lat2)) - SIN(RADIANS(lat1))*COS(RADIANS(lat2))*
            COS(RADIANS(lon2-lon1))
      ))
     ) % 360.0;
END$$
DELIMITER ;
```

#### References:

- [1] http://www.plumislandmedia.net/mysql/haversine-mysql-nearest-loc/