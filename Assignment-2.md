##Assignment 2 - Simple OGR Command

#### Due: Friday Jun 13th by 12:20
<br><br>

### My OGR command

Use your friend google to find an `ogr2ogr` command that will load the geometry data from a `shape`
file into a Mysql database.

Create a document called: `Assignment-2.md` in your github repository that contains the following:

Your `OGR` command:

```txt
ogr2ogr whatever your command is
```

A dump of your table structure:

```sql
CREATE TABLE IF NOT EXISTS `cities` (
  `OGR_FID` int(11) NOT NULL AUTO_INCREMENT,
  `SHAPE` geometry NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `country` varchar(12) DEFAULT NULL,
  `population` double DEFAULT NULL,
  `capital` varchar(1) DEFAULT NULL,
  UNIQUE KEY `OGR_FID` (`OGR_FID`),
  SPATIAL KEY `SHAPE` (`SHAPE`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=607 ;
```
