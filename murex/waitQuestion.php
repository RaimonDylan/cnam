
<?php
include ('config.php');
$question = DB::get()->query("SELECT * FROM `launch` natural join question WHERE inProgress = 1");
if($question->fetch()){
	/*
	$idQuestion = $question['question'];
	$libelleQuestion = $question['libelle'];

	$answer = DB::get()->query("SELECT * FROM `answer` WHERE id_question = ".$idQuestion);
	echo '<h3 id="question" class="question" style=color:#fff"> '.$libelleQuestion.'</h3>'
	$i=0;
	$rl = "fadeleft";
	while ($donnees = $answer->fetch())
	{
		$rl=($i%2==0)?"fadeleft":"faderight";
		$style = ($i%2==0)?"float:left;margin-left:10%;margin-top:2%;":"float:right;margin-right:10%;margin-top:2%;";
		$lib = $donnees['libelle'];
		echo '<div class="choice '.$rl.'" style="'.$style.'"> 
		<p>'.$lib.'</p>
	</div>';
	$i++;
	}
	*/
}else{
	echo "false";
}
?>

