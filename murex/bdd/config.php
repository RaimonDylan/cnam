<?php
class DB
{
	private static $instance = null;
	///////////// Paramètres de connexions avec DOCKER ///////////////////////////////////
	// Paramètres de connexion à la base de données
	private static $dbhost = "localhost";
	private static $dbuname = "root"; // login
	private static $dbpass = ""; // mot de passe
	private static $dbname = "redstringsclub"; // nom de la base de données
	////////////////////////////////////////////////////////////////////////////
	public static function get()
	{
	if(self::$instance == null)
	{
	   try
	   {
	    self::$instance =  new PDO("mysql:host=".self::$dbhost.";dbname=".self::$dbname.";charset=utf8", self::$dbuname, self::$dbpass); // 
		self::$instance->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);  // report des erreurs.
	   }
	   catch(Exception $e)
	   {
		die('Error : ' . $e->getMessage());
	   }
	}
	return self::$instance;
	}
	public static function disconnect() {
		self::$instance = null;
	}
}
// le code ci-dessous sert à tester la connexion.
/*
$r = DB::get()->query('select * from client;');
while($data = $r->fetch()) {
echo $data['nom_cli'];
}
*/
?>

