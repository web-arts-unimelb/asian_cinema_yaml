<?php

include_once('lib.php');

if(isset($_GET['film_id']) && !empty($_GET['film_id'])) {
	$film_id = $_GET['film_id'];
	
	// http://stackoverflow.com/questions/12146905/inner-join-with-multiple-tables
	// So use left join
	
	// http://stackoverflow.com/questions/8788344/concatenating-rows-in-relation-to-a-join
	// GROUP_CONCAT example
	
	//http://stackoverflow.com/questions/3083499/mysql-distinct-on-a-group-concat
	// GROUP_CONCAT has distinct
	
	$sql = "
		SELECT
			AacflmFilm.id AS film_id,
			AacflmFilm.title AS film_title,
			GROUP_CONCAT(DISTINCT AacflmDirector.name SEPARATOR ', ') as director_name,
			GROUP_CONCAT(DISTINCT AacflmProductionCompany.name SEPARATOR ', ') as company_name,
			
			AacflmFilm.year,
			Category.name AS category,
			AacflmFilm.country_of_origin,
			AacflmFilm.synopsis_markup,
			
			Tag.phrase
		FROM		
			AacflmFilm
		LEFT JOIN
			Category
		ON
			AacflmFilm.category = Category.slug
		LEFT JOIN
			AacflmDirection
		ON
			AacflmFilm.id = AacflmDirection.film_id
		LEFT JOIN
			AacflmDirector
		ON	 
			AacflmDirection.director_id = AacflmDirector.id
		LEFT JOIN
			AacflmProduction
		ON	
			AacflmFilm.id = AacflmProduction.film_id
		LEFT JOIN
			AacflmProductionCompany
		ON
			AacflmProduction.production_company_id = AacflmProductionCompany.id
		LEFT JOIN
			Tag
		ON
			AacflmFilm.id = Tag.taggable_id						
		WHERE
			AacflmFilm.id = %s AND
			Tag.taggable_type	= 'AacflmFilm'
		GROUP BY
			AacflmFilm.id	
	";
	
	
	$results = DB::query($sql, $film_id);	
	foreach ($results as $row) {
		$film_title = ucwords( strtolower($row['film_title']) );
		$director_name = $row['director_name'];
		$company_name = $row['company_name'];
		
		$year = $row['year'];
		$category = $row['category'];
		$country = $row['country_of_origin'];
		$synopsis_markup = $row['synopsis_markup'];

		$phrase = $row['phrase'];

		$output = $film_title. "<br/>". $director_name. "<br/>". $company_name. "<br/>". $year. "<br/>". $category. "<br/>". $country. "<br/>". $phrase. "<br/><br/>". $synopsis_markup. "<br/>==============<br/>";
		echo $output;
	}
}
else {

}
