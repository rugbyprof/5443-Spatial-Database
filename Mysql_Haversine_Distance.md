### MySQL - Nearest Point of Interest Query

Let me start by saying I came across this article http://www.plumislandmedia.net/mysql/haversine-mysql-nearest-loc/ written by [Ollie Jones](http://www.plumislandmedia.net/author/admin/), and as much as I would like to take credit for his well written article, I wouldn't dare. Below is an adapted version to our class. 

Now on with the lesson:

One of the most common questions in our GIS enabled world is: "What's the closest _______ to my current location?" 

| Location aware App|
|:--------------:|
|![Restaurants](http://cs2.mwsu.edu/~griffin/5443/media/burger_king.400.png)|

We all use our smart phones to perform location aware searches. So, instead of relying on someone else app, lets create our own. To do this, we need to:

1. Get accurate location data
2. Obtain our current location
3. Perform distance calculations to Points of Interest (POI) near our current location.

I will address each of these points, but lets start with some definitions first.

### Geo Terms
Latitudes and longitudes are expressed in (at least) a couple different formats:

- Degrees Minutes Seconds 
    - Lat: 43° 42' 46.4148'' N
    - Lon: 79° 20' 30.5988'' W
- Decimal Degrees 
    - Lat: 43.712893
    - Lon: -79.341833

As you can see, the decimal degrees looks a lot more friendly, at least from a computer science perspective. Degrees Minutes Seconds, just looks like a lot of string processing to me, so we'll use the latter. 

--

#### What is Latitude and Longitude?

We've discussed this already, but let's summarize anyway.


| Lat Lon        |   Prime Meridian           |
|:--------------:|:------------:|
|![](http://cs2.mwsu.edu/~griffin/5443/media/latlon.400.png)| ![](http://cs2.mwsu.edu/~griffin/5443/media/prim_meridian.png)|


#### Latitude

Latitude describes how far north or south of the equator a point is located.  Points along the equator have latitudes of zero. The north pole has a positive (north) latitude of 90, and the south pole a negative (south) latitude of -90. Accordingly, northern-hemisphere locations have positive latitude, and southern-hemisphere locations have negative latitude.

#### Longitude 

Longitude describes how far east a point is, from the prime meridian: an arbitrary line on the earth surface running from pole to pole. The Empire State Building in New York City, USA, has a negative (west) longitude, specifically -73.9857. The Taj Mahal in Agra, India, has a positive (east) longitude, specifically 78.0422. The Greenwich Observatory near London, England, has, by definition, a longitude of zero.

>
- Latitudes are values in the range [-90, 90]
- Longitudes are values in the range (-180, 180]

#### What is a Degree?

A nautical mile is defined as a minute (1/60th of a degree) of latitude. So, a degree is 60.0 nautical miles, 69.0 statute miles, or 111,045 meters (69 mi). 

When using our trigonometric functions, were making the assumption that the earth is a perfect sphere. The fact is, it's not. It's more like a squished ball that bulges around it's center (or in the Earths case, the equator). Does this effect our distance calculations 

| Shape of Earth|
|:--------------:|
|![Restaurants](http://cs2.mwsu.edu/~griffin/5443/media/earthshape.png)|

For the purpose of the kind of calculation we’re doing here, we’ll assume the earth is a sphere.  It isn’t really; it bulges a bit at the equator. However, whatever error we may run into, we can compensate for, at least to the point where it will still seem very accurate for the everyday user.

#### Compensating for the Squish

This formula (69 miles per degree) works fine when you’re moving north or south: if you are changing your latitude but not your longitude. It also works if you’re moving east or west — changing your longitude — along the equator.  But north or south of the equator, the lines of longitude get closer together, so if you move a degree to the east or west, you move less than 69 mi.  The distance you actually move when you go one degree east or west is actually this number of miles.

```sql
69 * cos(latitude)
```

`cos(0) = 1`, so at the equator, moving 1 degree east or west is 69 miles as previously stated, 

#### The Great Circle Distance Formula
What’s the distance along the surface of the (spherical) earth between two arbitrary points, in degrees, given by their latitude and longitude in degrees?  That’s determined by the Spherical Cosine Law, or the Haversine Formula, which is this in MySQL syntax.


```sql
DEGREES(ACOS(COS(RADIANS(lat1)) * COS(RADIANS(lat2)) *
             COS(RADIANS(long1) - RADIANS(long2)) +
             SIN(RADIANS(lat1)) * SIN(RADIANS(lat2))))
```

It’s the distance along the surface of the spherical earth. It works equally well when the locations in question are your apartment and your local supermarket, or when they are the airports in Sydney, Australia and Reykjavik, Iceland. Notice that this result is in degrees.  That means we have to multiply it by 69, our value for miles per degree, if we want the distance in miles.

#### Querying the Nearest Locations
Cool. So to find the nearest points in a database to a given point, we can write a query like this.  Let’s use the point with latitude 42.81 and longitude -70.81. This MySQL query finds the fifteen nearest points to the given point in order of distance.

```sql
SELECT m.fullname, m.latitude, m.longitude,
      69 * DEGREES(ACOS(COS(RADIANS(p.latpoint))
                 * COS(RADIANS(m.latitude))
                 * COS(RADIANS(p.longpoint) - RADIANS(m.longitude))
                 + SIN(RADIANS(m.latitude))
                 * SIN(RADIANS(m.latitude)))) AS distance_in_miles
 FROM military_installations2 m
 JOIN (
     SELECT  42.81  AS latpoint,  -70.81 AS longpoint
   ) AS p
 ORDER BY distance_in_miles
 LIMIT 15
 ```
 
Notice the use of the join to put latpoint and longpoint into the query. It’s convenient to write the query that way because latpoint and longpoint are referred to multiple times in the formula.

This solution is correct and accurate, but it could be slow. So some optimization is necessary.

#### Optimization
The query is slow because it must compute the Haversine formula for every possible pair of points. So it makes your MySQL server do a lot of math, and it forces it to scan through your whole location table.  How can we optimize this?  It would be nice if we could use indexes on the latitude and longitude columns in the table. To do this, let’s introduce a constraint. Let’s say we only care about points in the military installations table that are within 50 mi of the (latpoint, longpoint). Let’s figure out how to use an index to eliminate points that are further away.

Remember, from our background information earlier in this article, that a degree of latitude is 69 mi.  So, if we have an index on our latitude column, we can use a SQL clause like this to eliminate the points that are too far north or too far south to possibly be within 50 miles.

```sql
latitude BETWEEN latpoint - (50.0 / 69)
             AND latpoint + (50.0 / 69)
```

This WHERE clause lets MySQL use an index to omit lots of latitude points before computing the Haversine distance formula. It allows MySQL to perform a range scan on the latitude index.

Finally, we can use a similar but more complex SQL clause to eliminate points that are too far east or west.  This clause is more complex because degrees of longitude are smaller distances the further away from the equator we move. This is the formula.

```sql
longitude BETWEEN longpoint - (50.0 / (69 * COS(RADIANS(latpoint))))
              AND longpoint + (50.0 / (69 * COS(RADIANS(latpoint))))
```

So, putting it all together, this query finds the neareast 15 points that are within a  bounding box of 50 miles of the `(latpoint,longpoint)`.

```sql
SELECT m.fullname,
       m.latitude, 
       m.longitude,
       p.distance_unit
                * DEGREES(ACOS(COS(RADIANS(p.latpoint))
                * COS(RADIANS(m.latitude))
                * COS(RADIANS(p.longpoint) - RADIANS(m.longitude))
                + SIN(RADIANS(p.latpoint))
                * SIN(RADIANS(m.latitude)))) AS distance_in_mi
 FROM military_installations2 AS m
 JOIN (   /* these are the query parameters */
       SELECT  42.81  AS latpoint,  -70.81 AS longpoint,
               50.0 AS radius,      69 AS distance_unit
   ) AS p
 WHERE m.latitude
    BETWEEN p.latpoint  - (p.radius / p.distance_unit)
        AND p.latpoint  + (p.radius / p.distance_unit)
   AND m.longitude
    BETWEEN p.longpoint - (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
        AND p.longpoint + (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
 ORDER BY distance_in_mi
 LIMIT 15
```

This query, even though it’s a bit complicated, takes advantage of your latitude and longitude indexes and works efficiently.

Notice as part of the overall query that we JOIN this little subquery.

```sql
SELECT  42.81  AS latpoint,  -70.81 AS longpoint,
        50.0 AS radius,      69 AS distance_unit
```

The purpose of this is to make it easier for application software to provide the parameters needed for the query.
 
- `latpoint` and `longpoint` are the specific location for which you need nearby places.
- `radius` specifies how far away the search should go. 
- `distance_unit` should be 111.045 if you want to give your distances in kilometers and 69.0 if you want them in statute miles.

#### Limiting diagonal distance
But, this bounding-box query has the potential of returning some points that lie more than 50 miles diagonally from your `(latpoint, longpoint)`: it’s only checking a bounding rectangle, not the diagonal distance. 

| Bounding Box|
|:--------------:|
|![Restaurants](http://cs2.mwsu.edu/~griffin/5443/media/bounding_box.png)|
|Using the previous formula, we could return points as far out as the red circles.Obviously not acceptable.|

Enhance the query to eliminate points more than 50 miles away but still in the bounding box, and accept only points within the circle (as the crow flies).

```sql
SELECT fullname, latitude,longitude,distance
  FROM (
 SELECT m.fullname,
        m.latitude, m.longitude,
        p.radius,
        p.distance_unit
                 * DEGREES(ACOS(COS(RADIANS(p.latpoint))
                 * COS(RADIANS(m.latitude))
                 * COS(RADIANS(p.longpoint - m.longitude))
                 + SIN(RADIANS(p.latpoint))
                 * SIN(RADIANS(m.latitude)))) AS distance
  FROM military_installations2 AS m
  JOIN (   /* these are the query parameters */
        SELECT  42.81  AS latpoint,  -70.81 AS longpoint,
                50.0 AS radius,      69 AS distance_unit
    ) AS p
  WHERE m.latitude
     BETWEEN p.latpoint  - (p.radius / p.distance_unit)
         AND p.latpoint  + (p.radius / p.distance_unit)
    AND m.longitude
     BETWEEN p.longpoint - (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
         AND p.longpoint + (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
 ) AS d
 WHERE distance <= radius
 ORDER BY distance
 LIMIT 15
```

#### Using Kilometers Instead of Miles
Finally, many people need to use km instead of mi for their distances.  This is straightforward.  Just change the value of the distance_unit to 111.045


#### Haversine as a Stored Function


```sql
DELIMITER $$
DROP FUNCTION IF EXISTS haversine$$
 
CREATE FUNCTION haversine(
        lat1 FLOAT, lon1 FLOAT,
        lat2 FLOAT, lon2 FLOAT
     ) RETURNS FLOAT
    NO SQL DETERMINISTIC
    COMMENT 'Returns the distance in degrees on the Earth
             between two known points of latitude and longitude'
BEGIN
    RETURN DEGREES(ACOS(
              COS(RADIANS(lat1)) *
              COS(RADIANS(lat2)) *
              COS(RADIANS(lon2) - RADIANS(lon1)) +
              SIN(RADIANS(lat1)) * SIN(RADIANS(lat2))
            ));
END$$
 
DELIMITER ;
```

To use this function, you need to know the following things:

- the latitude and longitude of a starting point
- the latitude and longitude of an ending point
- the number of kilometers (111.045), statute miles (69), or nautical miles (60) in a degree of latitude.

Lets use this stored Haversine function to look in our military_installations table and find the ten closest installations.

```sql
SELECT fullname, latitude, longitude,
       69*haversine(latitude,longitude,latpoint, longpoint) AS distance_in_miles
 FROM military_installations
 JOIN (
     SELECT  42.81  AS latpoint,  -70.81 AS longpoint
   ) AS p
 ORDER BY distance_in_miles
 LIMIT 10
```

Again the value of the Haversine function is returned in degrees of longitude. Multiplying that value by 69 converts it to miles.

### Putting it all Together


#### 1. Obtaining Location Data

We already discussed [GDAL](http://www.gdal.org/) and the power it gives us with `ogr2ogr` in [this](https://github.com/rugbyprof/5443-Spatial-Database/blob/master/OsmAndShapeFiles.md) lesson, so lets leverage GDAL from the previous lesson to grab and load `.shp` files into `MySQL`. This can be any location information pertinent to the problem your trying to solve.  

#### 2. Getting Current Location

```javascript
google.maps.event.addListener(map, "click", function(event) {
    var lat = event.latLng.lat();
    var lng = event.latLng.lng();
    // populate yor box/field with lat, lng
    alert("Lat=" + lat + "; Lng=" + lng);
});
```

#### 3. Haversine Stored Function

Now you can use the Haversine stored function that we created to find points of interest that we obtained by clicking on our google map. 

#### References:

- [1] http://www.plumislandmedia.net/mysql/haversine-mysql-nearest-loc/
- [2] http://www.plumislandmedia.net/mysql/stored-function-haversine-distance-computation/