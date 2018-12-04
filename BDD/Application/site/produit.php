<?php
// initialisation de la session
// INDISPENSABLE À CETTE POSITION SI UTILISATION DES VARIABLES DE SESSION.
session_start() ;
error_reporting(E_ALL);
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" >
   <head>
       <title>Produit</title>
       <meta http-equiv="Content-Type" content="text/html; charset=utf8" />
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
   </head>

<body>

<?php
include ('config.php');
// On appelle la méthode statique get() de la classe DB qui renvoit une instance du PDO.

$requestClient = DB::get()->query('select * from client');
$request = DB::get()->query('select num_prd,libelle_prd,prixht_prd,nbstock_prd,libelle_type, (select * from getNoteProduit(num_prd)) as note from produit natural join type');
$requestPanier = DB::get()->query('select ENREGISTRER.num_prd,libelle_prd, nbproduit_pan FROM ENREGISTRER NATURAL JOIN CLIENT NATURAL JOIN PRODUIT WHERE CLIENT.num_cli=1');
?>
<h1 style="text-align: center;">Vous êtes connecté en temps que</h1>
	<table id="client" class="table">
		<thead class="thead-dark">
			<tr>
				<th>Nom</th>
				<th>Prénom</th>
				<th>Email</th>
				<th>Sexe</th>
				<th>Date de naissance</th>
				<th>Date de dernière connexion</th>
				<th>Date d'inscription</th>
			</tr>
		</thead>
	<tbody>
<?php
// On récupère les données. Chaque ligne est sockée dans le tableau data.

$data = $requestClient->fetch()
	?>
	<tr>
		<td style="display:none;" class="num_cli"><?php echo	$data['num_cli']; ?></td>
		<td><?php echo	$data['nom_cli']; ?></td>
		<td><?php echo	$data['prenom_cli']; ?></td>
		<td><?php echo	$data['email_cli']; ?></td>
		<td><?php echo	$data['sexe_cli']; ?></td>
		<td><?php echo	$data['ddn_cli']; ?></td>
		<td><?php echo	$data['dtlastconnexion_cli']; ?></td>
		<td><?php echo	$data['dtinscription_cli']; ?></td>
	</tr>
	<?php
$requestClient->closeCursor(); // ne pas oublier de fermer le curseur.
?>
</tbody>


</table>
<h1 style="text-align: center;">Liste des produits</h1>
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th>Description</th>
				<th>Prix</th>
				<th>Type</th>
				<th>Note</th>
				<th>Action</th>
			</tr>
		</thead>
	<tbody>

<?php
// On récupère les données. Chaque ligne est sockée dans le tableau data.

while($data = $request->fetch()) {
	if($data['nbstock_prd'] > 0){
		?>
		<tr>
			<td style="display:none;" class="num_prd"><?php echo	$data['num_prd']; ?></td>
			<td class="libelle_prd"><?php echo	$data['libelle_prd']; ?></td>
			<td><?php echo	$data['prixht_prd']; ?></td>
			<td><?php echo	$data['libelle_type']; ?></td>
			<td><?php echo	$data['note']; ?></td>
			<td><input class="addpanier btn btn-primary btn-sm" type="submit" value="Ajouter au panier"/></td>
		</tr>
		<?php
	}
}
$request->closeCursor(); // ne pas oublier de fermer le curseur.
?>


</tbody>
</table>
<h1 style="text-align: center;">Panier</h1>
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th>Produit</th>
				<th>Quantite</th>
				<th>Action</th>
			</tr>
		</thead>
	<tbody id ="table_panier">
<?php
// On récupère les données. Chaque ligne est sockée dans le tableau data.

while($data = $requestPanier->fetch()) {
	?>
	<tr>
		<td><?php echo	$data['libelle_prd']; ?></td>
		<td id="pan_<?php echo	$data['num_prd']; ?>"><?php echo	$data['nbproduit_pan']; ?></td>
		<td><input data-id="<?php echo	$data['num_prd']; ?>" class="removepanier btn btn-primary btn-sm" type="submit" value="Retirer du panier"/></td>
	</tr>
	<?php
}
$requestPanier->closeCursor(); // ne pas oublier de fermer le curseur.
?>
</tbody>
</table>
<input class="validpanier" type="submit" value="Valider la commande"/>
<script type="text/javascript">
$(document).ready(function(){
	$(document).on("click",".addpanier",function(){
		var idClient = $("#client").find(".num_cli").text();
		var idPrd = $(this).parent().parent().find(".num_prd").text();
		var libelle = $(this).parent().parent().find(".libelle_prd").text();
		$.ajax({
        url:"testJquery.php",
        type:"POST",

        data:{
          idClient: idClient,
          idPrd: idPrd
        },
        success:function(response) {
          if(response != 1){
          	$("#pan_"+idPrd).text(response);
          }else{
          	var html = "<tr>";
			html += "<td>"+libelle+"</td>";
			html += "<td id='pan_"+idPrd+"'>"+response+"</td>";
			html += "<td><input data-id='"+idPrd+"' class='removepanier btn btn-primary btn-sm' type='submit' value='Retirer du panier'/></td>";
			html += "</tr>";
			$("#table_panier").append(html);
          }
       },
       error:function(){
        alert("error");
       }

      });
	});
	$(document).on("click",".removepanier",function(){
		var idClient = $("#client").find(".num_cli").text();
		var idPrd = $(this).data("id");
		var obj = $(this);
		$.ajax({
        url:"removePanier.php",
        type:"POST",

        data:{
          idClient: idClient,
          idPrd: idPrd
        },
        success:function(response) {
          if(response != 0){
          	$("#pan_"+idPrd).text(response);
          }else{
          	obj.parent().parent().remove();
          }
       },
       error:function(){
        alert("error");
       }

      });
		
	});
	$(document).on("click",".validpanier",function(){
		var idClient = $("#client").find(".num_cli").text();
		$.ajax({
        url:"validePanier.php",
        type:"POST",

        data:{
          idClient: idClient
        },
        success:function(response) {
          $("#table_panier").children().remove();
          alert("commande validé !")
       },
       error:function(){
        alert("error");
       }

      });
		
	});
	});
</script>
</body>

</html>
