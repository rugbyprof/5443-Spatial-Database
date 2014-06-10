##Assignment 2 - Drawing a polygon on a map.

#### Due: Wednesday Jun 11th by 12:20
<span style="font-size:10px">
Assignment adapted from this article: 
http://www.maptechnica.com/how-to/example/how-to-draw-a-basic-polygon-in-googe-maps</span>
#### Important Instructions for writing code in my class:

>
1. Follow all of my instructions very carefully.
2. Name files and folders exactly as instructed.
3. Database names also must be exact (table names, field names, etc).
4. Your code must (eventually) run using my data on my machine, so naming everything as instructed is imperative. 
5. Code that errors, or doesn't run, won't be graded.
6. If you have concerns, refer to number # 1.

#### 1) Create Work Environment:

Download one of the following environments and place it on your personal machine. I am currently working
on getting the CS2 server configured for every user, but for now, I don't want to slow progress. Besides,
most developers develop locally then publish to the server, we might as well also. 

- [MAMP](http://www.mamp.info/en/downloads/)
- [AMPPS](http://www.softaculous.com/downloads)
- [XAMPP](https://www.apachefriends.org/download.html)

Each of these environments are slightly different, but are common in the following:

- Apache
- Mysql
- Php 

All will be installed on your local machine, essentially turning it into its own web server. No, that does
not mean you just turned your private machine into a publicy accessible web server, it takes a little
more than this. 



#### 2) Starter Code:

Create a folder called `PolygonOverlay` and place it in your document root. The document root, is the folder your local dev environment is configured to look for web pages.

Create a file called `index.php` inside the `PolygonOverlay` folder.

Place the following code inside the file:

```php
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple Polygon</title>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    <script>
// This example creates a simple polygon representing the Bermuda Triangle.

function initialize() {
  var mapOptions = {
    zoom: 5,
    center: new google.maps.LatLng(24.886436490787712, -70.2685546875),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  var bermudaTriangle;

  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  // Define the LatLng coordinates for the polygon's path.
  var triangleCoords = [
    new google.maps.LatLng(25.774252, -80.190262),
    new google.maps.LatLng(18.466465, -66.118292),
    new google.maps.LatLng(32.321384, -64.75737),
    new google.maps.LatLng(25.774252, -80.190262)
  ];

  // Construct the polygon.
  bermudaTriangle = new google.maps.Polygon({
    paths: triangleCoords,
    strokeColor: '#FF0000',
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillColor: '#FF0000',
    fillOpacity: 0.35
  });

  bermudaTriangle.setMap(map);
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
    <div id="map-canvas"></div>
  </body>
</html>
```
<span style="font-size:11px">Ref: https://developers.google.com/maps/documentation/javascript/examples/polygon-simple</span>

At this point, if your work environment is setup correctly, the index.php file should work showing the resulting polygon. To display your index file:

- MAMP
    - http://localhost:8888/PolygonOverlay/
- AMPPS
    - http://localhost:80/PolygonOverlay/

Now create a file called `db_connect.php` and place the following code in it:

```php
<?php

/* This file connects to your MySQL database. */

// Connection constants 
define('DB_HOST',     'localhost');
define('DB_USER',     'YOURUSERNAME');
define('DB_PASSWORD', 'YOURDBPASSWORD');
define('DB_DATABASE', 'YOURDBNAME');
define('DB_PORT',     3306);

// Error-checking to ensure you have set the values above before trying to run one of the examples
if(DB_USER     === 'REPLACEME' ||
    DB_PASSWORD === 'REPLACEME' ||
    DB_DATABASE === 'REPLACEME')
{
    die("You must set your database connection variables in db_connect.php before viewing this example!");
}

// Connect to the database using PHP's MySQLi object-oriented library
$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_DATABASE, DB_PORT);
if ($mysqli->connect_errno)
{
    die("Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error);
}
```

Create a file called `functions.php` and place the following code in it:

```php
<?php

/**
 * This function converts a WKT string into a PHP array of polygonal coordinate pairs.
 * @param string $wkt_str is the Well-Known-Text string representing one or more polygons
 * @return array Returns an array of polygons with sub arrays of coordinate pairs
 */ 

function convert_wkt_to_poly_arr($wkt_str)
{
  $ret_arr = array();
  $matches = array();

  preg_match('/\)\s*,\s*\(/', $wkt_str, $matches);
  
  if(empty($matches))
  {  
      $polys = array(trim($wkt_str));
  }
  else
  {
      $polys = explode($matches[0], trim($wkt_str));
  }
  foreach($polys as $poly)
  {
      $ret_arr[] = str_replace('(','',str_replace(')','',substr($poly, stripos($poly,'(')+2, stripos($poly,')')-2))); 
  }

  return $ret_arr;

}
```

`db_connect.php` and `functions.php` should both be saved in your `PolygonOverlay` folder. Your resulting directory structure should look like the following:

- ![1] PolygonOverlay
    - ![2] db_connect.php
    - ![2] functions.php
    - ![2] index.php



### 3) Dynamic Polygon Display

1. Display a multi-select field that contains a list of all countries that are currently in our database of world borders.
2. When a user chooses 1 or more countries (and submits the form), select the coordinates of each country from the database and display randomly colored polygon over each country.
3. The map should be displayed above that map even after submission so the user can choose a different country (or set of countries).


Some helpful code snippets:

```sql
SELECT AsText(SHAPE) FROM `world_borders`
```

```php
function sql_to_coordinates($blob)
    {
        $blob = str_replace("))", "", str_replace("POLYGON((", "", $blob));
        $coords = explode(",", $blob);
        $coordinates = array();
        foreach($coords as $coord)
        {
            $coord_split = explode(" ", $coord);
            $coordinates[]=array("lat"=>$coord_split[0], "lng"=>$coord_split[1]);
        }
        return $coordinates;
    }
```



[1]: https://cdn1.iconfinder.com/data/icons/stilllife/24x24/filesystems/gnome-fs-directory.png
[2]: http://png-2.findicons.com/files/icons/2360/spirit20/20/file_php.png
[3]: http://www.lecollagiste.com/collanews/themes/lilina/web/media/folder.gif
