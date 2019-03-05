
<?php
include ('config.php');
$question = DB::get()->query("SELECT * FROM `launch` natural join question WHERE inProgress = 1");
if($data = $question->fetch()){
	$idQuestion = $data['id_question'];
	$idLaunch = $data['id_launch'];
	$libelleQuestion = $data['libelle'];
	$answer = DB::get()->query("SELECT * FROM `answer` WHERE id_question = ".$idQuestion);

	echo '<h3 id="question" class="question" data-id="'.$idLaunch.'" style="color:#fff"> '.$libelleQuestion.'</h3><div style="overflow: auto;">';
	$i=0;
	$rl = "fadeleft";
	while ($donnees = $answer->fetch())
	{
		$style = ($i%2==0)?"float:left;margin-left:10%;margin-top:2%;":"float:right;margin-right:10%;margin-top:2%;";
		$lib = $donnees['libelle'];
		$numChoice = $donnees['num_choice'];
		echo '<div class="choice bounce animated" data-num="'.$numChoice.'" style="'.$style.'"> 
		<span style="display:block;">'.$lib.'</span>
		<span class="nbVote"</span>
	</div>';
	$i++;
	}
	echo '</div>';
}else{
	echo "false";
}
?>

