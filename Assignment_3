### Assignment 3

### My OGR command

```
ogr2ogr whatever your command is
```

My Table Structure

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
