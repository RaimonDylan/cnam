
<?php
include ('config.php');
$adventure = DB::get()->query("SELECT * FROM `launchadventure` WHERE inProgress = 1");
if($data = $adventure->fetch()){
	echo "true";
}else{
	echo "false";
}
?>

