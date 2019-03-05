<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Red Strings Club</title>
    <link rel="icon" type="image/png" href="img/logo.png" />
    <link rel="shortcut icon" type="image/x-icon" href="img/logo.ico" />

    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <link href="css/grayscale.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <link rel="stylesheet" href="css/animate.css">
</head>

<body id="page-top">
<?php

include ('bdd/config.php');

?>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top">Red Strings Club</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="index.php">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="aventure.php">Aventure</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="contact.php">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Header -->
<header class="masthead">
    <div class="container d-flex h-100 align-items-center">
        <div class="mx-auto text-center">
            <h1 class="mx-auto my-0 text-uppercase projectname">Red Strings Club</h1>
            <h2 class="text-white-50 mx-auto mt-2 mb-5 projectdesc">Projet fait par des étudiants du CNAM</h2>
            <div class="arc">
            </div>
            <h2 class="text-white-50 mx-auto mt-2 mb-5 arch1"><span>En attente d'une aventure</span></h2>
            <h2 class="text-white-50 mx-auto mt-2 mb-5 arch2" style="display:none;"><span>Aventure en cours</span></h2>
            <div id="panelQuestion">

            </div>

            <div class="minuteur" style="display:none;color:#fff;">
                <ul style="padding-inline-start: 0px;">
                    <li class="sec"><span id="seconds">10</span>Secondes</li>
                </ul>
            </div>
        </div>
    </div>
</header>

<!-- Footer -->
<footer class="bg-black small text-center text-white-50">
    <div class="container">
        Copyright &copy; CNAM 2019
    </div>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for this template -->
<script src="js/grayscale.min.js"></script>
<script type="text/javascript" src="js/monscript.js"></script>


</body>

</html>
