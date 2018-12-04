
<?php
include ('config.php');
$req = DB::get()->prepare("insert into ENREGISTRER(num_cli, num_prd, nbProduit_pan) values (:client, :produit, :nbprd)");



$idClient= $_POST['idClient'];
$idPrd= $_POST['idPrd'];

$requestPanier = DB::get()->query("SELECT * FROM ENREGISTRER WHERE num_cli=".$idClient." AND num_prd = ".$idPrd);
$nbPrd = 1;
while($data = $requestPanier->fetch()) {
		$nbPrd = $data['nbproduit_pan'] +1;
}
if($nbPrd == 1){
	try {
	$req->execute(array(
		'client' => $idClient,
		'produit' => $idPrd,
		'nbprd' => $nbPrd
		));
	} catch(PDOException $erreur) {
		echo "Erreur ".$erreur->getMessage();
	}
}else{
	$reqUpdate = DB::get()->prepare("update ENREGISTRER SET nbproduit_pan = :nbprd WHERE num_cli = :client AND num_prd = :produit");
	try {
	$reqUpdate->execute(array(
		'client' => $idClient,
		'produit' => $idPrd,
		'nbprd' => $nbPrd
		));
	} catch(PDOException $erreur) {
		echo "Erreur ".$erreur->getMessage();
	}
}
echo $nbPrd;
?>

