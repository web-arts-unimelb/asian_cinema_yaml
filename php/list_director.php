<?php

include_once('lib.php');

if(isset($_GET['director_id']) && !empty($_GET['director_id'])) {
	$director_id = $_GET['director_id'];
	
	$sql = "
		SELECT 
			AacflmDirector.name,
			AacflmFilm.title
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
		WHERE
			AacflmDirector.id = %s
	";
	
	$results = DB::query($sql, $director_id);
	
	foreach ($results as $row) {
		$director_name = $row['name'];
		$film_title = $row['title'];
		echo "<b>Director name:</b> ". $director_name. " | <b>Film:</b> ". $film_title. "<br/><br/>";
	}
}
else {

}
