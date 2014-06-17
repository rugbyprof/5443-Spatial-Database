<?php
error_reporting(0);
	// Create connection
	$con=mysqli_connect("localhost","spatial","spatial","Spatial_Course");

	// Check connection
	if (mysqli_connect_errno()) {
	  echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	unset($Coords);
		
	if(isset($_POST['Countries'])){
		foreach($_POST['Countries'] as $Cid){
			$result = $con->query("SELECT asText(SHAPE) as border
								   FROM `world_borders` 
								   WHERE CountryID = '{$Cid}'");
								   
			$Result = $result->fetch_assoc();

			$CoordsArray[] = sql_to_coordinates($Result['border']);
		}
		$PrintMap = true;
	}
	if($_GET['debug']){
		echo"<pre>";
		print_r($CoordsArray);
		exit;
	}
?>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple Polygon</title>
    <style>
      #map-canvas {
        height: 600px;
        margin: 0px;
        padding: 0px
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <script>
		// This example creates a simple polygon representing the Bermuda Triangle.

		var i = 0;

		function initialize() {
		  var mapOptions = {
			zoom: 5,
			<?php
				$center = $CoordsArray[0][0];
			?>
			center: new google.maps.LatLng(<?=$center['lat']?>,<?=$center['lng']?>),
			mapTypeId: google.maps.MapTypeId.TERRAIN
		  };
		  
		  var map = new google.maps.Map(document.getElementById('map-canvas'),
			  mapOptions);
		  
		  var PolygonCoords = {};
		  
		  <?php
		  for($i=0;$i<sizeof($CoordsArray);$i++){
		  	
		  	  echo"var Temp = [\n";
			  echo"// Define the LatLng coordinates for the polygon's path.\n";
			  array_shift($CoordsArray[$i]);
			  $line=0;
			  foreach($CoordsArray[$i] as $c){
				 $lat = $c['lat'];
				 $lng = $c['lng'];
				 $lat = str_replace("(","",$lat);
				 $lng = str_replace("(","",$lng);
				 $lat = str_replace(")","",$lat);
				 $lng = str_replace(")","",$lng);
				 echo "new google.maps.LatLng({$lat},{$lng})";
				 if($line < sizeof($CoordsArray[$i])-1){
				 	echo ",\n";
				 }else{
				 	echo "\n";
				 }
				 $line++;
			  }
			  echo"];\n";
			  
			  echo"var PolygonCoords.push(Temp);\n";
			  
			  echo"// Construct the polygon.\n";
			  echo"PolyGon[{$i}] = new google.maps.Polygon({\n";
				 echo"paths: PolygonCoords[{$i}],\n";
				 echo"strokeColor: '#FF0000',\n";
				 echo"strokeOpacity: 0.8,\n";
				 echo"strokeWeight: 2,\n";
				 echo"fillColor: '#FF0000',\n";
				 echo"fillOpacity: 0.35\n";
			  echo"});\n";

			  echo"PolyGon[{$i}].setMap(map);\n";
		  }
		  ?>

		}
		
		<?php
		if($PrintMap){
	    	echo"google.maps.event.addDomListener(window, 'load', initialize);\n";
	    }
	    ?>

    </script>
  </head>
  <body>
	<div>
		<form action="<?=$_SERVER['PHP_SELF']?>" method="POST">
			<?php
			$result = $con->query("SELECT CountryID,name 
								   FROM `world_borders` 
								   ORDER BY name");
			?>
			<select name="Countries[]"  multiple="multiple">				   
			<?php
			while($row = $result->fetch_assoc()){
				echo"\t\t<option value=\"{$row['CountryID']}\">{$row['name']}</option>\n";
			}
			?>
			<input type="submit" name="submit" value="Get Country">
		</form>
	</div>
    <div id="map-canvas"></div>
  </body>
</html>

<?php
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
	
	function random_color_part() {
		return str_pad( dechex( mt_rand( 0, 255 ) ), 2, '0', STR_PAD_LEFT);
	}

	function random_color() {
		return random_color_part() . random_color_part() . random_color_part();
	}
?>