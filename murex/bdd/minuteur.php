
<?php
include ('config.php');
$update = DB::get()->prepare("UPDATE launch SET inProgress = 0 WHERE inProgress = 1");
$update->execute();
?>

