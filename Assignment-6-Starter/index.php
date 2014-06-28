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
	</div>
  </section>
  </body>
</html>

