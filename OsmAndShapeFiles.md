### Open Street Maps

[OpenStreetMap](http://www.openstreetmap.org/#map=5/37.996/-95.845) (OSM) is a collaborative project to create a free editable map of the world. Two major 
driving forces behind the establishment and growth of OSM have been restrictions on use or availability of map information across much of the world and the advent of inexpensive portable satellite navigation devices [[1](http://en.wikipedia.org/wiki/OpenStreetMap)]. 

The best way to interface with Open Street Maps is by using [PostgreSQL](http://www.postgresql.org/), but we started with [MySQL](http://mysql.com) so that's the backend we will use for now.

[Planet OSM](http://wiki.openstreetmap.org/wiki/Planet.osm) is a web site wiki that contains links to Open Street Maps map data for the entire planet! You can have it all for a mere ~350GB download :flushed:

Since we don't want the entire planet, lets work with something smaller. We can grab different extracts for different locations at [GeoFabrik](http://download.geofabrik.de/). The files range in size from entire 
continents down to a single state. 
- [NorthAmerica.osm.bz2](http://download.geofabrik.de/north-america-latest.osm.bz2) 
- [India.osm.bz2](http://download.geofabrik.de/asia/india-latest.osm.bz2)
- [Texas.osm.bz2](http://download.geofabrik.de/north-america/us/texas-latest.osm.bz2)
- [Texas.shp.zip](http://download.geofabrik.de/north-america/us/texas-latest.shp.zip)

To grab a bzipped `osm` file from geofabrik you can use the curl command: 
```bash
curl —location —globoff http://download.geofabrik.de/north-america/us/texas-latest.osm.bz2 -o texas.osm.bz2
```
- `-location` If the server reports that the requested page has moved to a different location (indicated with a Location: header and a 3XX response code), this option will make curl redo the request on the new place.
- `-o outputfile.ext` The -o option will re-name the file you grabbed from the server.


To uncompress the bzipped file, use the `bunzip` command. If were going to use [osmosis](http://wiki.openstreetmap.org/wiki/Osmosis) 
to further filter out desired GIS information, you don't need to uncompress the file, as `osmosis` has
no problems dealing with the compressed file.
```bash
bunzip2 texas.osm.bz2 
```

Here is an example `osmosis` command that filters all the "road" info, and only retains information that
deals with restaurants.

```bash
/usr/local/bin/osmosis --read-xml texas.osm --tf reject-relations --tf reject-ways --tf accept-nodes amenity=restaurant --write-xml restaurants.osm
```

This still leaves us with an `Osm` file. Remember that `Osm` stands for `Open Street Maps`, and is stored in an `XML` like format. This isn't exactly the format that we want to deal with. We would like to leverage the power of Mysql's spatial extensions to perform spatial queries on our data. 

To do that, we must get the `Osm` data into our database. Although it is possible to get `Osm` files into our Mysql database, it is cumbersome and just plain not simple. The `Gdal` library proved to be the most reliable solution (so far), so that brings us back to `shape files`.

#### Shape Files

We have already experimented with the `Gdal` library, more specifically the `ogr2ogr` command. Lets
look at an example `ogr2ogr` command to load shape file data into our Mysql database. Where did I 
get a shape file? Well, [GeoFabrik](http://download.geofabrik.de/) also creates `shape` files of certain
extractions that aren't too big. 

First I need to grab my shape file (lets use `wget` this time):

```bash
wget http://download.geofabrik.de/north-america/us/texas-latest.shp.zip -O Texas.shp.zip && unzip Texas.shp.zip
```
>
- `-O` All downloaded content is written to the file after the `-O` flag. 
- `&&` Says do the `wget` AND when your done, unzip the file. `&&` is not just used for wget, but can be used to run many commands back to back.

After we download and unzip the Texas shape file, we will see a group of shape files with many different names and extensions [[2](http://en.wikipedia.org/wiki/Shapefile)].

#### Mandatory files :

>
- `.shp` — shape format; the feature geometry itself
- `.shx` — shape index format; a positional index of the feature geometry to allow seeking forwards and backwards quickly
- `.dbf` — attribute format; columnar attributes for each shape, in dBase IV format

#### Optional files :
>
- `.prj` — projection format; the coordinate system and projection information, a plain text file describing the projection using well-known text format
- `.sbn` and .sbx — a spatial index of the features
- `.fbn` and .fbx — a spatial index of the features for shapefiles that are read-only
- `.ain` and .aih — an attribute index of the active fields in a table
- `.ixs` — a geocoding index for read-write shapefiles
- `.mxs` — a geocoding index for read-write shapefiles (ODB format)
- `.atx` — an attribute index for the .dbf file in the form of shapefile.columnname.atx (ArcGIS 8 and later)
- `.shp.xml` — geospatial metadata in XML format, such as ISO 19115 or other XML schema
- `.cpg` — used to specify the code page (only for .dbf) for identifying the character encoding to be used

In each of the .shp, .shx, and .dbf files, the shapes in each file correspond to each other in sequence (i.e., the first record in the .shp file corresponds to the first record in the .shx and .dbf files, etc.). The .shp and .shx files have various fields with different endianness, so an implementor of the file formats must be very careful to respect the endianness of each field and treat it properly.

Shapefiles deal with coordinates in terms of X and Y, although they are often storing longitude and latitude. 

#### Loading Mysql

Now that we grabbed our Texas shape file, we need to get it put into our database. Let's put to use our `ogr2ogr` command. 

>
- `$1` = Database Name
- `$2` = Host Name
- `$3` = User Name
- `$4` = Password
- `$5` = Shape File Name
- `$6` = Table Name

```bash
ogr2ogr -f MySQL MySQL:$1,host=$2,user=$3,password=$4 $5 -nln $6 -update -overwrite -lco engine=MYISAM
```
>
- `-nln` Assign an alternate name to the new layer
- `-update` Open existing output datasource in update mode rather than trying to create a new one.
- `-overwrite` Delete the output layer and recreate it empty
- `lco` NAME=VALUE: 
    - Layer creation option (format specific)
    - MyISAM was the default storage engine for the MySQL relational database management system versions prior to 5.5. It is based on the older ISAM code but has many useful extensions [[3](http://en.wikipedia.org/wiki/MyISAM)].

For example (removed user and pass so we don't have uninvited guests), the following command will load the shape file `places.shp` into the database `5443_Texas` with the table name `places`.

```bash
ogr2ogr -f MySQL MySQL:5443_Texas,host=localhost,user=USER,password=PASS places.shp -nln places -update -overwrite -lco engine=MYISAM
```

The above command processes one file. The following small script (with no error checking) will find all `.shp` files in the current directory and process them.

```php
<?php

$args = arguments($argv);

print_r($args);

if(!array_key_exists('dbname',$args)){
    echo "ERROR: dbname needed (e.g. --db mydb)\n";
    exit;
}
if(!array_key_exists('username',$args)){
    echo "ERROR: username needed (e.g. --user yourusername)\n";
    exit;
}
if(!array_key_exists('password',$args)){
    echo "ERROR: password needed (e.g. --pass mydb)\n";
    exit;
}
if(!array_key_exists('host',$args)){
    echo "WARNING: host not set (e.g. --host localhost). Assuming 'localhost'\n$
    $args['host'] = 'localhost';
}

$DBNAME = $args['db'];
$HOST = $args['host'];
$USER = $args['user'];
$PASSWORD = $args['pass'];


$files = scandir('.');

$filtered = array();

foreach($files as $file){
    if(strstr($file,'.')){
        list($dir,$basename,$ext,$filename) = array_values(pathinfo($file));

        if($ext == 'shp')
            $filtered[] = array($basename,$filename);
    }
}


foreach($filtered as $entry){
    list($file_name,$table_name) = $entry;
    $cmd = "ogr2ogr -f MySQL MySQL:{$DBNAME},host={$HOST},user={$USER},password$
    echo"Executing: $cmd\n\n";
    exec($cmd);
}

function arguments ( $args )
{
    array_shift( $args );
    $args = join( $args, ' ' );

    preg_match_all('/ (--\w+ (?:[= ] [^-]+ [^\s-] )? ) | (-\w+) | (\w+) /x', $args, $match );
    $args = array_shift( $match );

    /*
        Array
        (
            [0] => asdf
            [1] => asdf
            [2] => --help
            [3] => --dest=/var/
            [4] => -asd
            [5] => -h
            [6] => --option mew arf moo
            [7] => -z
        )
    */

    $ret = array(
        'input'    => array(),
        'commands' => array(),
        'flags'    => array()
    );

    foreach ( $args as $arg ) {

        // Is it a command? (prefixed with --)
        if ( substr( $arg, 0, 2 ) === '--' ) {

            $value = preg_split( '/[= ]/', $arg, 2 );
            $com   = substr( array_shift($value), 2 );
            $value = join($value);

            $ret['commands'][$com] = !empty($value) ? $value : true;
            continue;

        }

        // Is it a flag? (prefixed with -)
        if ( substr( $arg, 0, 1 ) === '-' ) {
            $ret['flags'][] = substr( $arg, 1 );
            continue;
        }

        $ret['input'][] = $arg;
        continue;

    }

    return $ret;
}


```

#### References:
- [1] http://en.wikipedia.org/wiki/OpenStreetMap
- [2] http://en.wikipedia.org/wiki/Shapefile
- [3] http://en.wikipedia.org/wiki/MyISAM
