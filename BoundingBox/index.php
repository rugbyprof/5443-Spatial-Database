<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple Polygon</title>
    <style>
		section {
			width: 90%;
			height: 600px;
			background: #C0C0C0;
			margin: auto;
			padding: 5px;
		}
		div#map-canvas {
			width: 80%;
			height: 600px;
			float: left;
		}
		div#form-stuff {
			margin-left: 15%;
			padding: 20px;
			height: 600px;

		}
    </style>
    <!-- Include Google Maps Api to generate maps -->
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <!-- Include Jquery to help with simplifying javascript syntax  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="./geo.js"></script>
    <script>

        //Add a listener that runs "initialize" when page is done loading.
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  </head>
  <body>
  <section>
    <div id="map-canvas"></div>
	<div id="form-stuff">
		Query Number: <input type="text" name="QueryNum" id="QueryNum" value="1"><br>
        UpperLeft:<br>
        &nbsp;&nbsp;&nbsp;Lat: <span id="lat1"></span><br>
        &nbsp;&nbsp;&nbsp;Lon: <span id="lon1"></span><br>
        LowerRight:<br>
        &nbsp;&nbsp;&nbsp;Lat: <span id="lat2"></span><br>
        &nbsp;&nbsp;&nbsp;Lon: <span id="lon2"></span><br>
        Data Sources:<br>
        <?php
            $Conn = new PDO("pgsql:host=localhost;dbname=5443","5443","5443");
            $sql = "SELECT * FROM pg_catalog.pg_tables WHERE schemaname = 'public'";
            $result = $db->query($sql);
            $TableArray = array();
            while($row = $result->fetch(PDO::FETCH_ASSOC)){
                echo"&nbsp;&nbsp;&nbsp;<input type=\"checkbox\" name=\"sources[]\" id=\"$row['tablename']\" checked><br>";
            }

        ?>
	</div>
  </section>
  </body>
</html>
