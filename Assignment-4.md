### Open Street Maps

[Planet OSM](http://wiki.openstreetmap.org/wiki/Planet.osm) is a web site wiki that contains links to Open Street Maps
map data for the entire planet! You can have it all for a mere ~350GB download :flushed:

Since we don't want the entire planet, lets work with something smaller. We can do that 
at http://download.geofabrik.de/
- [USA](http://download.geofabrik.de/north-america-latest.osm.bz2) 
- [Asia](http://download.geofabrik.de/asia-latest.osm.bz2)
- [Texas](http://download.geofabrik.de/north-america/us/texas-latest.osm.bz2)

```bash
curl —location —globoff http://download.geofabrik.de/north-america/us/texas-latest.osm.bz2 -o texas.osm.bz2
```
```bash
bunzip2 texas.osm.bz2 
```

```bash
/usr/local/bin/osmosis --read-xml texas.osm --tf reject-relations --tf reject-ways --tf accept-nodes amenity=restaurant --write-xml restaurants.osm
```
