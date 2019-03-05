<?php
include ('config.php');
$idLaunch = $_POST['idLaunch'];
$numChoice = $_POST['numChoice'];
$idLaunchOld = $_POST['idLaunchOld'];
$numChoiceOld = $_POST['numChoiceOld'];
/*
if(!empty($idLaunchOld) && !empty($numChoiceOld)){
    $dataExist = DB::get()->query("SELECT * FROM `event`WHERE id_launch = $idLaunchOld AND num_choice = $numChoiceOld");
    $data = $dataExist->fetch();
    $nbVote = $data['nb_vote'] - 1;
    $id = $data['id_event'];
    $update = DB::get()->prepare("UPDATE event SET nb_vote = $nbVote WHERE id_event = $id");
    $update->execute();
}
*/

$dataExist = DB::get()->query("SELECT * FROM `event`WHERE id_launch = $idLaunch AND num_choice = $numChoice");
if($data = $dataExist->fetch()){
    $nbVote = $data['nb_vote'] + 1;
    $id = $data['id_event'];
    $update = DB::get()->prepare("UPDATE event SET nb_vote = $nbVote WHERE id_event = $id");
    $update->execute();
}else{
    $insert = DB::get()->prepare("INSERT INTO event SET id_launch = $idLaunch, num_choice = $numChoice,nb_vote = 1");
    $insert->execute();
}
$dataVotes = DB::get()->query("SELECT * FROM `event`WHERE id_launch = $idLaunch");
while ($donnees = $dataVotes->fetch())
{
    $tabVote[$donnees['num_choice']] = $donnees['nb_vote'];
}
echo json_encode($tabVote);