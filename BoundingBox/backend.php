<?php
/**
 * Title:   GeoJson (Requires https://github.com/phayes/geoPHP)
 * Notes:   Query a MySQL table or view and return the results in GeoJSON format, suitable for use in OpenLayers, Leaflet, etc.
 * Author:  Bryan R. McBride, GISP
 * Contact: bryanmcbride.com
 * GitHub:  https://github.com/bmcbride/PHP-Database-GeoJSON
 * Edited:  By Terry Griffin, organized as a CLASS for insructional purposes.
 */

exit;

# Include required geoPHP library and define wkb_to_json function
include_once('geoPHP/geoPHP.inc');

class MyGeoJson{
    var $conn;          // connection handle for mysql pdo class
    var $DbHost;        // e.g. localhost
    var $DbName;        // Database name
    var $DbPass;        // Database password
    var $DbUser;        // Database user
    var $GeoJsonArray;  // Result array of GeoJson data
    var $Result;        // Sql Result Handle
    var $Sql;           // Sql query

    public function __construct($db_name,$db_user,$db_pass,$db_host){
        $this->Sql = null;
        $this->Result = null;
        
        
        $this->DbName = $db_name;
        $this->DbPass = $db_pass;
        $this->DbUser = $db_user;
        $this->DbHost = $db_host;
        $this->Conn = new PDO("mysql:host={$this->DbHost};dbname={$this->DbName}",$this->DbUser,$this->DbPass);
    }
    
    public function RunQuery($sql){
        
        $Data = array();
        $i = 0;
        $this->Sql = $sql;
        
        # Try query or error
        $this->Result = $this->Conn->query($this->Sql);

        if (!$this->Result) {
            echo 'An SQL error occured.\n';
            print_r($this->Sql);
            exit;
        }
        
        # Loop through rows to build feature arrays
        while ($row = $this->Result->fetch(PDO::FETCH_ASSOC)) {
            $temp = json_decode($this->WkbToJson($row['wkb']));
            $Data[$i]['Type'] = $temp->type;
            $Data[$i]['Coordinates'] = $temp->coordinates;
            unset($row['wkb']);
            unset($row['SHAPE']);          
            $Data[$i]['properties'] = $row;
            $i++;
        }
        
        $this->Conn = NULL; 
        return $Data;
    }
    
    # Build SQL SELECT statement and return the geometry as a WKB element
    private function WkbToJson($wkb) {
        $geom = geoPHP::load($wkb,'wkb');
        return $geom->out('json');
    }
    
}
/////////////////////////////////////////////////////////////////////////////////////
//Main

$MyGeo = new MyGeoJson('5443_SpatialData','5443','5443','localhost');

if(isset($argv[1]) && $argv[1]=='debug' || isset($_GET['debug']) && $_GET['debug']){
    $_POST['lat'] = 33.546;
    $_POST['lng'] = -122.546;
}

//This gives us a set of polygons, and multipolygons, representing every military base.
$Query1 = "SELECT * FROM military_installations";
$Data1 = $MyGeo->RunQuery($Query1);

//This gives us a set of points, representing every airport.
$Query2 = "SELECT * FROM airports";
$Data2 = $MyGeo->RunQuery($Query2);

//Not the most efficient, but loop through each airport, and find the closest military installation
//using our own distance function. 

print_r($Query2);
        


header('Content-type: application/json');
echo json_encode($Data, JSON_NUMERIC_CHECK); 