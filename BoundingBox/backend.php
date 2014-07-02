<?php
error_reporting(0);
// lat:lat,
// lng:lng ,
// earthQuakes: echecked ,
// volcanoes:vchecked

//Establish connection to database.
$Conn = new PDO("pgsql:host=localhost;dbname=5443","5443","5443");

if(isset($argv[1]) && $argv[1]=='debug' || $_GET['debug']){
	$_POST['lat'] = 33.546;
	$_POST['lng'] = -122.546;
	$_POST['earthQuakes'] = true;
	$debug = true;
}

if($_POST['earthQuakes']){
	$Poly = GetStatePolyContainsPoint($db,$_POST['lat'],$_POST['lng']);
	$data['Poly'] = sql_to_coordinates($Poly);
	$data['EarthQuakes'] = GetEarthQuakesWithinGeometry($db,$Poly)
	echo json_encode($data);
	exit;
}
if($_POST['volcanoes']){

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
	LIMIT 5
";

$result = $Conn->query($sql);

$Data = array();

while($row = $result->fetch(PDO::FETCH_ASSOC)){
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

function GetEarthQuakesWithinGeometry($db,$Geometry){
	$sql = "
		SELECT AsText(SHAPE) as Point,
		FROM `earth_quakes`
		WHERE WITHIN(Point,GeomFromText({$Geometry}))
	";

	$result = $Conn->query($sql);

	$Data = array();

	while($row = $result->fetch(PDO::FETCH_ASSOC)){
		$Data[] = $row['Poly'];
	}

	return $Data;
}

function GetCountryContainsPoint($db,$Lat,$Lon){
	$sql = "
		SELECT asText(SHAPE)
		FROM world_borders A
		WHERE CONTAINS(A.SHAPE,GeomFromText('POINT({$Lon} {$Lat})'))
	";

	$result = $Conn->query($sql);

	$row = $result->fetch(PDO::FETCH_ASSOC);

	return $row['SHAPE'];

}

function GetStatePolyContainsPoint($db,$Lat,$Lon){
	$sql = "
		SELECT state,asText(SHAPE) as SHAPE
		FROM state_borders A
		WHERE CONTAINS(A.SHAPE,GeomFromText('POINT({$Lon} {$Lat})'))
	";

	$result = $db->query($sql);

	$row = $result->fetch(PDO::FETCH_ASSOC);

	return $row['SHAPE'];

}

function sql_to_coordinates($blob)
{
	$blob = str_replace("))", "", str_replace("POLYGON((", "", $blob));
	$coords = explode(",", $blob);
	$coordinates = array();
	foreach($coords as $coord)
	{
		$coord_split = explode(" ", $coord);
		$coordinates[]=array(str_replace("\n","",$coord_split[0]),str_replace("\n","",$coord_split[1]));
	}
	return $coordinates;
}

function random_color_part() {
    return str_pad( dechex( mt_rand( 0, 255 ) ), 2, '0', STR_PAD_LEFT);
}

function random_color() {
    return random_color_part() . random_color_part() . random_color_part();
}

function getFeatures(){
    $sql = "SELECT * FROM pg_catalog.pg_tables WHERE schemaname = 'public'";
    $result = $db->query($sql);
    $TableArray = array();
    while($row = $result->fetch(PDO::FETCH_ASSOC)){
        $TableArray[] = $row['tablename'];
    }
    echo json_encode($TableArray);
}
