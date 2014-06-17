<?php

$args = arguments($argv);

print_r($args);

if(!array_key_exists('dbname',$args)){
    echo "ERROR: dbname needed (e.g. --db mydb)\n";
    exit;
}
if(!array_key_exists('username',$args)){
    echo "ERROR: username needed (e.g. --user yourusername)\n";
    exit;
}
if(!array_key_exists('password',$args)){
    echo "ERROR: password needed (e.g. --pass mydb)\n";
    exit;
}
if(!array_key_exists('host',$args)){
    echo "WARNING: host not set (e.g. --host localhost). Assuming 'localhost'\n$
    $args['host'] = 'localhost';
}

exit;

$DBNAME = $args['db'];
$HOST = $args['host'];
$USER = $args['user'];
$PASSWORD = $args['pass'];


$files = scandir('.');

$filtered = array();

foreach($files as $file){
    if(strstr($file,'.')){
        list($dir,$basename,$ext,$filename) = array_values(pathinfo($file));

        if($ext == 'shp')
            $filtered[] = array($basename,$filename);
    }
}

//print_r($filtered);

foreach($filtered as $entry){
    list($file_name,$table_name) = $entry;
    $cmd = "ogr2ogr -f MySQL MySQL:{$DBNAME},host={$HOST},user={$USER},password$
    echo"Executing: $cmd\n\n";
    exec($cmd);
}

function arguments ( $args )
{
    array_shift( $args );
    $args = join( $args, ' ' );

    preg_match_all('/ (--\w+ (?:[= ] [^-]+ [^\s-] )? ) | (-\w+) | (\w+) /x', $args, $match );
    $args = array_shift( $match );

    /*
        Array
        (
            [0] => asdf
            [1] => asdf
            [2] => --help
            [3] => --dest=/var/
            [4] => -asd
            [5] => -h
            [6] => --option mew arf moo
            [7] => -z
        )
    */

    $ret = array(
        'input'    => array(),
        'commands' => array(),
        'flags'    => array()
    );

    foreach ( $args as $arg ) {

        // Is it a command? (prefixed with --)
        if ( substr( $arg, 0, 2 ) === '--' ) {

            $value = preg_split( '/[= ]/', $arg, 2 );
            $com   = substr( array_shift($value), 2 );
            $value = join($value);

            $ret['commands'][$com] = !empty($value) ? $value : true;
            continue;

        }

        // Is it a flag? (prefixed with -)
        if ( substr( $arg, 0, 1 ) === '-' ) {
            $ret['flags'][] = substr( $arg, 1 );
            continue;
        }

        $ret['input'][] = $arg;
        continue;

    }

    return $ret;
}


