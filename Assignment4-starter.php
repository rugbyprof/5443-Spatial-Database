<?
//Establish connection to database.
$db = new mysqli('localhost', '5443', '5443', '5443_Military');

//If no connection, then kill page
if($db->connect_errno > 0){
    die('Unable to connect to database [' . $db->connect_error . ']');
}

//If form was posted, it will populate the $_POST array
//so we will run our query.Otherwise, skip it.
if(sizeof($_POST)>0){
	$sql = "
	SELECT fullname, latitude, longitude,
		   69*haversine(latitude,longitude,latpoint, longpoint) AS distance_in_miles
	 FROM installations2
	 JOIN (
		 SELECT  {$_POST['lat']}  AS latpoint,  {$_POST['lng']} AS longpoint
	   ) AS p
	 ORDER BY distance_in_miles
	 LIMIT 10";
	  
	 $result = $db->query($sql);
}
?>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple Polygon</title>
    <style>
      html, body, #map-canvas {
        height: 600px;
		width: 800px;
        margin: 0px;
        padding: 0px
      }
    </style>
    <!-- Include Google Maps Api to generate maps -->
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    
    <!-- Include Jquery to help with simplifying javascript syntax  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>

	//Runs when page is done loading
	function initialize() {
	  //Javascript object to help configure google map.
	  var mapOptions = {
		zoom: 5,
		center: new google.maps.LatLng(24.886436490787712, -70.2685546875),
		mapTypeId: google.maps.MapTypeId.TERRAIN
	  };

	  //Create google map, place it in 'map-canvas' element, and use 'mapOptions' to 
	  //help configure it
	  var map = new google.maps.Map(document.getElementById('map-canvas'),
		  mapOptions);


		<?php
		//If we posted a lat lon, then loop through the resulting query rows and create 
		//a google marker for each location.
		if(sizeof($_POST)>0){
			$i=0;
			while($row = $result->fetch_assoc()){
				//[0] => Picatinny Arsenal [fullname] => Picatinny Arsenal [1] => 40.9534721 [latitude] => 40.9534721 [2] => -74.5444565 [longitude] => -74.5444565 [3] => 30.78561294078827 [distance_in_miles] => 30.78561294078827 ) 
				echo"var marker{$i} = new google.maps.Marker({\n";
				echo"position: new google.maps.LatLng({$row['latitude']},{$row['longitude']}),\n";
				echo"map: map,\n";
				echo"title:\"{$row['fullname']}\"\n";
				echo"});\n";
				$i++;
			}
		}
		?>
  	  //Add the "click" event listener to the map, so we can capture
  	  //lat lon from a google map click.
	  google.maps.event.addListener(map, "click", function(event) {
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		// populate yor box/field with lat, lng
		//console.write("Lat=" + lat + "; Lng=" + lng);
		$('#lat').val(lat);		//write lat to appropriate form field
		$('#lng').val(lng);		//same with lng
	  });
  
	}

	//Add a listener that runs "initialize" when page is done loading.
	google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
	<div id="FormDiv">
	<form action="<?=$_SERVER['PHP_SELF']?>" method="POST">
	Lat:<input type="text" name="lat" id="lat"><br>
	Lng:<input type="text" name="lng" id="lng"><br>
	<input type="submit" name="submit" value="Get Poi's">
	</div>
    <div id="map-canvas"></div>
  </body>
</html>