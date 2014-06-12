
[OgrInfo](http://www.gdal.org/ogrinfo.html)

```bash
ogrinfo TM_WORLD_BORDERS-0.3.shp -al -so 

#-al = List all features of all layers (used instead of having to give layer names as arguments).
#-so = Summary Only: supress listing of features, show only the summary information like projection, schema, feature count and extents.
```

Output:

>
INFO: Open of `TM_WORLD_BORDERS-0.3.shp'
      using driver `ESRI Shapefile' successful.
Layer name: TM_WORLD_BORDERS-0.3
Geometry: Polygon
Feature Count: 246
Extent: (-180.000000, -90.000000) - (180.000000, 83.623596)
Layer SRS WKT:
GEOGCS["GCS_WGS_1984",
    DATUM["WGS_1984",
        SPHEROID["WGS_84",6378137.0,298.257223563]],
    PRIMEM["Greenwich",0.0],
    UNIT["Degree",0.0174532925199433]]
FIPS: String (2.0)
ISO2: String (2.0)
ISO3: String (3.0)
UN: Integer (3.0)
NAME: String (50.0)
AREA: Integer (7.0)
POP2005: Integer (10.0)
REGION: Integer (3.0)
SUBREGION: Integer (3.0)
LON: Real (8.3)
LAT: Real (7.3)
