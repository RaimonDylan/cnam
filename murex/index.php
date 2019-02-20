<!DOCTYPE html>
<html lang="en">
<head>
    <title>Red Strings Club</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="icon" type="image/png" href="images/logo.png" />
    <link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
    <link href="https://fonts.googleapis.com/css?family=Luckiest+Guy" rel="stylesheet">
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/parallax.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js" integrity="sha384-SlE991lGASHoBfWbelyBPLsUlwY1GwNDJo3jSJO04KZ33K2bwfV9YBauFfnzvynJ" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
    <?php
    try
    {
        $bdd = new PDO('mysql:host=famebattdwadmin.mysql.db;dbname=famebattdwadmin;charset=utf8', 'famebattdwadmin', 'ResidentEvil6');

    }
    catch (Exception $e)
    {
            die('Erreur : ' . $e->getMessage());
    }
    $question = $bdd->query('SELECT * FROM question where id_question = 1');
    $donneesQuestion = $question->fetch();
    $reponse = $bdd->query('SELECT * FROM answer where id_question = 1');
    ?>

    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="index.html"><img class="logo" src="images/logo.png" alt="logo"  width=45 height=45></a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav ">
                    <li class="active accueil"><a style="z-index: 2 !important;" href="index.html">Accueil</a></li>
                    <li class="actualites"><a style="margin-left: 15px;z-index: 2 !important;" >Qui sommes nous ?</a></li>
                </ul>
            </div>
        </div>
    </nav>


    <div style="text-align:center;" class="parallax-window" data-parallax="scroll" data-image-src="images/background2.jpg">
        <div id="btnDownload" class="btn rubberBand animated" style="background-color: #992C61;color: #FFF;padding: 1%;padding-left:70px;
        padding-right: 70px;font-size: 25px;cursor: pointer;margin-top: 450px;">Start</div>
        <h1 id="question" class="question" style='display:none;color:#fff'><?php echo $donneesQuestion['libelle']; ?></h1>
        <?php
        $i=0;
        $rl = "fadeleft";
        while ($donnees = $reponse->fetch())
        {
            $rl=($i%2==0)?"fadeleft":"faderight";
            $style = ($i%2==0)?"display:none;float:left;margin-left:10%;margin-top:2%;":"display:none;float:right;margin-right:10%;margin-top:2%;";
            $lib = $donnees['libelle'];
            echo '<div class="choice '.$rl.'" style="'.$style.'"> 
            <p>'.$lib.'</p>
            </div>';
            $i++;
        }
        

$reponse->closeCursor(); // Termine le traitement de la requête
?>
    </div>


    <div class="footer">
        <div class="pub" style="float:left;cursor:pointer;" ><i style="color:#fff;" class="fab fa-facebook-square fa-2x"></i></div>
        <div class="pub" style="float:left;cursor:pointer;"><i style="color:#fff;" class="fab fa-twitter-square fa-2x"></i></div>
        <div class="pub" style="float:left;cursor:pointer;"><i style="color:#fff;" class="fab fa-twitch fa-2x"></i></div>
        <div class="pub" style="float:left;cursor:pointer;"><i style="color:#fff;" class="fab fa-youtube fa-2x"></i></div>
        <div class="pub" style="float:left;cursor:pointer;"><i style="color:#fff;" class="fab fa-instagram fa-2x"></i></div>
        <div id="nameGame" style="float: left;margin-left: 25%;margin-top: 1%;cursor:pointer;font-size: 25px;"><span style="color:#fff;">Red Strings Club</span></div>

    </div>


    <script type="text/javascript" src="js/monscript.js"></script>
</body>
</html>


