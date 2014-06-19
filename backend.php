<?php
//Establish connection to database.
$db = new mysqli('localhost', '5443', '5443', '5443_Military');

//If no connection, then kill page
if($db->connect_errno > 0){
    die('Unable to connect to database [' . $db->connect_error . ']');
}

if(isset($argv[1]) && $argv[1]=='debug'){
	$_POST['lat'] = 33.546;
	$_POST['lng'] = -122.546;
	$debug = true;
}

$sql = "
	SELECT 
		OGR_FID,
		fullname, 
		latitude, 
		longitude,
		NumGeometries(SHAPE) AS Multi,
		AsText(SHAPE) as Poly, 
		69*haversine(latitude,longitude,latpoint, longpoint) AS distance_in_miles
	FROM military_installations
	JOIN (
	    SELECT  {$_POST['lat']}  AS latpoint,  {$_POST['lng']} AS longpoint
	) AS p
	ORDER BY distance_in_miles
	LIMIT 10
";
  
$result = $db->query($sql);

$Data = array();

while($row = $result->fetch_assoc()){
	if($debug){
		print_r($row);
	}
	if($row['Multi']){
		$row['Poly'] = array();
		for($i=1;$i<=$row['Multi'];$i++){
		    $sql = "SELECT AsText(GeometryN(SHAPE,{$i})) as P
				    FROM military_installations 
				    WHERE OGR_FID = '{$row['OGR_FID']}'";
			$result2 = $db->query($sql);
			$row2 = $result2->fetch_assoc();
			$row['Poly'][] = sql_to_coordinates($row2['P']);
		}
	}else{
		$row['Multi'] = 1;
		$row['Poly'] = sql_to_coordinates($row['Poly']);
	}
	$row['Color'] = "#".random_color();
	$Data[] = $row;
}

echo json_encode($Data);

function sql_to_coordinates($blob)
{
	$blob = str_replace("))", "", str_replace("POLYGON((", "", $blob));
	$coords = explode(",", $blob);
	$coordinates = array();
	foreach($coords as $coord)
	{
		$coord_split = explode(" ", $coord);
		$coordinates[]=array($coord_split[0],$coord_split[1]);
	}
	return $coordinates;
}

function random_color_part() {
    return str_pad( dechex( mt_rand( 0, 255 ) ), 2, '0', STR_PAD_LEFT);
}

function random_color() {
    return random_color_part() . random_color_part() . random_color_part();
}


