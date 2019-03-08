<?php session_start();  ?>
<html>
<head>
    <title>cc </title>
</head>
<body>
<?php
if(!isset($_SESSION['user']))
{
    header("Location:Login.php");
}
echo $_SESSION['user'];
echo " => login ok"; echo "<br>";
echo "<a href='logout.php'> se deco</a> ";
?>
</body>
</html>