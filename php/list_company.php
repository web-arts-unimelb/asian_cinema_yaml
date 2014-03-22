<?php

include_once('lib.php');

if(isset($_GET['company_id']) && !empty($_GET['company_id'])) {
	$company_id = $_GET['company_id'];
	
	$sql = "
		SELECT 
			AacflmProductionCompany.name,
			AacflmFilm.title
		FROM 
			AacflmProductionCompany
		INNER JOIN 
			AacflmProduction
		ON 
			AacflmProductionCompany.id = AacflmProduction.production_company_id
		INNER JOIN
			AacflmFilm
		ON
			AacflmProduction.film_id = AacflmFilm.id
		WHERE
			AacflmProductionCompany.id = %s
	";
	
	$results = DB::query($sql, $company_id);
	
	foreach ($results as $row) {
		$company_name = $row['name'];
		$film_title = $row['title'];
		echo "<b>Company name:</b> ". $company_name. " | <b>Film:</b> ". $film_title. "<br/><br/>";
	}
}
else {

}
