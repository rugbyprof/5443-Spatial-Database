<?php
ini_set('memory_limit','2G');
include_once('./geoPHP/geoPHP.inc');

class GraphBuilder{
    var $EdgeFile;
    var $VertexFile;
    var $VertexArray;
    var $VertexCount;
    var $Threshold;
    var $CityArray;
    var $HighWays;
    
    function __construct(){
        $this->EdgeFile = "Edges.geojson";
        $this->VertexFile = "VerticesRaw2.txt";
        $this->Threshold = 100;
        $this->CityArray = array();
        $this->HighWays = array();
        

        $this->BuildVertexFile();

    }


    function CreateRelationships(){        
        echo"Creating Relationships...\n";

        echo"Done...\n";
    }
    
    function RemoveDuplicates(){        
        echo"Removing Dups...\n";

        $file = file("VerticesRaw.txt");
        $temp = array();
        $i=0;
        foreach($file as $f){
            $temp[preg_replace('!\s+!', ' ', trim($f))] = $i++;
        }
        print_r($temp);
        $fp = fopen("VerticesRaw2.txt","w");
        foreach($temp as $key => $line){
            fwrite($fp,$key."\n");
        }
        fclose($fp);
        echo"Done...\n";
    }
    
    function BuildEdgeFile(){
        echo"Building Edge File...\n";
        $EdgeObject = json_decode(file_get_contents($this->EdgeFile));
        
        $Id=0;
        for($i=0;$i<sizeof($EdgeObject->features);$i++){
            $RoadType = ltrim($EdgeObject->features[$i]->properties->FULLNAME);
            if(($RoadType[0] == 'I' || $RoadType[0] == 'U' ) && ($RoadType[1]='-' || $RoadType[1]='S')){
                $geom = geoPHP::load(json_encode($EdgeObject->features[$i]->geometry),'json');

                $this->HighWays[$Id] = array('Id'=>$Id,
                                       'Name'=>str_replace(' ', '',$EdgeObject->features[$i]->properties->FULLNAME),
                                       'Length'=>round($geom->greatCircleLength()*0.000621371,2),        //meters to miles
                                       'NumPoints'=>$geom->numPoints(),
                                       'Geometry'=>$EdgeObject->features[$i]->geometry->coordinates);
                $Id++;
            }
        }
        $fp = fopen("Edges.txt","w");

        foreach($this->HighWays as $edge){
            fwrite($fp,$edge['Id']." ".$edge['Name']." ".$edge['Length']." ".$edge['NumPoints']."\n");
            foreach($edge['Geometry'] as $latlon){
                fwrite($fp,$latlon[0]." ".$latlon[1]."\n");
            }
        }
        fclose($fp);   
        echo"Done...\n";
    }
    
    function BuildVertexFile(){
        echo"Building Vertex File...\n";
        $data = file($this->VertexFile);
        $Id=0;
        $this->CityArray = array();

        for($i=0;$i<sizeof($data);$i++){
            $temp = preg_replace('!\s+!', ' ', trim($data[$i]));
            $temp = explode(" ",$temp);
            $geoid = array_shift($temp);
            $pop = array_pop($temp);
            $lon = array_pop($temp);
            $lat = array_pop($temp);
            $country = array_pop($temp);
            $city = implode("_",$temp);
            if($country == 'US'){
                if(strstr($geoid,"*"))
                    $Print = 1;
                else
                    $Print = 0;

                if(!array_key_exists($city,$this->CityArray)){
                    $this->CityArray[$city] = array('Id'=>$Id,'Population'=>$pop,'Lat'=>$lat,'Lon'=>$lon,'City'=>$city,'Print'=>$Print);
                    $Id++;
                }
            }
        }
        
        print_r($this->CityArray);
        
        usort($this->CityArray,"cmp");        //Put the cities with the largest populations first in the array
        
        $this->CityArray[0]['Print']=1;       //Largest city gets printed
        for($i=1;$i<sizeof($this->CityArray);$i++){
            $Lat = $this->CityArray[$i]['Lat'];
            $Lon = $this->CityArray[$i]['Lon'];
            
            if(!$this->CityArray[$i]['Print'])
                $this->CityArray[$i]['Print'] = $this->FarEnoughAway($Lat,$Lon);
        }

        $fp = fopen("Vertices.txt","w");
        for($i=0;$i<sizeof($this->CityArray);$i++){
            if($this->CityArray[$i]['Print']){
                fwrite($fp,$this->CityArray[$i]['City']." ".
                       $this->CityArray[$i]['Id']." ".
                       $this->CityArray[$i]['Population']." ".
                       $this->CityArray[$i]['Lat']." ".
                       $this->CityArray[$i]['Lon']."\n");
            }
        }
        fclose($fp);
        exec("cp Vertices.txt ../../courses/Public/AdvancedStructures/GraphStarterDrawUsa/Data/");
        echo"Done...\n";
    }
    
    function FarEnoughAway($lat1,$lon1){
        for($i=0;$i<sizeof($this->CityArray);$i++){
            $lat2 = $this->CityArray[$i]['Lat'];
            $lon2 = $this->CityArray[$i]['Lon'];
            if(($lat1==$lat2) && ($lon1==$lon2))
                continue;
            $Distance = greatCircleLength($lat1,$lon1,$lat2,$lon2);

            if($this->CityArray[$i]['Print'] && $Distance < 100 ){
                return 0;
            }
        }
        return 1;
    }
};

function point_to_line_segment_distance($startX,$startY, $endX,$endY, $pointX,$pointY) {


    $r_numerator = ($pointX - $startX) * ($endX - $startX) + ($pointY - $startY) * ($endY - $startY);
    $r_denominator = ($endX - $startX) * ($endX - $startX) + ($endY - $startY) * ($endY - $startY);
    $r = $r_numerator / $r_denominator;

    $px = $startX + $r * ($endX - $startX);
    $py = $startY + $r * ($endY - $startY);

    $s = (($startY-$pointY) * ($endX - $startX) - ($startX - $pointX) * ($endY - $startY) ) / $r_denominator;

    $distanceLine = abs($s) * sqrt($r_denominator);       

    $closest_point_on_segment_X = $px;
    $closest_point_on_segment_Y = $py;

    if ( ($r >= 0) && ($r <= 1) ) {
        $distanceSegment = $distanceLine;
    }else{
        $dist1 = ($pointX - $startX) * ($pointX - $startX) + ($pointY - $startY) * ($pointY - $startY);
        $dist2 = ($pointX - $endX) * ($pointX - $endX) + ($pointY - $endY) * ($pointY - $endY);
        if ($dist1 < $dist2) {
            $closest_point_on_segment_X = $startX;
            $closest_point_on_segment_Y = $startY;
            $distanceSegment = sqrt($dist1);
        } else {
            $closest_point_on_segment_X = $endX;
            $closest_point_on_segment_Y = $endY;
            $distanceSegment = sqrt($dist2);
        }
    }   


}

function greatCircleLength($lat1,$lon1,$lat2,$lon2,$radius = 6378137) {
    $length = 0;

      $lat1 = deg2rad($lat1);
      $lat2 = deg2rad($lat2);
      $lon1 = deg2rad($lon1);
      $lon2 = deg2rad($lon2);
      $dlon = $lon2 - $lon1;
      $length +=
        $radius *
          atan2(
            sqrt(
              pow(cos($lat2) * sin($dlon), 2) +
                pow(cos($lat1) * sin($lat2) - sin($lat1) * cos($lat2) * cos($dlon), 2)
            )
            ,
            sin($lat1) * sin($lat2) +
              cos($lat1) * cos($lat2) * cos($dlon)
          );
    return round($length * 0.000621371,2);
}

function cmp($a,$b){
    if($a['Population'] == $b['Population']){
        return 0;
    }
    return ($a['Population'] > $b['Population']) ? -1 : 1;
}

$G = new GraphBuilder();