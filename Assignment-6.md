##Assignment 6 - Earthquakes in Clicked State.

#### Due: Monday Jun 30th by 12:20 (class time)

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

#### 3) Database

Your going to connect to the cs2 Mysql database to get your data. Just like we talked about obout on Thursday using the 5443 database and user.

### 4) Actual Assignment

Your Assignment6 folder should look like:

- ![1] Assignment6
    - ![1] geoPHP
    - ![2] backend.php
    - ![2] geo.js
    - ![2] index.php


Since the Mysql database could not be upgraded to 5.6, and the GIS extensions were not fully available, we will scale back and simply execute 1 query, and display 2 features:

- Query:
    - Select all the earthquakes that occured within the state that was clicked 
- Display
    - Markers for each earthquake within the state.
    - A single polygon highlighting the state that was clicked. 
    - 
You should be able to implement this by monday class time. It's a repeat of things already done. 

[1]: https://cdn1.iconfinder.com/data/icons/stilllife/24x24/filesystems/gnome-fs-directory.png
[2]: http://png-2.findicons.com/files/icons/2360/spirit20/20/file_php.png
[3]: http://www.lecollagiste.com/collanews/themes/lilina/web/media/folder.gif
