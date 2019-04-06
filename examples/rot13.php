<?php 

function  rot13($string)  { 
  for($i=0;$i<strlen($string);$i++)  { 
    $j=ord($string[$i]); 
    if  ((($j>=ord( "n"))  &  ($j<=ord( "z")))  |  ($j>=ord( "N"))  &  ($j<=ord( "Z")))  { 
      $j=$j-13; 
    } 
    elseif  ((($j>=ord( "a"))  &  ($j<=ord( "m")))  |  ($j>=ord( "A"))  &  ($j<=ord( "M")))  { 
      $j=$j+13; 
    } 
    $new.=chr($j); 
  } 
  return($new); 
} 

$phrase = $argv[1]? $argv[1]: "Hello World!";
echo rot13($phrase)."\n";

?>
