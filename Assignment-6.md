##Assignment 6 - Spatial Queries.

#### Due: Wednesday Jun 25th by 12:20

#### Important Instructions for writing code in my class:

>
1. Follow all of my instructions very carefully.
2. Name files and folders exactly as instructed.
3. Database names also must be exact (table names, field names, etc).
4. Your code must (eventually) run using my data on my machine, so naming everything as instructed is imperative. 
5. Code that errors, or doesn't run, won't be graded.
6. If you have concerns, refer to number # 1.

#### 1) Background

Refer to [Mysql Spatial Functions](http://dev.mysql.com/doc/refman/5.0/en/spatial-analysis-functions.html) as reference.


#### 2) Create a project folder:

Create a folder called `SpatialQueryAssignment1` in your `public_html` folder. In this folder, create two files:

- ![2] index.php
- ![2] backend.php

#### 3) Get Data

- Create 3 folders in your `SpatialQueryAssignment1` directory:

    - ![1] Volcanoes
    - ![1] State_Borders
    - ![1] Earth_Quakes

- Get the following shape files and place each in it's corresponding folder: 

    - [Volcanoes](http://dds.cr.usgs.gov/pub/data/nationalatlas/volcanx020_nt00036.tar.gz) - http://dds.cr.usgs.gov/pub/data/nationalatlas/volcanx020_nt00036.tar.gz 
    - [State_Borders](http://dds.cr.usgs.gov/pub/data/nationalatlas/statesp020_nt00032.tar.gz) - http://dds.cr.usgs.gov/pub/data/nationalatlas/statesp020_nt00032.tar.gz
    - [Earth_Quakes](http://dds.cr.usgs.gov/pub/data/nationalatlas/quksigx020_nt00067.tar.gz) - http://dds.cr.usgs.gov/pub/data/nationalatlas/quksigx020_nt00067.tar.gz

- `cd` into each folder, one at a time and run the following command:
    - `tar -zxf shape_file_name.tar.gz`

    - The `tar` command is the `linux` version of a `zip` file. The difference is, it doesn't compress the files. It simply places them in a single container. So, and common practice is to "tar" the files together, then compress them. This is what the `gz` extension means: it's been `gzipped`. So, now we need to uncompress (`gunzip`) and and get the files out of the the `tar` (tape archive) file.
    - `tar -zxf`
        - `z` means `gunzip` or uncompress.
        - `x` means `extract` or remove from the tape archive (tar).
        - `f` tells which file to run the command on. 

    - Now the shape files have been extracted and uncompressed, lets load them in your database.
    
- Run the following commands to insert it into your database:

    - $1 = Database Name
    - $2 = Host Name
    - $3 = User Name
    - $4 = Password
    - $5 = Shape File Name
    - $6 = Table Name (use shape file name to be safe, without the `.shp` extension)

```bash
user@cs2: cd Volcanoes
user@cs2: ogr2ogr -f MySQL MySQL:$1,host=$2,user=$3,password=$4 volcanx020.shp -nln Volcanoes -update -overwrite -lco engine=MYISAM
```
```bash
user@cs2: cd State_Borders
user@cs2: ogr2ogr -f MySQL MySQL:$1,host=$2,user=$3,password=$4 statesp020.shp -nln State_Borders -update -overwrite -lco engine=MYISAM
```
```bash
user@cs2: cd Earth_Quakes
user@cs2: ogr2ogr -f MySQL MySQL:$1,host=$2,user=$3,password=$4 quksigx020.shp -nln Earth_Quakes -update -overwrite -lco engine=MYISAM
```
#### 4) Getting Started:

- Add your `db_connect.php` and `functions.php` to your directory. Your resulting directory structure should look like this:

- ![1] SpatialQueryAssignment1
    - ![2] backend.php
    - ![2] db_connect.php
    - ![2] functions.php
    - ![2] index.php

Use your index.php, and backend.php from your previous assignment. If you want my copies, you can get them from here:

- `wget http://cs.mwsu.edu/~griffin/5443/MilitaryInstallations/index.txt`
- `wget http://cs.mwsu.edu/~griffin/5443/MilitaryInstallations/backend.txt`

Then rename each file to have a `.php` extension. I put `.txt` extensions so the server wouldn't "execute" them when you ran the wget command, it simply thought they were txt files, and sent the actual php code.


### 4) Actual Assignment

1. Select all of the earth quakes in one state (and display).
2. Select all of the rail roads that cross into one state.
3. Select the  (5) closest military installation to each indian reservation.
4. For each ship port, find the closest railway station.

Example Form:

```html
<head>
<script>
   <!-- include jquery  -->

         $( "#RunQuery" ).click(function() {
             $.ajax({
                  type: "POST",
                  url: 'backend.php',
                  data: {
                     query: $('#QueryNum').val();
                  },
                  success: success,
                  dataType: dataType
                }).done(function( data ) {
                    alert( "Data Loaded: " + data );
                    if(data.query_number == 1)
                        Query1Handler(data);
                    else if (data.query_number == 2)
                     //
                    //
                    //
                    //
                });
         });
</script>
</head

<form>
Run Query: <input type="text" id="QueryNum"> (1-4) <input ="button" id="RunQuery" value="Run Query">
</form>
```


[1]: https://cdn1.iconfinder.com/data/icons/stilllife/24x24/filesystems/gnome-fs-directory.png
[2]: http://png-2.findicons.com/files/icons/2360/spirit20/20/file_php.png
[3]: http://www.lecollagiste.com/collanews/themes/lilina/web/media/folder.gif
