## Example Shape File Import

### Step 1:

Get your shape file:


Here is an example command:
```
ogr2ogr -f "MySQL" MySQL:"5443_Spatial_DB,user=db_user,host=localhost,password=db_pass" -lco engine=MYISAM shape_file.shp
```

```
ogr2ogr -f "MySQL" MySQL:"5443_Spatial_DB,user=5443,host=localhost,password=5443" -lco engine=MYISAM TM_WORLD_BORDERS-0.3.shp
```

Page with some usefull examples:

(http://www.bostongis.com/PrinterFriendly.aspx?content_name=ogr_cheatsheet)