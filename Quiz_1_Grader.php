<?php

$dir = scandir("./Quiz1");

foreach($dir as $file){

    $lines = file("./Quiz1/".$file);

    foreach($lines as $line){
        if(stripos(strtolower($line),"select") !== false){
            echo "$line\n";
        }
    }
}