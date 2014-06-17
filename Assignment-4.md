##Assignment 4 - Drawing Polygons Part 2 - Military Installations.

#### Due: Friday Jun 20th by 12:20

#### Important Instructions for writing code in my class:

>
1. Follow all of my instructions very carefully.
2. Name files and folders exactly as instructed.
3. Database names also must be exact (table names, field names, etc).
4. Your code must (eventually) run using my data on my machine, so naming everything as instructed is imperative. 
5. Code that errors, or doesn't run, won't be graded.
6. If you have concerns, refer to number # 1.

#### 1) Background

Refer to [Mysql Haversine Distance](https://github.com/rugbyprof/5443-Spatial-Database/blob/master/Mysql_Haversine_Distance.md lesson for questions) and [Osm And ShapeFiles](https://github.com/rugbyprof/5443-Spatial-Database/blob/master/OsmAndShapeFiles.md) for background.


#### 2) Get Data

Get the tiger/data shape file from [here](ftp://ftp2.census.gov/geo/tiger/TIGER2013/MIL/tl_2013_us_mil.zip) and place it inside your MilitaryInstallations folder.

Run the following command to insert it into your database:

- $1 = Database Name
- $2 = Host Name
- $3 = User Name
- $4 = Password
- $5 = Shape File Name
- $6 = Table Name (use shape file name to be safe)

```bash
ogr2ogr -f MySQL MySQL:$1,host=$2,user=$3,password=$4 $5 -nln $6 -update -overwrite -lco engine=MYISAM
```

#### 3) Getting Started:

Create a folder called `MilitaryInstallations` and place it in your document root. The document root, is the folder your local dev environment is configured to look for web pages.

Create a file called `index.php` inside the `MilitaryInstallations` folder.

Place the following code inside the file:

> [Assignment4-starter.php](https://github.com/rugbyprof/5443-Spatial-Database/blob/master/Assignment4-starter.php)

Replace the connection string that I used in the starter code with your own information.

```php
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

`db_connect.php` and `functions.php` should both be saved in your `MilitaryInstallations` folder. Your resulting directory structure should look like the following:

- ![1] MilitaryInstallations
    - ![2] db_connect.php
    - ![2] functions.php
    - ![2] index.php



### 4) Dynamic Military Base Display

1. Use the click event and form that is provided for you in the [Assignment4-starter.php](https://github.com/rugbyprof/5443-Spatial-Database/blob/master/Assignment4-starter.php) file to find
the `N`, closest military installations to your mouse click. 
2. Add to your form either a dropdown, or a text box that will allow the user to choose how
many bases your map will show. 
3. Make sure that each polygon displayed is a different color. 



[1]: https://cdn1.iconfinder.com/data/icons/stilllife/24x24/filesystems/gnome-fs-directory.png
[2]: http://png-2.findicons.com/files/icons/2360/spirit20/20/file_php.png
[3]: http://www.lecollagiste.com/collanews/themes/lilina/web/media/folder.gif
