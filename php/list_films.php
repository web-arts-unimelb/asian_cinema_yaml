<?php
include_once('lib.php');

$sql = "
	SELECT
		AacflmFilm.id,
		Category.name as category,
		AacflmFilm.year,
		AacflmFilm.title AS film_title,
	 
		AacflmDirector.name AS director_name
	FROM 
		AacflmDirector
	INNER JOIN 
		AacflmDirection
	ON 
		AacflmDirector.id = AacflmDirection.director_id
	INNER JOIN
		AacflmFilm
	ON
		AacflmDirection.film_id = AacflmFilm.id
	INNER JOIN
		Category
	ON
		AacflmFilm.category = Category.slug
	ORDER BY
		AacflmFilm.title	
";

$results = DB::query($sql);

foreach ($results as $row) {
	$film_id = $row['id'];
	$category_slug = $row['category'];
	$year = $row['year'];
	$film_title = ucwords( strtolower($row['film_title']) );
	
	$director_name = $row['director_name'];
	
	$part_year = '<strong>Year: </strong> '. $year. "<br/>";
	$part_category = '<strong>Category: </strong> '. $category_slug. "<br/>";
	$part_film_name = '<strong>Film name: </strong><a href="list_film.php?film_id='. $film_id. '">'. $film_title. '</a><br/>';
	$part_director_name = '<strong>Director name: </strong> '. $director_name. "<br/>";
	
	$output = $part_year. $part_category. $part_film_name. $part_director_name. "<br/>============<br/>";
	echo $output;
}
