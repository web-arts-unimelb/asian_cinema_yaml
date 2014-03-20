<?php
include_once('lib.php');

$results = DB::query("SELECT * FROM AacflmDirector");
foreach ($results as $row) {
	$director_id = $row['id'];
	$link_part = '<a href="list_director.php?director_id='. $director_id. '">'. $row['name']. '</a>';
  echo "<b>Name</b>: ". $link_part. "<br/><br/>";
}
