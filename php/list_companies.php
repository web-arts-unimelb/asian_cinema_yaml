<?php
include_once('lib.php');

$results = DB::query("SELECT * FROM AacflmProductionCompany");
foreach ($results as $row) {
	$company_id = $row['id'];
	$link_part = '<a href="list_company.php?company_id='. $company_id. '">'. $row['name']. '</a>';
  echo "<b>Name</b>: ". $link_part. "<br/><br/>";
}
