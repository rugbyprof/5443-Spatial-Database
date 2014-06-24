<?php 

$dir = scandir('.');

//remove . and ..
array_shift($dir);
array_shift($dir);

foreach($dir as $file){
    if($file == 'index.php')
        continue;
    
    print $file;
}