##Assignment 6 - Spatial Queries.

#### Due: Monday Jun 30th by Midnight

#### Notice: 

Assignment 6 & 7 were switched. This will be an extended version of the Earthquake query,
and assignment 7 will use PostGreSQL.

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

Create a folder called `Assignment6` in your `public_html` folder. 

In this folder, grab the following from: `/home/griffin/public_html/5443/Assignment6-Starter`

Example Copy Command:

```bash
# Go to your Assignment6 folder:
$ cd public_html/Assignment6

# Then copy from my folder:
# cp target destination (the 'dot' means 'here')
$ cp /home/griffin/public_html/5443/Assignment6-Starter/geo.js .

# To copy a folder:
$ cp -r /home/griffin/public_html/5443/Assignment6-Starter/geoPHP .
```
- ![1] geoPHP (copy entire folder)
- ![2] geo.js
- ![2] index.php
- ![2] backend.php

#### 3) Get Data & Grab Files

- Data: Your going to connect to the cs2 Mysql database to get your data. Just like we talked about obout on Thursday using the 5443 database and user.



#### 4) Getting Started:

Your Assignment6 folder should look like:

- ![1] Assignment6
    - ![2] backend.php
    - ![2] geo.js
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
                  }
                }).done(function( data ) {
                    alert( "Data Loaded: " + data );
                    jsonJSON.parse(data);
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
