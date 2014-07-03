##Assignment 7 - Final Project.

### Not Complete Until This Message is Gone!

#### Due: Thursday Jul 3rd by 12:00 NOON

#### Important Instructions for writing code in my class:

>
- Any project posted on Github AFTER 1200 noon will be considered for grading.
- Any projects that look to similar to another class mates will be considered cheating and will receive a grade of zero.
- Students can work with ONE partner, and submit a final project together. Both student will place thier names in the comment section of thier code, and both student will upload the same project to github. 

#### 1) Background

[PostGis](http://postgis.net/docs/manual-2.1/reference.html#PostGIS_Types)
[Google Rectangle](https://developers.google.com/maps/documentation/javascript/examples/rectangle-simple)

#### 2) Create a project folder:

Create a folder called `Assignment7` in your `public_html` folder. In this folder, copy the files from `/home/griffin/public_html/5443/BoundingBox/:

- Create 3 folders in your `Assignment7` directory:

- ![1]backend.php
- ![1]geo.js
- ![2]geoPHP
- ![1]index.php

#### 3) Queries to execute:

-  Given some bounding rectangle `R`:
    1. Select all features completely contained within `R`.
    2. Select all features that are in contact with `R`.
    3. Select all features that are within 100 miles, but not in contact or within `R`.
    2. Based on an input form, display only specified features within `R`.
- Given a point `P` and a radius `r`:
    3. Display all items within `r` distance from `P`. Draw a circle around this area.
    4. For each ship port, find the closest railway station.

#### 4) What 

#### 5) Sql Examples:

```sql
SELECT *
FROM state_buildings
WHERE state_buildings.wkb_geometry && ST_MakeEnvelope(-124.74288940429688,41.902277040963696, -113.49288940429688,32.02670629333614 );
```

```sql
-- && = intersects
-- @ = contains
SELECT *
FROM   earthquakes
WHERE  earthquakes.wkb_geometry 
    @
    ST_MakeEnvelope (
        -124.74288940429688,41.902277040963696,  
        -113.49288940429688,32.02670629333614, 
        4326)
```

Slow??
```sql
-- Multiply radius_mi * 1609.34 to get result in kilometers
SELECT *
FROM state_buildings
WHERE ST_Distance_Sphere(state_buildings.wkb_geometry, ST_MakePoint(your_lon,your_lat)) <= radius_mi
```

End Assignment

-----

#### Gathering and combining the shape files (side note):

```php
#Build array that holds the table structures of each shapefile
#feature (buildings, waterways, roads, etc...)
#I used this initially because I was selecting all data from 
#individual state files, then inserting each table into a combined
#table. This turned out to be too slow.
foreach($subdir as $sd){
    #Seperate filename and extension
	$ext = pathinfo("./texas/".$sd, PATHINFO_EXTENSION);
	$name = pathinfo("./texas/".$sd, PATHINFO_FILENAME);
    
    #if extension is a shapefile, we want to load it
	if($ext == 'shp'){
		$Sql = "select * from texas_{$name} LIMIT 1";
		$Result = $Conn->query($Sql);

		$TableKeys[$name] = array_keys($Result->fetch(PDO::FETCH_ASSOC));
		
		$TableKeys[$name][] = 'state';
	}
}

#Build array of state names from directories that already
#exist in the current folder
for($i=0;$i<sizeof($dir);$i++){
	if(!is_dir($dir[$i])){
		continue;
	}
	$States[] = $dir[$i];
}

#For every state, get all the GIS information from download.geofabrik.de
foreach($States as $state){
	$i=0;
    $state = strtolower($state);
	$r = rand(2,5);
	
	if(!is_dir($state)){
        exec("mkdir $state");
    }else{
    	echo"$state dir exists...\n";
    }
    
    echo "./{$state}/{$state}.zip ...\n";

    #If zip doesn't exist, go get it.
	if(!file_exists("{$state}.zip")){
	    exec("wget -w {$r} http://download.geofabrik.de/north-america/us/{$state}-latest.shp.zip -O {$state}.zip");
	}
	
    echo"Unzipping {$state}.zip \n";
    
    #Delete old files, and unzip again.
    #I do this, becuase the shape files may have been altered using ogrinfo
    exec("rm -f {$state}/*");
	exec("unzip {$state}.zip -d {$state}");
	echo"Processing files ....\n";
	$dir = scandir("./{$state}");
	array_shift($dir);
	array_shift($dir);
	
    
	foreach($dir as $d){
		$ext = pathinfo("./{$state}/".$d, PATHINFO_EXTENSION);
		$name = pathinfo("./{$state}/".$d, PATHINFO_FILENAME);
		if($ext == 'shp'){
			if($i==0){
                #Alter the shape file, and add a column to hold the states name.
				$command = "cd ./{$state}/ && ogrinfo {$d} -sql \"ALTER TABLE {$name} ADD COLUMN state varchar(48)\"";
				echo $command."\n";
		    	exec($command);
		    }
            #Load the shape file into PostgresSQL (much faster).
		    $command = "ogr2ogr -f PostgreSQL PG:dbname=5443 ./{$state}/{$d} -nln state_{$name} -update -progress -append";
		    echo $command."\n";
			exec($command);
            #I couldn't add information to the shapefile (probably is a way, but I didn't look
            #extremely hard), so I updated the "combined state_*" table and set the state
            #column to the state name (like Texas, New York, etc.) where state was null.
            #This worked because any shapefile that added rows to the table left state null,
            #so I just updated them after each shapefile completed.
			$AddStateSql = "UPDATE state_{$name} SET state = '$state' WHERE state IS NULL";
			$AddStateRes = $Conn->query($AddStateSql);
		}
	}
	$i++;
}
```


[1]: https://cdn1.iconfinder.com/data/icons/stilllife/24x24/filesystems/gnome-fs-directory.png
[2]: http://png-2.findicons.com/files/icons/2360/spirit20/20/file_php.png
[3]: http://www.lecollagiste.com/collanews/themes/lilina/web/media/folder.gif
