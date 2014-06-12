### GDAL - Geospatial Data Abstraction Library

> Gdal: is a translator library for raster and vector geospatial data formats that is released under an X/MIT style Open Source license by the Open Source Geospatial Foundation. As a library, it presents a single raster abstract data model and vector abstract data model to the calling application for all supported formats. It also comes with a variety of useful commandline utilities for data translation and processing. 

[OgrInfo](http://www.gdal.org/ogrinfo.html)

Supports many different vector formats
- ESRI formats such as shapefiles, personal geodatabases and ArcSDE
- Other software such as MapInfo, GRASS, Microstation
- Open formats such as TIGER/Line, SDTS, GML, KML
- Databases such as MySQL, PostgreSQL, Oracle Spatial, Informix, ODBC

```bash
ogrinfo TM_WORLD_BORDERS-0.3.shp -al -so 

#-al = List all features of all layers (used instead of having to give layer names as arguments).
#-so = Summary Only: supress listing of features, show only the summary information like projection, schema, feature count and extents.
```

Output:

```
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
```

