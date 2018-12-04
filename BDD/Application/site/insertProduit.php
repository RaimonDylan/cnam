<?php
session_start() ;
error_reporting(E_ALL);

include ('config.php');
$req = DB::get()->prepare("insert into PRODUIT (libelle_prd, prixHT_prd, nbStock_prd, num_type) values (:description, :prix, :stock,:type)");



// Utilisation d'un try... catch pour captuer et gérer proprement les erreurs potentielles.
try {
	$req->execute(array(
		'description' => $_POST['description'],
		'prix' => $_POST['prix'],
		'stock' => $_POST['stock'],
		'type' => $_POST['type']
		));
		// redirection
		header('location: ./admin.php');
} catch(PDOException $erreur) {
echo "Erreur ".$erreur->getMessage();
}

?>
</html>

